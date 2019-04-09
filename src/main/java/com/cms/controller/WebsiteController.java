package com.cms.controller;


import java.util.Arrays;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.cms.domain.NavDO;
import com.cms.service.NavService;
import com.cms.service.WebsiteService;
import com.google.gson.JsonObject;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.ifast.common.annotation.Log;
import com.ifast.common.base.AdminBaseController;
import com.cms.domain.WebsiteDO;
import com.ifast.common.utils.Result;

import javax.servlet.http.HttpServletRequest;

/**
 * <pre>
 *
 * </pre>
 * <small> 2019-04-09 14:53:41 | Aron</small>
 */
@Controller
@RequestMapping("/website")
public class WebsiteController extends AdminBaseController {

    @Autowired
    NavService navService;

    @GetMapping()
    @RequiresPermissions("cms:website:website")
    String Website() {
        return "cms/website/website";
    }

    @GetMapping("/add/{type}")
    @RequiresPermissions("cms:website:add")
    String add(@PathVariable("type") Integer type, Integer navId, Model model) {
        String suffix = "";
        if (type == 2) {
            suffix = "techtour";
        }
        model.addAttribute("navId", navId);
        return "cms/website/" + suffix;
    }

    @GetMapping("/edit/{id}")
    @RequiresPermissions("cms:website:edit")
    String edit(@PathVariable("id") Integer id, Model model) {
//        WebsiteDO website = websiteService.selectById(id);
//        model.addAttribute("website", website);
        return "cms/website/edit";
    }

    @Log("添加")
    @ResponseBody
    @PostMapping("/save")
    @RequiresPermissions("cms:website:add")
    public Result<String> save(Model model, HttpServletRequest request) {
        String navId = request.getParameter("navid");
        NavDO navDO = navService.selectById(navId);
        navDO.setContent(JSON.toJSONString(request.getParameterMap()));
        boolean update = navService.updateById(navDO);
        return update ? Result.ok() : Result.fail();
    }

    @Log("修改")
    @ResponseBody
    @RequestMapping("/update")
    @RequiresPermissions("cms:website:edit")
    public Result<String> update(Model model, HttpServletRequest request) {
        String navId = request.getParameter("navid");
        NavDO navDO = navService.selectById(navId);
        boolean update = navService.updateById(navDO);
        return update ? Result.ok() : Result.fail();
    }


}
