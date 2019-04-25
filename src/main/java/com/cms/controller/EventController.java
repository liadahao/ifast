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
import com.cms.domain.EventDO;
import com.cms.service.EventService;
import com.ifast.common.utils.Result;

/**
 * <pre>
 * 文章表
 * </pre>
 * <small> 2019-04-08 22:45:12 | Aron</small>
 */
@Controller
@RequestMapping("/cms/event")
public class EventController extends AdminBaseController {
    @Autowired
    private EventService eventService;

    @GetMapping()
    @RequiresPermissions("cms:event:event")
    String Event() {
        return "cms/event/event";
    }

    @ResponseBody
    @GetMapping("/list")
    @RequiresPermissions("cms:event:event")
    public Result<Page<EventDO>> list(EventDO eventDTO) {
        Wrapper<EventDO> wrapper = new EntityWrapper<EventDO>().orderBy("id", false);
        if (eventDTO.getId() != null) {
            wrapper.eq("id", eventDTO.getId().toString());
        } else {
            if (!StringUtils.isEmpty(eventDTO.getTitle())) {
                wrapper.like("title", eventDTO.getTitle());
            }
            if (eventDTO.getStarttime() != null) {
                wrapper.ge("startTime", eventDTO.getStarttime());
            }
            if (eventDTO.getEndtime() != null) {
                wrapper.le("endTime", eventDTO.getEndtime());
            }
        }
        Page<EventDO> page = eventService.selectPage(getPage(EventDO.class), wrapper);
        return Result.ok(page);
    }

    @GetMapping("/add")
    @RequiresPermissions("cms:event:add")
    String add() {
        return "cms/event/add";
    }

    @GetMapping("/edit/{id}")
    @RequiresPermissions("cms:event:edit")
    String edit(@PathVariable("id") Integer id, Model model) {
        EventDO event = eventService.selectById(id);
        model.addAttribute("event", event);
        return "cms/event/edit";
    }

    @Log("添加文章表")
    @ResponseBody
    @PostMapping("/save")
    @RequiresPermissions("cms:event:add")
    public Result<String> save(EventDO event) {
        event.setCreatetime(new Date());
        eventService.insert(event);
        return Result.ok();
    }

    @Log("修改文章表")
    @ResponseBody
    @RequestMapping("/update")
    @RequiresPermissions("cms:event:edit")
    public Result<String> update(EventDO event) {
        event.setModifytime(new Date());
        boolean update = eventService.updateById(event);
        return update ? Result.ok() : Result.fail();
    }

    @Log("删除文章表")
    @PostMapping("/remove")
    @ResponseBody
    @RequiresPermissions("cms:event:remove")
    public Result<String> remove(Integer id) {
        eventService.deleteById(id);
        return Result.ok();
    }

    @Log("批量删除文章表")
    @PostMapping("/batchRemove")
    @ResponseBody
    @RequiresPermissions("cms:event:batchRemove")
    public Result<String> remove(@RequestParam("ids[]") Integer[] ids) {
        eventService.deleteBatchIds(Arrays.asList(ids));
        return Result.ok();
    }

}
