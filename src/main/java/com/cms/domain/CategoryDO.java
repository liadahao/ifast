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
 * <small> 2019-04-08 22:45:12 | Aron</small>
 */
@Data
@SuppressWarnings("serial")
@TableName("category")
public class CategoryDO implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
	private Integer id;

    /**  */
    private String name;

    /**  */
    private Integer onshelvesnum;

    /**  */
    private Integer offshelvesnum;

    /**  */
    private Date updateTime;

}
