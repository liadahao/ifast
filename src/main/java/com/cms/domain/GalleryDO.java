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
 * <pre>
 *
 * </pre>
 * <small> 2019-04-27 12:54:58 | Aron</small>
 */
@Data
@SuppressWarnings("serial")
@TableName("gallery")
public class GalleryDO implements Serializable {
    @TableId(type = IdType.AUTO)
    private Integer id;

    /**
     * 图片简介
     */
    private String description;
    /**
     * 来源地址
     */
    private String linkTo;

    /**
     * 发布时间
     */
    private Date createtime;

    /**
     * 显示
     */
    private Integer isshow;

    /**
     * 图片链接
     */
    private String url;

    /**
     * 权重
     */
    private Double weight;

}
