package com.cms.controller;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.cms.core.HtmlConstant;
import com.cms.domain.*;
import com.cms.service.ArticleService;
import com.cms.service.EventService;
import com.cms.service.NavService;
import com.ifast.common.utils.HttpContextUtils;
import com.ifast.common.utils.Result;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
public class FrontController {

    @Autowired
    NavService navService;

    @Autowired
    private ArticleService articleService;
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
        }else{
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
        return Result.ok(page);
    }

    @GetMapping("/article/{id}")
    public String articleDetail(@PathVariable Integer id, Model model) {
        ArticleDO article = articleService.selectById(id);
        model.addAttribute("article", article);
        return "/cms/front/pages/articleDetail";
    }

    @ResponseBody
    @GetMapping("/event/list")
    public Result<Page<EventDO>> eventList() {
        Wrapper<EventDO> wrapper = new EntityWrapper<EventDO>().orderBy("id", false);
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
