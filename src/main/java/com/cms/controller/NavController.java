package com.cms.controller;


import java.util.Arrays;

import com.cms.core.HtmlConstant;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
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

    @GetMapping("/add/{suffix}")
    @RequiresPermissions("cms:nav:add")
    String add(@PathVariable("suffix") String suffix) {
        return "cms/nav/" + suffix;
    }

    @GetMapping("/add/seo")
    @RequiresPermissions("cms:nav:add")
    String addSeo() {
        return "cms/nav/seo";
    }

    @GetMapping("/edit/{id}")
    @RequiresPermissions("cms:nav:edit")
    String edit(@PathVariable("id") Long id, Model model) {
        NavDO nav = navService.selectById(id);
        model.addAttribute("nav", nav);
        return "cms/nav/edit";
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
