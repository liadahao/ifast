package com.cms.controller;


import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.cms.core.TagConstant;
import com.cms.domain.*;
import com.cms.service.*;
import com.ifast.common.annotation.Log;
import com.ifast.common.base.AdminBaseController;
import com.ifast.common.utils.Result;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

/**
 * <pre>
 *
 * </pre>
 * <small> 2019-04-08 22:45:12 | Aron</small>
 */
@Controller
@RequestMapping("/cms/product")
public class ProductController extends AdminBaseController {
    @Autowired
    private ProductService productService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    TagService tagService;
    @Autowired
    ProductTagService productTagService;
    @Autowired
    MessageService messageService;

    @GetMapping()
    @RequiresPermissions("cms:product:product")
    String Product() {
        return "cms/product/product";
    }

    @ResponseBody
    @GetMapping("/list")
    @RequiresPermissions("cms:product:product")
    public Result<Page<ProductDO>> list(ProductDO productDTO) {
        Wrapper<ProductDO> wrapper = new EntityWrapper<ProductDO>().orderBy("id", false);
        if (!StringUtils.isEmpty(productDTO.getName())) {
            wrapper.like("name", productDTO.getName());
        }
        if (productDTO.getStatus() != null) {
            wrapper.eq("status", productDTO.getStatus());
        }
        Page<ProductDO> page = productService.selectPage(getPage(ProductDO.class), wrapper);
        return Result.ok(page);
    }

    @GetMapping("/add")
    @RequiresPermissions("cms:product:add")
    String add(Model model) {
        List<CategoryDO> categoryList = categoryService.selectList(new EntityWrapper<>());
        model.addAttribute("categoryList", categoryList);
        return "cms/product/add";
    }

    @GetMapping("/edit/{id}")
    @RequiresPermissions("cms:product:edit")
    String edit(@PathVariable("id") Integer id, Model model) {
        ProductDO product = productService.selectById(id);
        if (!StringUtils.isEmpty(product.getTags())) {
            String[] tags = product.getTags().split(",");
            List<String> tagList = Arrays.asList(tags);
            product.setTagList(tagList);
        }
        List<String> imageList = new LinkedList<>();
        if (!StringUtils.isEmpty(product.getImage1())) {
            imageList.add(product.getImage1());
        }
        if (!StringUtils.isEmpty(product.getImage2())) {
            imageList.add(product.getImage2());
        }
        if (!StringUtils.isEmpty(product.getImage3())) {
            imageList.add(product.getImage3());
        }
        if (!StringUtils.isEmpty(product.getImage4())) {
            imageList.add(product.getImage4());
        }
        if (!StringUtils.isEmpty(product.getImage5())) {
            imageList.add(product.getImage5());
        }
        product.setImage(imageList);
        model.addAttribute("product", product);
        List<CategoryDO> categoryList = categoryService.selectList(new EntityWrapper<>());
        model.addAttribute("categoryList", categoryList);
        return "cms/product/edit";
    }

    @Log("添加")
    @ResponseBody
    @PostMapping("/save")
    @RequiresPermissions("cms:product:add")
    public Result save(ProductDO product) {
        if (product.getImage() != null && !product.getImage().isEmpty()) {
            for (int i = 0; i < product.getImage().size(); i++) {
                if (StringUtils.isEmpty(product.getImage().get(i))) {
                    continue;
                }
                if (i == 0) {
                    product.setImage1(product.getImage().get(i));
                }
                if (i == 1) {
                    product.setImage2(product.getImage().get(i));
                }
                if (i == 2) {
                    product.setImage3(product.getImage().get(i));
                }
                if (i == 3) {
                    product.setImage4(product.getImage().get(i));
                }
                if (i == 4) {
                    product.setImage5(product.getImage().get(i));
                }
            }
        }
        if (product.getTagList() != null && !product.getTagList().isEmpty()) {
            product.getTagList().remove("");
            String tag = StringUtils.join(product.getTagList(), ",");
            product.setTags(tag);
        }
        if (product.getCategoryid() != null) {
            CategoryDO categoryDO = categoryService.selectById(product.getCategoryid());
            product.setCategoryName(categoryDO.getName());
        }
        productService.insert(product);
        messageService.saveProduct(product, getUserId());
        for (String tagName : product.getTagList()) {
            if (StringUtils.isEmpty(tagName)) {
                continue;
            }
            EntityWrapper<TagDO> entityWrapper = new EntityWrapper<>();
            entityWrapper.eq("name", tagName).eq("type", TagConstant.PRODUCT.type);
            TagDO tag = tagService.selectOne(entityWrapper);
            if (tag == null) {
                tag = new TagDO();
                tag.setName(tagName);
                tag.setCreatetime(new Date());
                tag.setType(TagConstant.PRODUCT.type);
                tag.setIsenable(1);
                tagService.insert(tag);
            }
            ProductTagDO productTagDO = new ProductTagDO();
            productTagDO.setProductId(product.getId().longValue());
            productTagDO.setTagId(tag.getId());
            productTagService.insert(productTagDO);
        }
        return Result.ok(product.getId());
    }

    @Log("修改")
    @ResponseBody
    @RequestMapping("/update")
    @RequiresPermissions("cms:product:edit")
    public Result update(ProductDO product) {
        if (product.getCategoryid() != null) {
            CategoryDO categoryDO = categoryService.selectById(product.getCategoryid());
            product.setCategoryName(categoryDO.getName());
        }
        if (product.getTagList() != null && !product.getTagList().isEmpty()) {
            product.getTagList().remove("");
            String tag = StringUtils.join(product.getTagList(), ",");
            product.setTags(tag);
        }
        boolean update = productService.updateById(product);
        messageService.saveProduct(product, getUserId());
        EntityWrapper<ProductTagDO> deleteWrapper = new EntityWrapper<>();
        deleteWrapper.eq("productId", product.getId());
        productTagService.delete(deleteWrapper);
        for (String tagName : product.getTagList()) {
            if (StringUtils.isEmpty(tagName)) {
                continue;
            }
            EntityWrapper<TagDO> entityWrapper = new EntityWrapper<>();
            entityWrapper.eq("name", tagName).eq("type", TagConstant.PRODUCT.type);
            TagDO tag = tagService.selectOne(entityWrapper);
            if (tag == null) {
                tag = new TagDO();
                tag.setName(tagName);
                tag.setCreatetime(new Date());
                tag.setType(TagConstant.PRODUCT.type);
                tag.setIsenable(1);
                tagService.insert(tag);
            }
            EntityWrapper<ProductTagDO> productTagDOEntityWrapper = new EntityWrapper<>();
            productTagDOEntityWrapper.eq("productId", product.getId())
                    .eq("tagId", tag.getId());
            ProductTagDO productTagDO = productTagService.selectOne(productTagDOEntityWrapper);
            if (productTagDO == null) {
                productTagDO = new ProductTagDO();
                productTagDO.setProductId(product.getId().longValue());
                productTagDO.setTagId(tag.getId());
                productTagService.insert(productTagDO);
            }
        }
        return update ? Result.ok(product.getId()) : Result.fail();
    }

    @Log("删除")
    @PostMapping("/remove")
    @ResponseBody
    @RequiresPermissions("cms:product:remove")
    public Result<String> remove(Integer id) {
        productService.deleteById(id);
        return Result.ok();
    }

    @Log("批量删除")
    @PostMapping("/batchRemove")
    @ResponseBody
    @RequiresPermissions("cms:product:batchRemove")
    public Result<String> remove(@RequestParam("ids[]") Integer[] ids) {
        productService.deleteBatchIds(Arrays.asList(ids));
        return Result.ok();
    }

}
