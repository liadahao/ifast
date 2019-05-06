package com.cms.core;

import com.cms.dao.VisitDao;
import com.cms.domain.VisitDO;
import com.ifast.common.annotation.Log;
import com.ifast.common.utils.HttpContextUtils;
import com.ifast.common.utils.IPUtils;
import com.ifast.common.utils.JSONUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.Date;
import java.util.Map;

/**
 * <pre>
 * 日志切面
 * </pre>
 * <small> 2018年3月22日 | Aron</small>
 */
@Aspect
@Component
public class FrontLogAspect {
    @Autowired
    private VisitDao visitDao;
    private Logger log = LoggerFactory.getLogger(getClass());

    @Pointcut("execution(public * com.cms.controller.FrontController.*(..))")
    public void logController() {
    }

    /**
     * 记录controller日志，包括请求、ip、参数、响应结果
     */
    @Around("logController()")
    public Object controller(ProceedingJoinPoint point) throws Throwable {
        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = attributes.getRequest();
        log.info("{} {} {} {}.{}{}", request.getMethod(), request.getRequestURI(), IPUtils.getIpAddr(request), point.getTarget().getClass().getSimpleName(), point.getSignature().getName(), Arrays.toString(point.getArgs()));

        long beginTime = System.currentTimeMillis();
        Object result = point.proceed();
        long time = System.currentTimeMillis() - beginTime;
        // 保存日志
        saveLog(point, time);
        log.info("result({}) {}", time, JSONUtils.beanToJson(result));
        return result;
    }

    private void saveLog(ProceedingJoinPoint joinPoint, long time) {
        MethodSignature signature = (MethodSignature) joinPoint.getSignature();
        Method method = signature.getMethod();
        VisitDO sysLog = new VisitDO();
        Log syslog = method.getAnnotation(Log.class);
        if (syslog != null) {
            // 注解上的描述
            sysLog.setOperation(syslog.value());
        }
        // 请求的方法名
        String className = joinPoint.getTarget().getClass().getName();
        String methodName = signature.getName();
        if ("index".equals(methodName)) {
            sysLog.setType(1);
        }
        if ("articleDetail".equals(methodName)) {
            sysLog.setType(1);
        }
        String params;
        HttpServletRequest request = HttpContextUtils.getHttpServletRequest();
        if (request != null) {
            sysLog.setMethod(request.getMethod() + " " + request.getRequestURI());
            Map<String, String[]> parameterMap = request.getParameterMap();
            params = JSONUtils.beanToJson(parameterMap);
            // 设置IP地址
            sysLog.setIp(IPUtils.getIpAddr(request));
        } else {
            sysLog.setMethod(className + "." + methodName + "()");
            Object[] args = joinPoint.getArgs();
            params = JSONUtils.beanToJson(args);
        }
        int maxLength = 4999;
        if (params.length() > maxLength) {
            params = params.substring(0, maxLength);
        }
        sysLog.setParams(params);
        sysLog.setTime((int) time);
        // 系统当前时间
        Date date = new Date();
        sysLog.setGmtcreate(date);
        // 保存系统日志
        visitDao.insert(sysLog);
    }
}
