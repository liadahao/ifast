package com.cms.domain;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * <pre>
 * 文章表
 * </pre>
 * <small> 2019-04-08 22:45:12 | Aron</small>
 */
@Data
@SuppressWarnings("serial")
@TableName("event")
public class EventDO implements Serializable {
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
     * 连接到(常用于谋文章只是一个连接)
     */
    private String linkto;

    /**
     * 缩略图
     */
    private String thumbnail;

    /**
     * 用户ID
     */
    private Integer userid;

    /**
     * 排序编号
     */
    private Integer ordernumber;

    /**
     * 状态
     */
    private int status;

    /**
     * 评论状态，默认允许评论
     */
    private Integer commentstatus;

    /**
     * 评论总数
     */
    private Integer commentcount;

    /**
     * 最后评论时间
     */
    private Date commenttime;

    /**
     * 访问量
     */
    private Integer viewcount;

    /**
     * 创建日期
     */
    private Date createtime;

    /**
     * 最后更新日期
     */
    private Date modifytime;

    /**
     *
     */
    private Date starttime;

    /**
     *
     */
    private Date endtime;

    /**
     *
     */
    private String price;

    /**
     *
     */
    private String address;

    /**
     * SEO关键字
     */
    private String metakeywords;

    /**
     * SEO描述信息
     */
    private String metadescription;

    /**
     * 备注信息
     */
    private String remarks;

    /**
     *
     */
    private Long tagId;
    private String tag;

}
