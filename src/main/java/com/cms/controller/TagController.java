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
import com.cms.domain.TagDO;
import com.cms.service.TagService;
import com.ifast.common.utils.Result;

/**
 * 
 * <pre>
 * 
 * </pre>
 * <small> 2019-04-12 16:09:20 | Aron</small>
 */
@Controller
@RequestMapping("/cms/tag")
public class TagController extends AdminBaseController {
	@Autowired
	private TagService tagService;
	
	@GetMapping()
	@RequiresPermissions("cms:tag:tag")
	String Tag(){
	    return "cms/tag/tag";
	}
	
	@ResponseBody
	@GetMapping("/list")
	@RequiresPermissions("cms:tag:tag")
	public Result<Page<TagDO>> list(TagDO tagDTO){
        Wrapper<TagDO> wrapper = new EntityWrapper<TagDO>().orderBy("id", false);
        Page<TagDO> page = tagService.selectPage(getPage(TagDO.class), wrapper);
        return Result.ok(page);
	}
	
	@GetMapping("/add")
	@RequiresPermissions("cms:tag:add")
	String add(){
	    return "cms/tag/add";
	}

	@GetMapping("/edit/{id}")
	@RequiresPermissions("cms:tag:edit")
	String edit(@PathVariable("id") Long id,Model model){
		TagDO tag = tagService.selectById(id);
		model.addAttribute("tag", tag);
	    return "cms/tag/edit";
	}
	
	@Log("添加")
	@ResponseBody
	@PostMapping("/save")
	@RequiresPermissions("cms:tag:add")
	public Result<String> save( TagDO tag){
		tagService.insert(tag);
        return Result.ok();
	}
	
	@Log("修改")
	@ResponseBody
	@RequestMapping("/update")
	@RequiresPermissions("cms:tag:edit")
	public Result<String>  update( TagDO tag){
		boolean update = tagService.updateById(tag);
		return update ? Result.ok() : Result.fail();
	}
	
	@Log("删除")
	@PostMapping( "/remove")
	@ResponseBody
	@RequiresPermissions("cms:tag:remove")
	public Result<String>  remove( Long id){
		tagService.deleteById(id);
        return Result.ok();
	}
	
	@Log("批量删除")
	@PostMapping( "/batchRemove")
	@ResponseBody
	@RequiresPermissions("cms:tag:batchRemove")
	public Result<String>  remove(@RequestParam("ids[]") Long[] ids){
		tagService.deleteBatchIds(Arrays.asList(ids));
		return Result.ok();
	}
	
}
