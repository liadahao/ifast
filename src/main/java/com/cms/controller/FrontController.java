package com.cms.controller;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.cms.core.HtmlConstant;
import com.cms.domain.*;
import com.cms.service.*;
import com.ifast.common.utils.HttpContextUtils;
import com.ifast.common.utils.Result;
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
public class FrontController {

    @Autowired
    NavService navService;

    @Autowired
    private ArticleService articleService;

    @Autowired
    TagService tagService;
    @Autowired
    EventService eventService;

    @GetMapping({"/", ""})
    String welcome(Model model) {
        return "redirect:/page/index";
    }

    @RequestMapping("/index")
    public String index(Model model) {
        return "/cms/front/pages/index";
    }

    @RequestMapping("/page/{name}")
    public String website(@PathVariable String name, Model model) {
        Wrapper<NavDO> wrapper = new EntityWrapper<NavDO>().eq("name", name);
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
        } else {
            Map<String, Object> map = new HashMap<>();
            map.put("content", new HashMap<>());
            model.addAttribute("data", new HashMap<>());
        }
        if (!StringUtils.isEmpty(suffix)) {
            return "/cms/front/pages/" + suffix;
        } else {
            return "/cms/front/pages/" + name;
        }
    }

    @ResponseBody
    @GetMapping("/article/list")
    public Result<Page<ArticleDO>> articleList() {
        Wrapper<ArticleDO> wrapper = new EntityWrapper<ArticleDO>().orderBy("id", false);
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
        wrapper.ne("id", id);
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
    public Result<Page<EventDO>> eventList(Integer type, String starttime) throws ParseException {
        Wrapper<EventDO> wrapper = new EntityWrapper<EventDO>().orderBy("id", false);
        if (type != null) {
            wrapper.eq("type", type);
        }
        if (!StringUtils.isEmpty(starttime)) {
            SimpleDateFormat sdf =new SimpleDateFormat("yyyy-MM" );
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
