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
 * <small> 2019-05-06 23:41:55 | Aron</small>
 */
@Data
@SuppressWarnings("serial")
@TableName("link")
public class LinkDO implements Serializable {

    @TableId(type = IdType.AUTO)
	private Long id;

    /** 名称 */
    private String name;

    /** 是否显示 */
    private Integer isshow;

    /** logo链接 */
    private String logo;

    /** 权重 */
    private Integer weight;

    /** 跳转链接 */
    private String url;

    /** 创建时间 */
    private Date createtime;

    /** 类型 */
    private Integer type;

}
