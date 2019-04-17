package com.cms.controller;


import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.cms.core.HtmlConstant;
import com.cms.domain.NavVo;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.formula.functions.Na;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.ifast.common.annotation.Log;
import com.ifast.common.base.AdminBaseController;
import com.cms.domain.NavDO;
import com.cms.service.NavService;
import com.ifast.common.utils.Result;

/**
 * <pre>
 *
 * </pre>
 * <small> 2019-04-08 23:53:56 | Aron</small>
 */
@Controller
@RequestMapping("/cms/nav")
public class NavController extends AdminBaseController {
    @Autowired
    private NavService navService;

    @GetMapping()
    @RequiresPermissions("cms:nav:nav")
    String Nav() {
        return "cms/nav/nav";
    }

    @ResponseBody
    @GetMapping("/list")
    @RequiresPermissions("cms:nav:nav")
    public Result<Page<NavDO>> list(NavDO navDTO) {
        Wrapper<NavDO> wrapper = new EntityWrapper<NavDO>().orderBy("id", false);
        Page<NavDO> page = navService.selectPage(getPage(NavDO.class), wrapper);
        return Result.ok(page);
    }

    @GetMapping("/add")
    @RequiresPermissions("cms:nav:add")
    String add() {
        return "cms/nav/add";
    }

    @GetMapping("/add/{type}")
    @RequiresPermissions("cms:nav:add")
    String add(@PathVariable("type") Integer type, Model model) {
        String suffix = HtmlConstant.getHtml(type);
        NavDO navDO = new NavDO();
        navDO.setType(type);
        model.addAttribute("nav", navDO);
        return "cms/nav/" + suffix;
    }

    @GetMapping("/edit/{id}")
    @RequiresPermissions("cms:nav:edit")
    String edit(@PathVariable("id") Long id, Model model) {
        NavDO nav = navService.selectById(id);
        String suffix = HtmlConstant.getHtml(nav.getType());
        NavVo navVo = new NavVo();
        BeanUtils.copyProperties(nav, navVo, "content");
        Map<String, Object> map = JSON.parseObject(nav.getContent(), Map.class);
        if (map != null) {
            navVo.setContent(map);
        } else {
            navVo.setContent(new HashMap<>());
        }
        model.addAttribute("nav", navVo);
        return "cms/nav/" + suffix;
    }

    @Log("添加")
    @ResponseBody
    @PostMapping("/save")
    @RequiresPermissions("cms:nav:add")
    public Result<String> save(@RequestBody NavDO nav) {
        if (StringUtils.isEmpty(nav.getIsShowFlag())) {
            nav.setIsshow(0);
        }
        navService.insert(nav);
        return Result.ok();
    }

    @Log("修改")
    @ResponseBody
    @RequestMapping("/update")
    @RequiresPermissions("cms:nav:edit")
    public Result<String> update(NavDO nav) {
        if (StringUtils.isEmpty(nav.getIsShowFlag())) {
            nav.setIsshow(0);
        }
        boolean update = navService.updateById(nav);
        return update ? Result.ok() : Result.fail();
    }

    @Log("删除")
    @PostMapping("/remove")
    @ResponseBody
    @RequiresPermissions("cms:nav:remove")
    public Result<String> remove(Long id) {
        navService.deleteById(id);
        return Result.ok();
    }

    @Log("批量删除")
    @PostMapping("/batchRemove")
    @ResponseBody
    @RequiresPermissions("cms:nav:batchRemove")
    public Result<String> remove(@RequestParam("ids[]") Long[] ids) {
        navService.deleteBatchIds(Arrays.asList(ids));
        return Result.ok();
    }

}
