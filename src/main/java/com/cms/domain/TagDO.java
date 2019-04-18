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
 * 
 * </pre>
 * <small> 2019-04-12 16:09:20 | Aron</small>
 */
@Data
@SuppressWarnings("serial")
@TableName("tag")
public class TagDO implements Serializable {

	@TableId(type = IdType.AUTO)
	private Long id;

    /** 名称 */
    private String name;

    /** 用途 */
    private String type;

    /** 是否可用 */
    private Integer isenable;

    /** 创建时间按 */
    private Date createtime;

    /**  */
    private Integer creator;

    /** 更新时间 */
    private Date updatetime;

}
