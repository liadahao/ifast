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
 * <small> 2019-04-09 14:53:41 | Aron</small>
 */
@Data
@SuppressWarnings("serial")
@TableName("website")
public class WebsiteDO implements Serializable {
    @TableId(type = IdType.AUTO)
	private Long id;

    /** 导航id */
    private Integer navid;

    /** 标题 */
    private String title;

    /** 内容 */
    private String content;

    /** 链接 */
    private String url;

    /** 图片链接 */
    private String images;

    /** 类型 */
    private String type;

    /** 视频链接 */
    private String video;

    /** 排序 */
    private Integer order;

}
