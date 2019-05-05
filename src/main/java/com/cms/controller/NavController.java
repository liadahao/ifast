package com.cms.controller;


import java.util.*;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.cms.core.HtmlConstant;
import com.cms.domain.NavVo;
import com.ifast.common.domain.ConfigDO;
import com.ifast.common.service.ConfigService;
import com.ifast.generator.type.EnumGen;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.formula.functions.Na;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.ifast.common.annotation.Log;
import com.ifast.common.base.AdminBaseController;
import com.cms.domain.NavDO;
import com.cms.service.NavService;
import com.ifast.common.utils.Result;

/**
 * <pre>
 *
 * </pre>
 * <small> 2019-04-08 23:53:56 | Aron</small>
 */
@Controller
@RequestMapping("/cms/nav")
public class NavController extends AdminBaseController {
    @Autowired
    private NavService navService;
    @Autowired
    private ConfigService configService;

    @GetMapping()
    @RequiresPermissions("cms:nav:nav")
    String Nav() {
        return "cms/nav/nav";
    }

    @GetMapping("album")
    String album() {
        return "cms/nav/album";
    }


    @ResponseBody
    @GetMapping("/list")
    @RequiresPermissions("cms:nav:nav")
    public Result<Page<NavDO>> list(NavDO navDTO) {
        Wrapper<NavDO> wrapper = new EntityWrapper<NavDO>().orderBy("id", false);
        Page<NavDO> page = navService.selectPage(getPage(NavDO.class), wrapper);
        return Result.ok(page);
    }

    @GetMapping("/indexpage")
    @RequiresPermissions("cms:nav:add")
    String indexpage(Model model) {
        List<ConfigDO> configDOList = configService.findListByKvType(EnumGen.KvType.index.getValue());
        Map<String, Object> map = new HashMap<>();
        map.put("content", new HashMap<>());
        for (ConfigDO configDO : configDOList) {
            if (configDO.getK().equals("content")) {
                if (!StringUtils.isEmpty(configDO.getV())) {
                    HashMap<String, Object> contentMap = JSON.parseObject(configDO.getV(), HashMap.class);
                    map.put(configDO.getK(), contentMap);
                }
            } else {
                map.put(configDO.getK(), configDO.getV());
            }
        }
        model.addAttribute("data", map);
        return "cms/nav/indexpage";
    }

    @Log("添加")
    @ResponseBody
    @PostMapping("/indexpage/save")
    public Result<String> saveIndexpage(@RequestBody String json) {
        HashMap<String, Object> map = JSON.parseObject(json, HashMap.class);
        for (Map.Entry entry : map.entrySet()) {
            String k = String.valueOf(entry.getKey());
            Object v = entry.getValue();
            ConfigDO configDO = configService.getByKey(k);
            if (configDO == null) {
                configDO = new ConfigDO();
                configDO.setCreateTime(new Date());
            }
            configDO.setK(k);
            configDO.setV(String.valueOf(v));
            configDO.setKvType(EnumGen.KvType.index.getValue());
            configService.insertOrUpdate(configDO);
        }
        return Result.ok();
    }

    @GetMapping("/add")
    @RequiresPermissions("cms:nav:add")
    String add() {
        return "cms/nav/add";
    }

    @GetMapping("/add/{type}")
    @RequiresPermissions("cms:nav:add")
    String add(@PathVariable("type") Integer type, Model model) {
        String suffix = HtmlConstant.getHtml(type);
        NavVo navVo = new NavVo();
        navVo.setType(type);
        Map<String, Object> map = new HashMap<>();
        map.put("tab1", new HashMap<>());
        map.put("tab2", new HashMap<>());
        navVo.setContent(map);
        model.addAttribute("nav", navVo);
        return "cms/nav/" + suffix;
    }

    @GetMapping("/edit/{id}")
    @RequiresPermissions("cms:nav:edit")
    String edit(@PathVariable("id") Long id, Model model) {
        NavDO nav = navService.selectById(id);
        String suffix = HtmlConstant.getHtml(nav.getType());
        NavVo navVo = new NavVo();
        BeanUtils.copyProperties(nav, navVo, "content");
        Map<String, Object> map;
        if (!StringUtils.isEmpty(nav.getContent())) {
            map = JSON.parseObject(nav.getContent(), Map.class);
        } else {
            map = new HashMap<>();
            map.put("tab1", new HashMap<>());
            map.put("tab2", new HashMap<>());
        }
        navVo.setContent(map);
        model.addAttribute("nav", navVo);
        return "cms/nav/" + suffix;
    }

    @Log("添加")
    @ResponseBody
    @PostMapping("/save")
    @RequiresPermissions("cms:nav:add")
    public Result<String> save(@RequestBody NavDO nav) {
        if (!StringUtils.isEmpty(nav.getNavname())) {
            String url = "/page/";
            url = url + nav.getNavname().toLowerCase().replace(" ", "");
            nav.setUrl(url);
        }
        navService.insert(nav);
        return Result.ok();
    }

    @Log("修改")
    @ResponseBody
    @RequestMapping("/update")
    @RequiresPermissions("cms:nav:edit")
    public Result<String> update(@RequestBody NavDO nav) {
        if (!StringUtils.isEmpty(nav.getNavname())) {
            String url = "/page/";
            url = url + nav.getNavname().toLowerCase().replace(" ", "");
            nav.setUrl(url);
        }
        boolean update = navService.updateById(nav);
        return update ? Result.ok() : Result.fail();
    }

    @Log("删除")
    @PostMapping("/remove")
    @ResponseBody
    @RequiresPermissions("cms:nav:remove")
    public Result<String> remove(Long id) {
        navService.deleteById(id);
        return Result.ok();
    }

    @Log("批量删除")
    @PostMapping("/batchRemove")
    @ResponseBody
    @RequiresPermissions("cms:nav:batchRemove")
    public Result<String> remove(@RequestParam("ids[]") Long[] ids) {
        navService.deleteBatchIds(Arrays.asList(ids));
        return Result.ok();
    }

}
