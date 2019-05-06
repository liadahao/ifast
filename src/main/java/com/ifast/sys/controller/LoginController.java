package com.ifast.sys.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.cms.dao.VisitDao;
import com.cms.domain.ContactDO;
import com.cms.domain.VisitDO;
import com.cms.service.ContactService;
import com.ifast.common.annotation.Log;
import com.ifast.common.base.AdminBaseController;
import com.ifast.common.domain.Tree;
import com.ifast.common.type.EnumErrorCode;
import com.ifast.common.utils.MD5Utils;
import com.ifast.common.utils.Result;
import com.ifast.oss.domain.FileDO;
import com.ifast.oss.service.FileService;
import com.ifast.sys.domain.MenuDO;
import com.ifast.sys.service.MenuService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.swing.text.html.parser.Entity;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * <pre>
 * </pre>
 * <small> 2018年3月23日 | Aron</small>
 */
@Controller
public class LoginController extends AdminBaseController {

    @Autowired
    MenuService menuService;
    @Autowired
    FileService fileService;
    @Autowired
    VisitDao visitDao;
    @Autowired
    ContactService contactService;

    @GetMapping({"admin"})
    String adminIndex(Model model) {
        return "redirect:/admin/index";
    }

    @GetMapping({"admin/index"})
    String index(Model model) {
        List<Tree<MenuDO>> menus = menuService.listMenuTree(getUserId());
        model.addAttribute("menus", menus);
        model.addAttribute("name", getUser().getName());
        model.addAttribute("username", getUser().getUsername());
        FileDO fileDO = fileService.selectById(getUser().getPicId());
        model.addAttribute("picUrl", fileDO == null ? "/img/photo_s.jpg" : fileDO.getUrl());
        return "index_v1";
    }

    @GetMapping("/login")
    String login() {
        return "login";
    }

    @Log("登录")
    @PostMapping("/login")
    @ResponseBody
    Result<String> ajaxLogin(String username, String password) {
        password = MD5Utils.encrypt(username, password);
        UsernamePasswordToken token = new UsernamePasswordToken(username, password);
        token.setRememberMe(true);//记住我是可选项，但只有会话缓存到redis等持久存储才能真正记住
        Subject subject = SecurityUtils.getSubject();
        try {
            subject.login(token);
            return Result.ok();
        } catch (AuthenticationException e) {
            return Result.build(EnumErrorCode.userLoginFail.getCode(), EnumErrorCode.userLoginFail.getMsg());
        }
    }

    @GetMapping("/main")
    String main(Model model) {
        LocalDateTime today_start = LocalDateTime.of(LocalDate.now(), LocalTime.MIN);//当天零点
        LocalDateTime today_end = LocalDateTime.of(LocalDate.now(), LocalTime.MAX);
        // 获取访客ip数量
        Wrapper<VisitDO> visitDOWrapper = new EntityWrapper<>();
        visitDOWrapper.setSqlSelect("distinct ip");
        visitDOWrapper.ge("gmtCreate", today_start);
        visitDOWrapper.le("gmtCreate", today_end);
        int visitIpCount = visitDao.selectCount(visitDOWrapper);
        model.addAttribute("visitIpCount", visitIpCount);
        // 获取访客留言数量
        Wrapper<ContactDO> contactDOWrapper = new EntityWrapper<>();
        contactDOWrapper.setSqlSelect("distinct ip");
        contactDOWrapper.ge("createTime", today_start);
        contactDOWrapper.le("createTime", today_end);
        int contactCount = contactService.selectCount(contactDOWrapper);
        model.addAttribute("contactCount", contactCount);
        // 获取访问数量
        Wrapper<VisitDO> browseCountWrapper = new EntityWrapper<>();
        browseCountWrapper.eq("type", 1);
        browseCountWrapper.ge("gmtCreate", today_start);
        browseCountWrapper.le("gmtCreate", today_end);
        int browseCount = visitDao.selectCount(browseCountWrapper);
        model.addAttribute("browseCount", browseCount);
        return "main";
    }

    @GetMapping("/403")
    String error403() {
        return "403";
    }

    public static Date getStartTime(Date date) {
        Calendar dateStart = Calendar.getInstance();
        dateStart.setTime(date);
        dateStart.set(Calendar.HOUR_OF_DAY, 0);
        dateStart.set(Calendar.MINUTE, 0);
        dateStart.set(Calendar.SECOND, 0);
        return dateStart.getTime();
    }

    /**
     * 获取每天的开始时间 23:59:59:999
     *
     * @param date
     * @return
     */
    public static Date getEndTime(Date date) {
        Calendar dateEnd = Calendar.getInstance();
        dateEnd.setTime(date);
        dateEnd.set(Calendar.HOUR_OF_DAY, 23);
        dateEnd.set(Calendar.MINUTE, 59);
        dateEnd.set(Calendar.SECOND, 59);
        return dateEnd.getTime();
    }


}
