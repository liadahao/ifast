package com.cms.domain;

import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import com.ifast.common.base.BaseDO;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 *
 * </pre>
 * <small> 2019-04-08 23:53:56 | Aron</small>
 */
@Data
@SuppressWarnings("serial")
@TableName("nav")
public class NavDO implements Serializable {
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     *
     */
    private String name;

    private String content;
    /**
     *
     */
    private String background;

    /**
     *
     */
    private String url;

    /**
     *
     */
    private Integer order;

    /**
     *
     */
    private Integer type;

    /**
     *
     */
    private Integer isshow;

    /**
     *
     */
    private Date updatetime;

    @TableField(exist = false)
    private String isShowFlag;

}
