package com.cms.controller;


import java.util.Arrays;

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
import com.cms.domain.ArticleDO;
import com.cms.service.ArticleService;
import com.ifast.common.utils.Result;

/**
 * <pre>
 * 文章表
 * </pre>
 * <small> 2019-04-08 18:31:25 | Aron</small>
 */
@Controller
@RequestMapping("/cms/article")
public class ArticleController extends AdminBaseController {
    @Autowired
    private ArticleService articleService;

    @GetMapping()
    @RequiresPermissions("cms:article:article")
    String Article() {
        return "cms/article/article";
    }

    @ResponseBody
    @GetMapping("/list")
    public Result<Page<ArticleDO>> list(ArticleDO articleDTO) {
        Wrapper<ArticleDO> wrapper = new EntityWrapper<ArticleDO>().orderBy("id", false);
        Page<ArticleDO> page = articleService.selectPage(getPage(ArticleDO.class), wrapper);
        return Result.ok(page);
    }

    @GetMapping("/add")
    @RequiresPermissions("cms:article:add")
    String add() {
        return "cms/article/add";
    }

    @GetMapping("/edit/{id}")
    @RequiresPermissions("cms:article:edit")
    String edit(@PathVariable("id") Integer id, Model model) {
        ArticleDO article = articleService.selectById(id);
        model.addAttribute("article", article);
        return "cms/article/edit";
    }

    @Log("添加文章表")
    @ResponseBody
    @PostMapping("/save")
    @RequiresPermissions("cms:article:add")
    public Result<String> save(ArticleDO article) {
        if (StringUtils.isEmpty(article.getContent())) {
            return Result.fail();
        }
        articleService.insert(article);
        return Result.ok();
    }

    @Log("修改文章表")
    @ResponseBody
    @RequestMapping("/update")
    @RequiresPermissions("cms:article:edit")
    public Result<String> update(ArticleDO article) {
        boolean update = articleService.updateById(article);
        return update ? Result.ok() : Result.fail();
    }

    @Log("删除文章表")
    @PostMapping("/remove")
    @ResponseBody
    @RequiresPermissions("cms:article:remove")
    public Result<String> remove(Integer id) {
        articleService.deleteById(id);
        return Result.ok();
    }

    @Log("批量删除文章表")
    @PostMapping("/batchRemove")
    @ResponseBody
    @RequiresPermissions("cms:article:batchRemove")
    public Result<String> remove(@RequestParam("ids[]") Integer[] ids) {
        articleService.deleteBatchIds(Arrays.asList(ids));
        return Result.ok();
    }

}
