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
 * <small> 2019-04-29 22:08:03 | Aron</small>
 */
@Data
@SuppressWarnings("serial")
@TableName("message")
public class MessageDO implements Serializable {
    @TableId(type = IdType.AUTO)
    private Integer id;

    /**
     * 类型id
     */
    private Integer typeid;

    /**
     * 类型（1：文章 2：活动 3：商品）
     */
    private Integer type;

    /**
     * 状态
     */
    private int status;

    /**
     * 创建时间
     */
    private Date createtime;

    /**
     * 链接地址
     */
    private String url;

    /**
     * 内容
     */
    private String content;

    /**
     * 备注信息
     */
    private String remarks;

    /**
     * 提交者id
     */
    private Integer userid;

}
