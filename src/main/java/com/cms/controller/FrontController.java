package com.cms.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.cms.domain.NavDO;
import com.cms.domain.WebsiteDO;
import com.cms.service.NavService;
import com.cms.service.WebsiteService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class FrontController {

    @Autowired
    NavService navService;

    @Autowired
    WebsiteService websiteService;

    @RequestMapping("/index")
    public String index(Model model) {
        return "/cms/front/pages/index";
    }


    @RequestMapping("/page/{name}")
    public String website(@PathVariable String name, Model model) {
        Wrapper<NavDO> wrapper = new EntityWrapper<NavDO>().eq("name", name);
        NavDO navDO = navService.selectOne(wrapper);
        String suffix = "";
        Map data = new HashMap();
        if (navDO != null && !StringUtils.isEmpty(navDO.getContent())) {
            data = JSON.parseObject(navDO.getContent(), Map.class);
            if (navDO.getType() == 2) {
                suffix = "techtour";
            }
        }
        model.addAttribute("data", data);
        if (!StringUtils.isEmpty(suffix)) {
            return "/cms/front/pages/" + suffix;
        } else {
            return "/cms/front/pages/" + name;
        }
    }
}
