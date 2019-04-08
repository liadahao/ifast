package com.cms.domain;

import java.util.Date;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.ifast.common.base.BaseDO;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 
 * <pre>
 * 文章表
 * </pre>
 * <small> 2019-04-08 18:31:25 | Aron</small>
 */
@Data
@SuppressWarnings("serial")
@TableName("article")
public class ArticleDO{
	@TableId
	private Long id;

    /** slug */
    private String slug;

    /** 标题 */
    private String title;

    /** 内容 */
    private String content;

    /** 编辑模式，默认为html，其他可选项包括html，markdown .. */
    private String editMode;

    /** 摘要 */
    private String summary;

    /** 连接到(常用于谋文章只是一个连接) */
    private String linkTo;

    /** 缩略图 */
    private String thumbnail;

    /** 用户ID */
    private Integer userId;

    /** 排序编号 */
    private Integer orderNumber;

    /** 状态 */
    private String status;

    /** 评论状态，默认允许评论 */
    private Integer commentStatus;

    /** 评论总数 */
    private Integer commentCount;

    /** 最后评论时间 */
    private Date commentTime;

    /** 访问量 */
    private Integer viewCount;

    /** 创建日期 */
    private Date createTime;

    /** 最后更新日期 */
    private Date modifyTime;

    /** 标识，通常用于对某几篇文章进行标识，从而实现单独查询 */
    private String flag;

    /** SEO关键字 */
    private String metaKeywords;

    /** SEO描述信息 */
    private String metaDescription;

    /** 备注信息 */
    private String remarks;

    /**  */
    private Integer style;

}
