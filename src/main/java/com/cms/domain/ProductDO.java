package com.cms.domain;


import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.ifast.common.base.BaseDO;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

/**
 * 
 * <pre>
 * 
 * </pre>
 * <small> 2019-04-08 22:45:12 | Aron</small>
 */
@Data
@SuppressWarnings("serial")
@TableName("product")
public class ProductDO implements Serializable {
	@TableId
	private Integer id;

    /** 分类id */
    private Integer categoryid;

    /** 产品名称 */
    private String name;

    /** 产品简要描述 */
    private String description;

    /** 产品详细描述 */
    private String detail;

    /** 产品主图 */
    private String image;

    /** 价格 */
    private String price;

    /** 打折价 */
    private String sale;

    /** 跳转url */
    private String url;

    /** 排序 */
    private Integer order;

    /** 标签 */
    private String tags;

    /** 状态 */
    private Integer status;

}
