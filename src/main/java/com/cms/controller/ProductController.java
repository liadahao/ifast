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
import com.cms.domain.ProductDO;
import com.cms.service.ProductService;
import com.ifast.common.utils.Result;

/**
 * 
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
	
	@GetMapping()
	@RequiresPermissions("cms:product:product")
	String Product(){
	    return "cms/product/product";
	}
	
	@ResponseBody
	@GetMapping("/list")
	@RequiresPermissions("cms:product:product")
	public Result<Page<ProductDO>> list(ProductDO productDTO){
        Wrapper<ProductDO> wrapper = new EntityWrapper<ProductDO>().orderBy("id", false);
        Page<ProductDO> page = productService.selectPage(getPage(ProductDO.class), wrapper);
        return Result.ok(page);
	}
	
	@GetMapping("/add")
	@RequiresPermissions("cms:product:add")
	String add(){
	    return "cms/product/add";
	}

	@GetMapping("/edit/{id}")
	@RequiresPermissions("cms:product:edit")
	String edit(@PathVariable("id") Integer id,Model model){
		ProductDO product = productService.selectById(id);
		model.addAttribute("product", product);
	    return "cms/product/edit";
	}
	
	@Log("添加")
	@ResponseBody
	@PostMapping("/save")
	@RequiresPermissions("cms:product:add")
	public Result<String> save( ProductDO product){
		productService.insert(product);
        return Result.ok();
	}
	
	@Log("修改")
	@ResponseBody
	@RequestMapping("/update")
	@RequiresPermissions("cms:product:edit")
	public Result<String>  update( ProductDO product){
		boolean update = productService.updateById(product);
		return update ? Result.ok() : Result.fail();
	}
	
	@Log("删除")
	@PostMapping( "/remove")
	@ResponseBody
	@RequiresPermissions("cms:product:remove")
	public Result<String>  remove( Integer id){
		productService.deleteById(id);
        return Result.ok();
	}
	
	@Log("批量删除")
	@PostMapping( "/batchRemove")
	@ResponseBody
	@RequiresPermissions("cms:product:batchRemove")
	public Result<String>  remove(@RequestParam("ids[]") Integer[] ids){
		productService.deleteBatchIds(Arrays.asList(ids));
		return Result.ok();
	}
	
}
