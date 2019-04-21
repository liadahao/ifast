package com.cms.controller;


import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.cms.core.TagConstant;
import com.cms.domain.ArticleDO;
import com.cms.domain.ArticleTagDO;
import com.cms.domain.TagDO;
import com.cms.service.ArticleService;
import com.cms.service.ArticleTagService;
import com.cms.service.TagService;
import com.ifast.common.annotation.Log;
import com.ifast.common.base.AdminBaseController;
import com.ifast.common.utils.Result;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

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
    @Autowired
    private TagService tagService;
    @Autowired
    private ArticleTagService articleTagService;

    @GetMapping()
    @RequiresPermissions("cms:article:article")
    String Article() {
        return "cms/article/article";
    }

    @ResponseBody
    @GetMapping("/list")
    public Result<Page<ArticleDO>> list(ArticleDO articleDTO, Date startTime, Date endTime) {
        Wrapper<ArticleDO> wrapper = new EntityWrapper<ArticleDO>().orderBy("id", false);

        if (articleDTO.getId() != null) {
            wrapper.eq("id", articleDTO.getId().toString());
        } else {
            if (!StringUtils.isEmpty(articleDTO.getTitle())) {
                wrapper.like("title", articleDTO.getTitle());
            }
            if (startTime != null) {
                wrapper.ge("createTime", startTime);
            }
            if (endTime != null) {
                wrapper.le("createTime", endTime);
            }
        }
        Page<ArticleDO> page = articleService.selectPage(getPage(ArticleDO.class), wrapper);
        return Result.ok(page);
    }

    @GetMapping("/add")
    @RequiresPermissions("cms:article:add")
    String add() {
        return "cms/article/add";
    }

    @GetMapping("/edit")
    String editPage(@RequestParam Integer id, Model model) {
        model.addAttribute("id", id);
        return "cms/article/edit";
    }

    @GetMapping("/edit/{id}")
    @ResponseBody
    ArticleDO edit(@PathVariable("id") Integer id) {
        ArticleDO article = articleService.selectById(id);
        List<Map<String, String>> mapList = new LinkedList<>();
        if (!StringUtils.isEmpty(article.getFacebook())) {
            Map<String, String> map = JSON.parseObject(article.getFacebook(), Map.class);
            mapList.add(map);
        }
        if (!StringUtils.isEmpty(article.getLinkedin())) {
            Map<String, String> map = JSON.parseObject(article.getLinkedin(), Map.class);
            mapList.add(map);
        }
        if (!StringUtils.isEmpty(article.getTwitter())) {
            Map<String, String> map = JSON.parseObject(article.getTwitter(), Map.class);
            mapList.add(map);
        }
        if (!StringUtils.isEmpty(article.getMedium())) {
            Map<String, String> map = JSON.parseObject(article.getMedium(), Map.class);
            mapList.add(map);
        }
        if (!StringUtils.isEmpty(article.getInstagram())) {
            Map<String, String> map = JSON.parseObject(article.getInstagram(), Map.class);
            mapList.add(map);
        }
        article.setSocial(mapList);
        List<TagDO> tagList = tagService.selectByArticleId(article.getId());
        List<String> tagNameList = tagList.stream().map(TagDO::getName).collect(Collectors.toList());
        article.setTag(tagNameList);
        return article;
    }

    @Log("添加文章表")
    @ResponseBody
    @PostMapping("/save")
    @RequiresPermissions("cms:article:add")
    public Result<String> save(ArticleDO article) {
        if (StringUtils.isEmpty(article.getContent())) {
            return Result.fail();
        }
        if (article.getCreateTime() == null) {
            article.setCreateTime(new Date());
        }
        if (article.getSocial() != null && !article.getSocial().isEmpty()) {
            for (Map<String, String> map : article.getSocial()) {
                String type = map.get("type");
                if (!StringUtils.isEmpty(type)) {
                    if ("facebook".equalsIgnoreCase(type)) {
                        article.setFacebook(JSON.toJSONString(map));
                    }
                    if ("linkedin".equalsIgnoreCase(type)) {
                        article.setLinkedin(JSON.toJSONString(map));
                    }
                    if ("twitter".equalsIgnoreCase(type)) {
                        article.setTwitter(JSON.toJSONString(map));
                    }
                    if ("medium".equalsIgnoreCase(type)) {
                        article.setMedium(JSON.toJSONString(map));
                    }
                    if ("instagram".equalsIgnoreCase(type)) {
                        article.setInstagram(JSON.toJSONString(map));
                    }
                }
            }
        }
        article.setCreateUserName(getUsername());
        articleService.insert(article);
        if (article.getTag() != null && !article.getTag().isEmpty()) {
            for (String tagName : article.getTag()) {
                if (StringUtils.isEmpty(tagName)) {
                    continue;
                }
                EntityWrapper<TagDO> entityWrapper = new EntityWrapper<>();
                entityWrapper.eq("name", tagName);
                TagDO tag = tagService.selectOne(entityWrapper);
                if (tag == null) {
                    tag = new TagDO();
                    tag.setName(tagName);
                    tag.setCreatetime(new Date());
                    tag.setType(TagConstant.ARTICLE.type);
                    tag.setIsenable(1);
                    tagService.insert(tag);
                }
                EntityWrapper<ArticleTagDO> articleTagDOEntityWrapper = new EntityWrapper<>();
                articleTagDOEntityWrapper.eq("articleId", article.getId())
                        .eq("tagId", tag.getId());
                ArticleTagDO articleTagDO = articleTagService.selectOne(articleTagDOEntityWrapper);
                if (articleTagDO == null) {
                    articleTagDO = new ArticleTagDO();
                    articleTagDO.setArticleId(article.getId().longValue());
                    articleTagDO.setTagId(tag.getId());
                    articleTagService.insert(articleTagDO);
                }
            }
        }
        return Result.ok();
    }

    @Log("修改文章表")
    @ResponseBody
    @RequestMapping("/update")
    @RequiresPermissions("cms:article:edit")
    public Result<String> update(ArticleDO article) {
        if (article.getSocial() != null && !article.getSocial().isEmpty()) {
            for (Map<String, String> map : article.getSocial()) {
                String type = map.get("type");
                if (!StringUtils.isEmpty(type)) {
                    if ("facebook".equalsIgnoreCase(type)) {
                        article.setFacebook(JSON.toJSONString(map));
                    }
                    if ("linkedin".equalsIgnoreCase(type)) {
                        article.setLinkedin(JSON.toJSONString(map));
                    }
                    if ("twitter".equalsIgnoreCase(type)) {
                        article.setTwitter(JSON.toJSONString(map));
                    }
                    if ("medium".equalsIgnoreCase(type)) {
                        article.setMedium(JSON.toJSONString(map));
                    }
                    if ("instagram".equalsIgnoreCase(type)) {
                        article.setInstagram(JSON.toJSONString(map));
                    }
                }
            }
        }
        boolean update = articleService.updateById(article);
        EntityWrapper<ArticleTagDO> articleTagDOEntityWrapper = new EntityWrapper<>();
        articleTagDOEntityWrapper.eq("articleId", article.getId());
        articleTagService.delete(articleTagDOEntityWrapper);
        if (article.getTag() != null && !article.getTag().isEmpty()) {
            for (String tagName : article.getTag()) {
                if (StringUtils.isEmpty(tagName)) {
                    continue;
                }
                EntityWrapper<TagDO> entityWrapper = new EntityWrapper<>();
                entityWrapper.eq("name", tagName);
                TagDO tag = tagService.selectOne(entityWrapper);
                if (tag == null) {
                    tag = new TagDO();
                    tag.setName(tagName);
                    tag.setCreatetime(new Date());
                    tag.setType(TagConstant.ARTICLE.type);
                    tag.setIsenable(1);
                    tagService.insert(tag);
                }
                articleTagDOEntityWrapper = new EntityWrapper<>();
                articleTagDOEntityWrapper.eq("articleId", article.getId())
                        .eq("tagId", tag.getId());
                ArticleTagDO articleTagDO = articleTagService.selectOne(articleTagDOEntityWrapper);
                if (articleTagDO == null) {
                    articleTagDO = new ArticleTagDO();
                    articleTagDO.setArticleId(article.getId().longValue());
                    articleTagDO.setTagId(tag.getId());
                    articleTagService.insert(articleTagDO);
                }
            }
        }
        return update ? Result.ok() : Result.fail();
    }

    @Log("删除文章表")
    @PostMapping("/remove")
    @ResponseBody
    @RequiresPermissions("cms:article:remove")
    public Result<String> remove(Integer id) {
        articleService.deleteById(id);
        EntityWrapper<ArticleTagDO> articleTagDOEntityWrapper = new EntityWrapper<>();
        articleTagDOEntityWrapper.eq("articleId", id);
        articleTagService.delete(articleTagDOEntityWrapper);
        return Result.ok();
    }

    @Log("批量删除文章表")
    @PostMapping("/batchRemove")
    @ResponseBody
    @RequiresPermissions("cms:article:batchRemove")
    public Result<String> remove(@RequestParam("ids[]") Integer[] ids) {
        articleService.deleteBatchIds(Arrays.asList(ids));
        for (Integer id : ids) {
            EntityWrapper<ArticleTagDO> articleTagDOEntityWrapper = new EntityWrapper<>();
            articleTagDOEntityWrapper.eq("articleId", id);
            articleTagService.delete(articleTagDOEntityWrapper);
        }
        return Result.ok();
    }

}
