package com.cms.controller;


import java.util.Arrays;

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
    public Result<String> save(NavDO nav) {
        navService.insert(nav);
        String idType = nav.getId().toString() + "-" + nav.getType().toString();
        return Result.ok(idType);
    }

    @Log("修改")
    @ResponseBody
    @RequestMapping("/update")
    @RequiresPermissions("cms:nav:edit")
    public Result<String> update(NavDO nav) {
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
