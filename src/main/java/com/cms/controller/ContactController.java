package com.cms.controller;


import java.util.Arrays;
import java.util.Date;

import com.ifast.common.utils.IPUtils;
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
import com.cms.domain.ContactDO;
import com.cms.service.ContactService;
import com.ifast.common.utils.Result;

import javax.servlet.http.HttpServletRequest;

/**
 * <pre>
 *
 * </pre>
 * <small> 2019-04-24 23:54:15 | Aron</small>
 */
@Controller
@RequestMapping("/cms/contact")
public class ContactController extends AdminBaseController {
    @Autowired
    private ContactService contactService;

    @GetMapping()
    @RequiresPermissions("cms:contact:contact")
    String Contact() {
        return "cms/contact/contact";
    }

    @ResponseBody
    @GetMapping("/list")
    @RequiresPermissions("cms:contact:contact")
    public Result<Page<ContactDO>> list(ContactDO contactDTO) {
        Wrapper<ContactDO> wrapper = new EntityWrapper<ContactDO>().orderBy("id", false);
        if (!StringUtils.isEmpty(contactDTO.getName())) {
            wrapper.eq("name", contactDTO.getName());
        }
        Page<ContactDO> page = contactService.selectPage(getPage(ContactDO.class), wrapper);
        return Result.ok(page);
    }

    @GetMapping("/add")
    @RequiresPermissions("cms:contact:add")
    String add() {
        return "cms/contact/add";
    }

    @GetMapping("/edit/{id}")
    @RequiresPermissions("cms:contact:edit")
    String edit(@PathVariable("id") Integer id, Model model) {
        ContactDO contact = contactService.selectById(id);
        model.addAttribute("contact", contact);
        return "cms/contact/edit";
    }

    @Log("添加")
    @ResponseBody
    @PostMapping("/save")
    public Result<String> save(ContactDO contact, HttpServletRequest request) {
        String ip = IPUtils.getIpAddr(request);
        contact.setCreatetime(new Date());
        contact.setIp(ip);
        contactService.insert(contact);
        return Result.ok();
    }

    @Log("修改")
    @ResponseBody
    @RequestMapping("/update")
    @RequiresPermissions("cms:contact:edit")
    public Result<String> update(ContactDO contact) {
        boolean update = contactService.updateById(contact);
        return update ? Result.ok() : Result.fail();
    }

    @Log("删除")
    @PostMapping("/remove")
    @ResponseBody
    @RequiresPermissions("cms:contact:remove")
    public Result<String> remove(Integer id) {
        contactService.deleteById(id);
        return Result.ok();
    }

    @Log("批量删除")
    @PostMapping("/batchRemove")
    @ResponseBody
    @RequiresPermissions("cms:contact:batchRemove")
    public Result<String> remove(@RequestParam("ids[]") Integer[] ids) {
        contactService.deleteBatchIds(Arrays.asList(ids));
        return Result.ok();
    }

}
