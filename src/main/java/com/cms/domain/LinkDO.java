package com.cms.domain;


import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import com.ifast.common.base.BaseDO;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

/**
 * 
 * <pre>
 * 
 * </pre>
 * <small> 2019-04-11 00:02:07 | Aron</small>
 */
@Data
@SuppressWarnings("serial")
@TableName("link")
public class LinkDO implements Serializable {
    @TableId(type = IdType.AUTO)
	private Long id;

    /** 外链名称 */
    private String name;

    /** 是否显示（1：显示 0：隐藏） */
    private Integer show;

    /** 外链logo */
    private String logo;

    /** 排序 */
    private Integer order;

    /** 外链地址 */
    private String url;

    /**  */
    private Integer navid;

}
