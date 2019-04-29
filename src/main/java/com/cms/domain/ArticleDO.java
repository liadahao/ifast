package com.cms.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import com.ifast.common.base.BaseDO;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * 文章表
 * </pre>
 * <small> 2019-04-08 18:31:25 | Aron</small>
 */
@Data
@SuppressWarnings("serial")
@TableName("article")
public class ArticleDO implements Serializable {
    /**
     * 发布状态
     */
    public static final int PUBLISH_STATUS = 0;
    /**
     * 审核中
     */
    public static final int VERIFYING_STATUS = 1;
    /**
     * 未通过审核状态
     */
    public static final int NOT_VERIFY_STATUS = 2;
    /**
     * 隐藏状态
     */
    public static final int HIDE_STATUS = 3;
    /**
     * 预览状态
     */
    public static final int PREVIEW_STATUS = 4;

    @TableId(type = IdType.AUTO)
    private Integer id;

    /**
     * 标题
     */
    private String title;

    /**
     * 内容
     */
    private String content;

    /**
     * 编辑模式，默认为html，其他可选项包括html，markdown ..
     */
    private String editMode;

    /**
     * 摘要
     */
    private String summary;

    /**
     * 连接到(常用于谋文章只是一个连接)
     */
    private String linkTo;

    /**
     * 缩略图
     */
    private String thumbnail;

    /**
     * 作者
     */
    private String author;

    private Integer createUserId;
    /**
     * 创建用户名
     */
    private String createUserName;

    /**
     * 排序编号
     */
    private Integer orderNumber;

    /**
     * 状态
     */
    private int status;

    /**
     * 评论状态，默认允许评论
     */
    private Integer commentStatus;

    /**
     * 评论总数
     */
    private Integer commentCount;
    private Integer goodCount;
    private Integer keepTryingCount;

    /**
     * 最后评论时间
     */
    private Date commentTime;

    /**
     * 访问量
     */
    private Integer viewCount;

    /**
     * 创建日期
     */
    private Date createTime;

    /**
     * 最后更新日期
     */
    private Date modifyTime;

    /**
     *
     */
    private String metaTitle;


    /**
     * SEO关键字
     */
    private String metaKeywords;

    /**
     * SEO描述信息
     */
    private String metaDescription;

    /**
     * 备注信息
     */
    private String remarks;

    private String facebook;
    private String linkedin;
    private String twitter;
    private String medium;
    private String instagram;

    /**
     *
     */
    private Integer style;

    @TableField(exist = false)
    private List<Map<String, String>> social;
    @TableField(exist = false)
    private List<String> tag;

}
