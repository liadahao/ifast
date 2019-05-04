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

    @GetMapping({"/", ""})
    String welcome(Model model) {
        return "redirect:/page/index";
    }

    @RequestMapping("/index")
    public String index(Model model) {
        return "redirect:/page/index";
    }

    @RequestMapping("/shop")
    public String shop(Model model) {
        Wrapper<ProductDO> wrapper = new EntityWrapper<ProductDO>()
                .orderBy("`order`", false)
                .eq("status", ProductDO.ON_SHELVES).last("limit 1");
        ProductDO productDO = productService.selectOne(wrapper);
        model.addAttribute("product", productDO);
        return "/cms/front/pages/shop";
    }

    @RequestMapping("/shop/{id}")
    public String productDetail(@PathVariable Integer id, Model model) {
        ProductDO productDO = productService.selectById(id);
        model.addAttribute("product", productDO);
        return "/cms/front/pages/shop";

    }

    @ResponseBody
    @GetMapping("/shop/{id}/maylike")
    public Result<Page<ProductDO>> maylike(@PathVariable Integer id, Model model) {
        Wrapper<ProductDO> wrapper = new EntityWrapper<ProductDO>().orderBy("`order`", false);
        wrapper.ne("id", id).eq("status", ProductDO.ON_SHELVES);
        int pageNumber = getParaToInt("pageNumber", 1);
        int pageSize = getParaToInt("pageSize", 5);
        Page<ProductDO> page = new Page<>(pageNumber, pageSize);
        page = productService.selectPage(page, wrapper);
        return Result.ok(page);
    }

    @RequestMapping("/page/{name}")
    public String website(@PathVariable String name, Integer type, Model model) {
        Wrapper<NavDO> wrapper;
        if (type != null) {
            wrapper = new EntityWrapper<NavDO>().eq("type", type);
        } else {
            wrapper = new EntityWrapper<NavDO>().eq("name", name);
        }
        NavDO navDO = navService.selectOne(wrapper);
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
                    .eq("status", ProductDO.ON_SHELVES).last("limit 1");
            ProductDO productDO = productService.selectOne(productDOWrapper);
            model.addAttribute("product", productDO);
        } else if ("gallery".equals(name)) {
            Wrapper<GalleryDO> galleryDOWrapper = new EntityWrapper<GalleryDO>().orderBy("weight", false);
            List<GalleryDO> galleryDOList = galleryService.selectList(galleryDOWrapper);
            model.addAttribute("data", galleryDOList);
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
}
