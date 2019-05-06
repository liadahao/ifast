package com.cms.controller;


import java.util.Arrays;
import java.util.Date;

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
import com.cms.domain.LinkDO;
import com.cms.service.LinkService;
import com.ifast.common.utils.Result;

/**
 * 
 * <pre>
 * 系统日志
 * </pre>
 * <small> 2019-05-06 23:41:55 | Aron</small>
 */
@Controller
@RequestMapping("/cms/link")
public class LinkController extends AdminBaseController {
	@Autowired
	private LinkService linkService;
	
	@GetMapping()
	String Link(){
	    return "cms/link/link";
	}
	
	@ResponseBody
	@GetMapping("/list")
	public Result<Page<LinkDO>> list(LinkDO linkDTO){
        Wrapper<LinkDO> wrapper = new EntityWrapper<LinkDO>().orderBy("id", false);
        Page<LinkDO> page = linkService.selectPage(getPage(LinkDO.class), wrapper);
        return Result.ok(page);
	}
	
	@GetMapping("/add")
	String add(){
	    return "cms/link/add";
	}

	@GetMapping("/edit/{id}")
	String edit(@PathVariable("id") Long id,Model model){
		LinkDO link = linkService.selectById(id);
		model.addAttribute("link", link);
	    return "cms/link/edit";
	}
	
	@Log("添加系统日志")
	@ResponseBody
	@PostMapping("/save")
	@RequiresPermissions("cms:nav:add")
	public Result<String> save( LinkDO link){
		link.setCreatetime(new Date());
		linkService.insert(link);
        return Result.ok();
	}
	
	@Log("修改系统日志")
	@ResponseBody
	@RequestMapping("/update")
	@RequiresPermissions("cms:nav:edit")
	public Result<String>  update( LinkDO link){
		link.setCreatetime(new Date());
		boolean update = linkService.updateById(link);
		return update ? Result.ok() : Result.fail();
	}
	
	@Log("删除系统日志")
	@PostMapping( "/remove")
	@ResponseBody
	@RequiresPermissions("cms:nav:remove")
	public Result<String>  remove( Long id){
		linkService.deleteById(id);
        return Result.ok();
	}
	
	@Log("批量删除系统日志")
	@PostMapping( "/batchRemove")
	@ResponseBody
	@RequiresPermissions("cms:nav:batchRemove")
	public Result<String>  remove(@RequestParam("ids[]") Long[] ids){
		linkService.deleteBatchIds(Arrays.asList(ids));
		return Result.ok();
	}
	
}
