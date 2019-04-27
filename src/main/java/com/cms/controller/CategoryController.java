package com.cms.controller;


import java.util.Arrays;

import com.cms.domain.ProductDO;
import com.cms.service.ProductService;
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
import com.cms.domain.CategoryDO;
import com.cms.service.CategoryService;
import com.ifast.common.utils.Result;

/**
 * <pre>
 *
 * </pre>
 * <small> 2019-04-08 22:45:12 | Aron</small>
 */
@Controller
@RequestMapping("/cms/category")
public class CategoryController extends AdminBaseController {
    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ProductService productService;

    @GetMapping()
    @RequiresPermissions("cms:category:category")
    String Category() {
        return "cms/category/category";
    }

    @ResponseBody
    @GetMapping("/list")
    @RequiresPermissions("cms:category:category")
    public Result<Page<CategoryDO>> list(CategoryDO categoryDTO) {
        Wrapper<CategoryDO> wrapper = new EntityWrapper<CategoryDO>().orderBy("id", false);
        Page<CategoryDO> page = categoryService.selectPage(getPage(CategoryDO.class), wrapper);
        for (CategoryDO categoryDO : page.getRecords()) {
            Wrapper<ProductDO> entityWrapper = new EntityWrapper<ProductDO>()
                    .eq("categoryId", categoryDO.getId())
                    .eq("status", ProductDO.ON_SHELVES);
            Wrapper<ProductDO> entityWrapper2 = new EntityWrapper<ProductDO>()
                    .eq("categoryId", categoryDO.getId())
                    .eq("status", ProductDO.OFF_SHELVES);
            int onshelves = productService.selectCount(entityWrapper);
            int offshelves = productService.selectCount(entityWrapper2);
            categoryDO.setOnshelvesnum(onshelves);
            categoryDO.setOffshelvesnum(offshelves);
        }
        return Result.ok(page);
    }

    @GetMapping("/add")
    @RequiresPermissions("cms:category:add")
    String add() {
        return "cms/category/add";
    }

    @GetMapping("/edit/{id}")
    @RequiresPermissions("cms:category:edit")
    String edit(@PathVariable("id") Integer id, Model model) {
        CategoryDO category = categoryService.selectById(id);
        model.addAttribute("category", category);
        return "cms/category/edit";
    }

    @Log("添加")
    @ResponseBody
    @PostMapping("/save")
    @RequiresPermissions("cms:category:add")
    public Result<String> save(CategoryDO category) {
        categoryService.insert(category);
        return Result.ok();
    }

    @Log("修改")
    @ResponseBody
    @RequestMapping("/update")
    @RequiresPermissions("cms:category:edit")
    public Result<String> update(CategoryDO category) {
        boolean update = categoryService.updateById(category);
        return update ? Result.ok() : Result.fail();
    }

    @Log("删除")
    @PostMapping("/remove")
    @ResponseBody
    @RequiresPermissions("cms:category:remove")
    public Result<String> remove(Integer id) {
        categoryService.deleteById(id);
        return Result.ok();
    }

    @Log("批量删除")
    @PostMapping("/batchRemove")
    @ResponseBody
    @RequiresPermissions("cms:category:batchRemove")
    public Result<String> remove(@RequestParam("ids[]") Integer[] ids) {
        categoryService.deleteBatchIds(Arrays.asList(ids));
        return Result.ok();
    }

}
