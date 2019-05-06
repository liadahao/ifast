package com.cms.controller;


import java.util.Arrays;

import com.cms.core.TagConstant;
import com.cms.domain.ArticleDO;
import com.cms.domain.EventDO;
import com.cms.domain.ProductDO;
import com.cms.service.ArticleService;
import com.cms.service.EventService;
import com.cms.service.ProductService;
import com.ifast.sys.domain.UserDO;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
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
import com.cms.domain.MessageDO;
import com.cms.service.MessageService;
import com.ifast.common.utils.Result;

/**
 * <pre>
 *
 * </pre>
 * <small> 2019-04-29 22:08:03 | Aron</small>
 */
@Controller
@RequestMapping("/cms/message")
public class MessageController extends AdminBaseController {
    @Autowired
    private MessageService messageService;
    @Autowired
    ArticleService articleService;
    @Autowired
    ProductService productService;
    @Autowired
    EventService eventService;

    @GetMapping()
    @RequiresPermissions("cms:message:message")
    String Message() {
        return "cms/message/message";
    }

    @ResponseBody
    @GetMapping("/list")
    @RequiresPermissions("cms:message:message")
    public Result<Page<MessageDO>> list(MessageDO messageDTO) {
        Wrapper<MessageDO> wrapper = new EntityWrapper<MessageDO>().orderBy("`status`", false);
//        UserDO user = getUser();
        Subject user = getSubjct();
        if (!user.hasRole("adminRole")) {
            wrapper.eq("userid", getUserId());
        }
        Page<MessageDO> page = messageService.selectPage(getPage(MessageDO.class), wrapper);
        return Result.ok(page);
    }


    @GetMapping("/edit/{id}")
    @RequiresPermissions("cms:message:edit")
    String edit(@PathVariable("id") Integer id, Model model) {
        MessageDO message = messageService.selectById(id);
        model.addAttribute("message", message);
        return "cms/message/edit";
    }

    @Log("修改")
    @ResponseBody
    @RequestMapping("/update")
    @RequiresPermissions("cms:message:edit")
    public Result<String> update(MessageDO message) {
        if (message.getType() == TagConstant.ARTICLE.type) {
            ArticleDO articleDO = new ArticleDO();
            articleDO.setId(message.getTypeid());
            articleDO.setStatus(message.getStatus());
            articleService.updateById(articleDO);
        }
        if (message.getType() == TagConstant.EVNENT.type) {
            EventDO eventDO = new EventDO();
            eventDO.setId(message.getTypeid());
            eventDO.setStatus(message.getStatus());
            eventService.updateById(eventDO);
        }
        if (message.getType() == TagConstant.PRODUCT.type) {
            ProductDO productDO = new ProductDO();
            productDO.setId(message.getTypeid());
            productDO.setStatus(message.getStatus());
            productService.updateById(productDO);
        }
        boolean update = messageService.updateById(message);
        return update ? Result.ok() : Result.fail();
    }

    @Log("删除")
    @PostMapping("/remove")
    @ResponseBody
    @RequiresPermissions("cms:message:remove")
    public Result<String> remove(Integer id) {
        messageService.deleteById(id);
        return Result.ok();
    }

    @Log("批量删除")
    @PostMapping("/batchRemove")
    @ResponseBody
    @RequiresPermissions("cms:message:batchRemove")
    public Result<String> remove(@RequestParam("ids[]") Integer[] ids) {
        messageService.deleteBatchIds(Arrays.asList(ids));
        return Result.ok();
    }

}
