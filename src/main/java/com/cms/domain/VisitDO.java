package com.cms.domain;

import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import com.ifast.common.base.BaseDO;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 
 * <pre>
 * 系统日志
 * </pre>
 * <small> 2019-05-06 22:11:11 | Aron</small>
 */
@Data
@SuppressWarnings("serial")
@TableName("visit")
public class VisitDO implements Serializable {

    @TableId(type = IdType.AUTO)
	private Long id;

    /** 用户id */
    private Long userid;

    /** 用户名 */
    private String username;

    /** 用户操作 */
    private String operation;

    /** 响应时间 */
    private Integer time;
    private Integer type;

    /** 请求方法 */
    private String method;

    /** 请求参数 */
    private String params;

    /** IP地址 */
    private String ip;

    /** 创建时间 */
    private Date gmtcreate;

}
