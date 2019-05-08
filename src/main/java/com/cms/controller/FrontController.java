package com.cms.controller;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.cms.core.HtmlConstant;
import com.cms.core.TagConstant;
import com.cms.domain.*;
import com.cms.service.*;
import com.ifast.common.base.AdminBaseController;
import com.ifast.common.domain.ConfigDO;
import com.ifast.common.exception.IFastException;
import com.ifast.common.service.ConfigService;
import com.ifast.common.utils.HttpContextUtils;
import com.ifast.common.utils.Result;
import com.ifast.generator.type.EnumGen;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@Controller
public class FrontController extends AdminBaseController {

    @Autowired
    NavService navService;
    @Autowired
    ArticleTagService articleTagService;
    @Autowired
    private ArticleService articleService;
    @Autowired
    private GalleryService galleryService;
    @Autowired
    TagService tagService;
    @Autowired
    EventService eventService;
    @Autowired
    ConfigService configService;
    @Autowired
    ProductService productService;
    @Autowired
    LinkService linkService;

    @GetMapping({"/", ""})
    String welcome(Model model) {
        return "redirect:/index";
    }

    @RequestMapping("/index")
    public String index(Model model) {
        List<NavDO> navDOList = navService.selectList(new EntityWrapper<NavDO>()
                .eq("isShow", 1).orderBy("`order`", true));
        model.addAttribute("navList", navDOList);
        List<LinkDO> linkDOList = linkService.selectList(new EntityWrapper<LinkDO>()
                .eq("isShow", 1).orderBy("weight", true));
        model.addAttribute("navSocialList", linkDOList);
        // 获取首页设置信息
        List<ConfigDO> configDOList = configService.findListByKvType(EnumGen.KvType.index.getValue());
        Map<String, Object> map = new HashMap<>();
        map.put("content", new HashMap<>());
        for (ConfigDO configDO : configDOList) {
            if (configDO.getK().equals("content")) {
                if (!StringUtils.isEmpty(configDO.getV())) {
                    HashMap<String, Object> contentMap = JSON.parseObject(configDO.getV(), HashMap.class);
                    map.put(configDO.getK(), contentMap);
                }
            } else {
                map.put(configDO.getK(), configDO.getV());
            }
        }
        model.addAttribute("index", map);
        return "/cms/front/pages/index";
    }

    @RequestMapping("/shop")
    public String shop(Model model) {
        List<NavDO> navDOList = navService.selectList(new EntityWrapper<NavDO>()
                .eq("isShow", 1).orderBy("`order`", true));
        model.addAttribute("navList", navDOList);
        List<LinkDO> linkDOList = linkService.selectList(new EntityWrapper<LinkDO>()
                .eq("isShow", 1).orderBy("weight", true));
        model.addAttribute("navSocialList", linkDOList);
        Wrapper<ProductDO> wrapper = new EntityWrapper<ProductDO>()
                .orderBy("`order`", false)
                .eq("type", ProductDO.ON_SHELVES)
                .eq("status", ArticleDO.PUBLISH_STATUS)
                .last("limit 1");
        ProductDO productDO = productService.selectOne(wrapper);
        productDO.setTagList(new ArrayList<>(Arrays.asList(productDO.getTags().split(","))));
        model.addAttribute("product", productDO);
        NavDO navDO = new NavDO();
        navDO.setId(9L);
        model.addAttribute("data", navDO);
        for (int i = 0, len = navDOList.size(); i < len; i++) {
            if (Objects.equals(navDOList.get(i).getId(), navDO.getId())) {
                if (i > 0) {
                    model.addAttribute("prev", navDOList.get(i - 1));
                } else {
                    model.addAttribute("prev", new HashMap<>());
                }
                if (i < (len - 1)) {
                    model.addAttribute("next", navDOList.get(i + 1));
                } else {
                    model.addAttribute("next", new HashMap<>());
                }
            }
        }
        return "/cms/front/pages/shop";
    }

    @RequestMapping("/shop/{id}")
    @ResponseBody
    public ProductDO productDetail(@PathVariable Integer id, Model model) {
        ProductDO productDO = productService.selectById(id);
        productDO.setTagList(new ArrayList<>(Arrays.asList(productDO.getTags().split(","))));
        return productDO;

    }

    @ResponseBody
    @GetMapping("/shop/{id}/maylike")
    public Result<Page<ProductDO>> maylike(@PathVariable Integer id, Model model) {
        Wrapper<ProductDO> wrapper = new EntityWrapper<ProductDO>().orderBy("`order`", false);
        wrapper.ne("id", id)
                .eq("type", ProductDO.ON_SHELVES)
                .eq("status", ArticleDO.PUBLISH_STATUS);
        int pageNumber = getParaToInt("pageNumber", 1);
        int pageSize = getParaToInt("pageSize", 5);
        Page<ProductDO> page = new Page<>(pageNumber, pageSize);
        page = productService.selectPage(page, wrapper);
        return Result.ok(page);
    }

    @RequestMapping("/page")
    public String page(Integer index, Model model) {
        List<NavDO> navDOList = navService.selectList(new EntityWrapper<NavDO>()
                .eq("isShow", 1).orderBy("`order`", true));
        List<NavVo> navVoList = new LinkedList<>();
        for (NavDO navDO : navDOList) {
            NavVo navVo = new NavVo();
            BeanUtils.copyProperties(navDO, navVo);
            if (!StringUtils.isEmpty(navDO.getContent())) {
                Map data = JSON.parseObject(navDO.getContent(), Map.class);
                if (data == null) {
                    data = new HashMap<>();
                }
                navVo.setContent(data);
            }
            navVo.setHtmlSuffix(HtmlConstant.getHtml(navDO.getType()));
            navVoList.add(navVo);
        }
        model.addAttribute("navList", navVoList);
        List<LinkDO> linkDOList = linkService.selectList(new EntityWrapper<LinkDO>()
                .eq("isShow", 1).orderBy("weight", true));
        model.addAttribute("navSocialList", linkDOList);
        // 获取相册信息
        Wrapper<GalleryDO> galleryDOWrapper = new EntityWrapper<GalleryDO>().orderBy("weight", false);
        List<GalleryDO> galleryDOList = galleryService.selectList(galleryDOWrapper);
        model.addAttribute("gallery", galleryDOList);
        // 获取产品信息
        Wrapper<ProductDO> productDOWrapper = new EntityWrapper<ProductDO>()
                .orderBy("`order`", false)
                .eq("type", ProductDO.ON_SHELVES)
                .eq("status", ArticleDO.PUBLISH_STATUS);
        ProductDO productDO = productService.selectOne(productDOWrapper);
        productDO.setTagList(new ArrayList<>(Arrays.asList(productDO.getTags().split(","))));
        model.addAttribute("product", productDO);
        // 获取活动标签信息
        Wrapper<TagDO> tagDOWrapper = new EntityWrapper<TagDO>()
                .eq("type", TagConstant.EVNENT.type)
                .eq("isEnable", 1);
        List<TagDO> list = tagService.selectList(tagDOWrapper);
        model.addAttribute("tags", list);
        // 获取首页设置信息
        List<ConfigDO> configDOList = configService.findListByKvType(EnumGen.KvType.index.getValue());
        Map<String, Object> map = new HashMap<>();
        map.put("content", new HashMap<>());
        for (ConfigDO configDO : configDOList) {
            if (configDO.getK().equals("content")) {
                if (!StringUtils.isEmpty(configDO.getV())) {
                    HashMap<String, Object> contentMap = JSON.parseObject(configDO.getV(), HashMap.class);
                    map.put(configDO.getK(), contentMap);
                }
            } else {
                map.put(configDO.getK(), configDO.getV());
            }
        }

        model.addAttribute("index", map);
        model.addAttribute("currentPage", index);
        return "/cms/front/pages/page";
    }


    @RequestMapping("/page/{name}")
    public String website(@PathVariable String name, Model model) {
        Wrapper<NavDO> wrapper;
        int type = HtmlConstant.getType(name);
        wrapper = new EntityWrapper<NavDO>().eq("type", type);
        NavDO navDO = navService.selectOne(wrapper);
        if (navDO == null) {
            wrapper = new EntityWrapper<NavDO>().eq("url", "/page/" + name);
            navDO = navService.selectOne(wrapper);
        }
        model.addAttribute("data", navDO);
        String suffix = "";
        Map data;
        if (navDO != null && !StringUtils.isEmpty(navDO.getContent())) {
            data = JSON.parseObject(navDO.getContent(), Map.class);
            NavVo navVo = new NavVo();
            BeanUtils.copyProperties(navDO, navVo);
            navVo.setContent(data);
            suffix = HtmlConstant.getHtml(navDO.getType());
            model.addAttribute("data", navVo);
        } else if (HtmlConstant.SHOP.getHtml().equals(name)) {
            Wrapper<ProductDO> productDOWrapper = new EntityWrapper<ProductDO>()
                    .orderBy("`order`", false)
                    .eq("type", ProductDO.ON_SHELVES)
                    .eq("status", ArticleDO.PUBLISH_STATUS);
            ProductDO productDO = productService.selectOne(productDOWrapper);
            productDO.setTagList(new ArrayList<>(Arrays.asList(productDO.getTags().split(","))));
            model.addAttribute("product", productDO);
        } else if ("gallery".equals(name)) {
            Wrapper<GalleryDO> galleryDOWrapper = new EntityWrapper<GalleryDO>().orderBy("weight", false);
            List<GalleryDO> galleryDOList = galleryService.selectList(galleryDOWrapper);
            model.addAttribute("gallery", galleryDOList);
        } else if (HtmlConstant.EVENT.getHtml().equals(name)) {
            Wrapper<TagDO> tagDOWrapper = new EntityWrapper<TagDO>()
                    .eq("type", TagConstant.EVNENT.type)
                    .eq("isEnable", 1);
            List<TagDO> list = tagService.selectList(tagDOWrapper);
            model.addAttribute("tags", list);
        } else {
            Map<String, Object> map = new HashMap<>();
            map.put("content", new HashMap<>());
            model.addAttribute("gallery", new HashMap<>());
        }
        // 获取首页设置信息
        List<ConfigDO> configDOList = configService.findListByKvType(EnumGen.KvType.index.getValue());
        Map<String, Object> map = new HashMap<>();
        map.put("content", new HashMap<>());
        for (ConfigDO configDO : configDOList) {
            if (configDO.getK().equals("content")) {
                if (!StringUtils.isEmpty(configDO.getV())) {
                    HashMap<String, Object> contentMap = JSON.parseObject(configDO.getV(), HashMap.class);
                    map.put(configDO.getK(), contentMap);
                }
            } else {
                map.put(configDO.getK(), configDO.getV());
            }
        }
        model.addAttribute("index", map);
        if (!StringUtils.isEmpty(suffix)) {
            return "/cms/front/pages/" + suffix;
        } else {
            return "/cms/front/pages/" + name;
        }
    }

    @ResponseBody
    @GetMapping("/article/list")
    public Result<Page<ArticleDO>> articleList(String searchTitle, String searchTag) {
        Wrapper<ArticleDO> wrapper = new EntityWrapper<ArticleDO>()
                .orderBy("id", false)
                .eq("status", ArticleDO.PUBLISH_STATUS);
        if (!StringUtils.isEmpty(searchTitle)) {
            wrapper.like("title", searchTitle);
        }
        if (!StringUtils.isEmpty(searchTag)) {
            Page<ArticleDO> page = getPage(ArticleDO.class);
            Wrapper<TagDO> tagDOWrapper = new EntityWrapper<TagDO>().orderBy("id", false);
            tagDOWrapper.eq("name", searchTag).eq("type", TagConstant.ARTICLE.type);
            TagDO tagDO = tagService.selectOne(tagDOWrapper);
            if (tagDO != null) {
                List<ArticleDO> articleList = articleService.selectByTagId(tagDO.getId(), page.getOffsetCurrent(), page.getSize());
                for (ArticleDO articleDO : articleList) {
                    List<TagDO> tagDOList = tagService.selectByArticleId(articleDO.getId());
                    if (tagDOList != null && !tagDOList.isEmpty()) {
                        articleDO.setTag(tagDOList.stream().map(TagDO::getName).collect(Collectors.toList()));
                    } else {
                        articleDO.setTag(new ArrayList<>());
                    }
                }
                page.setRecords(articleList);
            } else {
                return Result.ok(page);
            }
            return Result.ok(page);
        }
        Page<ArticleDO> page = articleService.selectPage(getPage(ArticleDO.class), wrapper);
        for (ArticleDO articleDO : page.getRecords()) {
            List<TagDO> tagDOList = tagService.selectByArticleId(articleDO.getId());
            if (tagDOList != null && !tagDOList.isEmpty()) {
                articleDO.setTag(tagDOList.stream().map(TagDO::getName).collect(Collectors.toList()));
            } else {
                articleDO.setTag(new ArrayList<>());
            }
        }
        return Result.ok(page);
    }

    @ResponseBody
    @GetMapping("/article/{id}/maylike")
    public Result<Page<ArticleDO>> mayLikeArticleList(@PathVariable Integer id) {
        Wrapper<ArticleDO> wrapper = new EntityWrapper<ArticleDO>().orderBy("id", false);
        wrapper.ne("id", id).eq("status", 0);
        int pageNumber = getParaToInt("pageNumber", 1);
        int pageSize = getParaToInt("pageSize", 3);
        Page<ArticleDO> page = new Page<>(pageNumber, pageSize);
        page = articleService.selectPage(page, wrapper);
        for (ArticleDO articleDO : page.getRecords()) {
            List<TagDO> tagDOList = tagService.selectByArticleId(articleDO.getId());
            if (tagDOList != null && !tagDOList.isEmpty()) {
                articleDO.setTag(tagDOList.stream().map(TagDO::getName).collect(Collectors.toList()));
            } else {
                articleDO.setTag(new ArrayList<>());
            }
        }
        return Result.ok(page);
    }

    @GetMapping("/article/{id}")
    public String articleDetail(@PathVariable Integer id, Model model) {
        List<NavDO> navDOList = navService.selectList(new EntityWrapper<NavDO>()
                .eq("isShow", 1).orderBy("`order`", true));
        model.addAttribute("navList", navDOList);
        ArticleDO article = articleService.selectById(id);
        if (article.getStatus() != 0) {
            if ((article.getCreateUserId() != null && article.getCreateUserId() != getUserId().longValue())
                    || !getSubjct().hasRole("adminRole")) {
                throw new IFastException("页面不存在");
            }
        }
        Integer viewCount = article.getViewCount();
        if (viewCount != null && viewCount >= 0) {
            viewCount++;
            article.setViewCount(viewCount);
            articleService.updateById(article);
        }
        List<Map<String, String>> mapList = new LinkedList<>();
        if (!StringUtils.isEmpty(article.getFacebook())) {
            Map<String, String> map = JSON.parseObject(article.getFacebook(), Map.class);
            mapList.add(map);
        }
        if (!StringUtils.isEmpty(article.getLinkedin())) {
            Map<String, String> map = JSON.parseObject(article.getLinkedin(), Map.class);
            mapList.add(map);
        }
        if (!StringUtils.isEmpty(article.getTwitter())) {
            Map<String, String> map = JSON.parseObject(article.getTwitter(), Map.class);
            mapList.add(map);
        }
        if (!StringUtils.isEmpty(article.getMedium())) {
            Map<String, String> map = JSON.parseObject(article.getMedium(), Map.class);
            mapList.add(map);
        }
        if (!StringUtils.isEmpty(article.getInstagram())) {
            Map<String, String> map = JSON.parseObject(article.getInstagram(), Map.class);
            mapList.add(map);
        }
        article.setSocial(mapList);
        List<TagDO> tagList = tagService.selectByArticleId(id);
        model.addAttribute("article", article);
        model.addAttribute("tags", tagList);
        return "/cms/front/pages/articleDetail";
    }

    @PostMapping("/article/{id}/good")
    @ResponseBody
    public Integer good(@PathVariable Integer id) {
        ArticleDO article = articleService.selectById(id);
        Integer goodCount = article.getGoodCount();
        if (goodCount != null && goodCount >= 0) {
            goodCount++;
        } else {
            goodCount = 0;
        }
        article.setGoodCount(goodCount);
        articleService.updateById(article);
        return goodCount;
    }

    @PostMapping("/article/{id}/keepTrying")
    @ResponseBody
    public Integer keepTrying(@PathVariable Integer id) {
        ArticleDO article = articleService.selectById(id);
        Integer keepTryingCount = article.getKeepTryingCount();
        if (keepTryingCount != null && keepTryingCount >= 0) {
            keepTryingCount++;
        } else {
            keepTryingCount = 0;
        }
        article.setKeepTryingCount(keepTryingCount);
        articleService.updateById(article);
        return keepTryingCount;
    }

    @ResponseBody
    @GetMapping("/event/list")
    public Result<Page<EventDO>> eventList(Integer tagId, String starttime) throws ParseException {
        Wrapper<EventDO> wrapper = new EntityWrapper<EventDO>().orderBy("id", false);
        wrapper.eq("status", 0);
        if (tagId != null) {
            wrapper.eq("tagId", tagId);
        }
        if (!StringUtils.isEmpty(starttime)) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
            Date d = sdf.parse(starttime);
            wrapper.ge("startTime", d);
            String s = getLastDayOfMonth(d.getMonth());
            wrapper.le("startTime", s);
        }
        Page<EventDO> page = eventService.selectPage(getPage(EventDO.class), wrapper);
        return Result.ok(page);
    }

    /**
     * <pre>
     * 自动获取分页参数，返回分页对象page
     * </pre>
     *
     * <small> 2018年4月15日 | Aron</small>
     *
     * @param e
     * @return
     */
    public <E> Page<E> getPage(Class<E> e) {
        int pageNumber = getParaToInt("pageNumber", 1);
        int pageSize = getParaToInt("pageSize", 10);
        Page<E> page = new Page<>(pageNumber, pageSize);
        //支持sort、order参数
        String sort = HttpContextUtils.getHttpServletRequest().getParameter("sort");
        if (StringUtils.isNotBlank(sort)) {
            page.setOrderByField(sort);
            String order = HttpContextUtils.getHttpServletRequest().getParameter("order");
            if (StringUtils.isNotBlank(order)) page.setAsc("asc".equalsIgnoreCase(order));
        }
        return page;
    }

    private int getParaToInt(String key, int defalut) {
        String pageNumber = HttpContextUtils.getHttpServletRequest().getParameter(key);
        if (StringUtils.isBlank(pageNumber)) {
            return defalut;
        }
        return Integer.parseInt(pageNumber);
    }

    public String getLastDayOfMonth(int month) {
        Calendar cal = Calendar.getInstance();
        // 设置月份
        cal.set(Calendar.MONTH, month);
        // 获取某月最大天数
        int lastDay = 0;
        //2月的平年瑞年天数
        if (month == 2) {
            lastDay = cal.getLeastMaximum(Calendar.DAY_OF_MONTH);
        } else {
            lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        }
        // 设置日历中月份的最大天数
        cal.set(Calendar.DAY_OF_MONTH, lastDay);
        // 格式化日期
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(cal.getTime()) + " 23:59:59";
    }

}
