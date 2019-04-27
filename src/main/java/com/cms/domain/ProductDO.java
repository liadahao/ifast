package com.cms.domain;


import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import com.ifast.common.base.BaseDO;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;
import java.util.List;

/**
 * <pre>
 *
 * </pre>
 * <small> 2019-04-08 22:45:12 | Aron</small>
 */
@Data
@SuppressWarnings("serial")
@TableName("product")
public class ProductDO implements Serializable {

    public static final int ON_SHELVES = 0;
    public static final int OFF_SHELVES = 1;

    @TableId(type = IdType.AUTO)
    private Integer id;

    /**
     * 分类id
     */
    private Integer categoryid;

    /**
     * 产品名称
     */
    private String name;

    /**
     * 产品简要描述
     */
    private String description;

    /**
     * 产品详细描述
     */
    private String detail;
    /**
     * 价格
     */
    private String price;

    /**
     * 打折价
     */
    private String sale;

    /**
     * 跳转url
     */
    private String url;

    /**
     * 排序
     */
    private Integer order;

    /**
     * 标签
     */
    private String tags;
    private String image1;
    private String image2;
    private String image3;
    private String image4;
    private String image5;

    /**
     * 状态
     */
    private Integer status;

    @TableField(exist = false)
    private List<String> tagList;

    @TableField(exist = false)
    private List<String> image;

    private String categoryName;


}
