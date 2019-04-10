package com.cms.controller;


import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.cms.domain.LinkDO;
import com.cms.service.LinkService;
import com.ifast.common.annotation.Log;
import com.ifast.common.base.AdminBaseController;
import com.ifast.common.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;

/**
 * <pre>
 *
 * </pre>
 * <small> 2019-04-11 00:02:07 | Aron</small>
 */
@Controller
@RequestMapping("/cms/link")
public class LinkController extends AdminBaseController {

    @Autowired
    LinkService linkService;

    @GetMapping()
    String Link() {
        return "cms/link/link";
    }

    @ResponseBody
    @GetMapping("/list")
    public Result<Page<LinkDO>> list(LinkDO linkDTO) {
        Wrapper<LinkDO> wrapper = new EntityWrapper<LinkDO>().orderBy("id", false);
        Page<LinkDO> page = linkService.selectPage(getPage(LinkDO.class), wrapper);
        return Result.ok(page);
    }

    @ResponseBody
    @GetMapping("/list/{navId}")
    public Result<Page<LinkDO>> list(@PathVariable Integer navId) {
        Wrapper<LinkDO> wrapper = new EntityWrapper<LinkDO>().eq("navId", navId).orderBy("id", false);
        Page<LinkDO> page = linkService.selectPage(getPage(LinkDO.class), wrapper);
        return Result.ok(page);
    }

    @GetMapping("/add")
    String add() {
        return "cms/link/add";
    }

    @GetMapping("/edit/{id}")
    String edit(@PathVariable("id") Integer id, Model model) {
        LinkDO link = linkService.selectById(id);
        model.addAttribute("link", link);
        return "cms/link/edit";
    }

    @Log("添加")
    @ResponseBody
    @PostMapping("/save")
    public Result<String> save(LinkDO link) {
        linkService.insert(link);
        return Result.ok();
    }

    @Log("修改")
    @ResponseBody
    @RequestMapping("/update")
    public Result<String> update(LinkDO link) {
        boolean update = linkService.updateById(link);
        return update ? Result.ok() : Result.fail();
    }

    @Log("删除")
    @PostMapping("/remove")
    @ResponseBody
    public Result<String> remove(Integer id) {
        linkService.deleteById(id);
        return Result.ok();
    }

    @Log("批量删除")
    @PostMapping("/batchRemove")
    @ResponseBody
    public Result<String> remove(@RequestParam("ids[]") Integer[] ids) {
        linkService.deleteBatchIds(Arrays.asList(ids));
        return Result.ok();
    }

}
