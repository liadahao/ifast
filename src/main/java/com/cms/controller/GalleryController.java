package com.cms.controller;


import java.util.Arrays;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;
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
import com.cms.domain.GalleryDO;
import com.cms.service.GalleryService;
import com.ifast.common.utils.Result;

/**
 * <pre>
 *
 * </pre>
 * <small> 2019-04-27 12:54:58 | Aron</small>
 */
@Controller
@RequestMapping("/cms/gallery")
public class GalleryController extends AdminBaseController {
    @Autowired
    private GalleryService galleryService;

    @GetMapping()
    @RequiresPermissions("cms:gallery:gallery")
    String Gallery() {
        return "cms/gallery/gallery";
    }

    @ResponseBody
    @GetMapping("/list")
    @RequiresPermissions("cms:gallery:gallery")
    public Result<Page<GalleryDO>> list(GalleryDO galleryDTO, Date startTime, Date endTime) {
        Wrapper<GalleryDO> wrapper = new EntityWrapper<GalleryDO>().orderBy("id", false);
        if (galleryDTO.getId() != null) {
            wrapper.eq("id", galleryDTO.getId().toString());
        } else {
            if (startTime != null) {
                wrapper.ge("createTime", startTime);
            }
            if (endTime != null) {
                wrapper.le("createTime", endTime);
            }
        }
        Page<GalleryDO> page = galleryService.selectPage(getPage(GalleryDO.class), wrapper);
        return Result.ok(page);
    }

    @GetMapping("/add")
    @RequiresPermissions("cms:gallery:add")
    String add() {
        return "cms/gallery/add";
    }

    @GetMapping("/edit/{id}")
    @RequiresPermissions("cms:gallery:edit")
    String edit(@PathVariable("id") Integer id, Model model) {
        GalleryDO gallery = galleryService.selectById(id);
        model.addAttribute("gallery", gallery);
        return "cms/gallery/edit";
    }

    @Log("添加")
    @ResponseBody
    @PostMapping("/save")
    @RequiresPermissions("cms:gallery:add")
    public Result<String> save(GalleryDO gallery) {
        gallery.setCreatetime(new Date());
        galleryService.insert(gallery);
        return Result.ok();
    }

    @Log("修改")
    @ResponseBody
    @RequestMapping("/update")
    @RequiresPermissions("cms:gallery:edit")
    public Result<String> update(GalleryDO gallery) {
        boolean update = galleryService.updateById(gallery);
        return update ? Result.ok() : Result.fail();
    }

    @Log("删除")
    @PostMapping("/remove")
    @ResponseBody
    @RequiresPermissions("cms:gallery:remove")
    public Result<String> remove(Integer id) {
        galleryService.deleteById(id);
        return Result.ok();
    }

    @Log("批量删除")
    @PostMapping("/batchRemove")
    @ResponseBody
    @RequiresPermissions("cms:gallery:batchRemove")
    public Result<String> remove(@RequestParam("ids[]") Integer[] ids) {
        galleryService.deleteBatchIds(Arrays.asList(ids));
        return Result.ok();
    }

}
