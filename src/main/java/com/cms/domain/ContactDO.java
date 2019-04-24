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
 * <small> 2019-04-24 23:54:15 | Aron</small>
 */
@Data
@SuppressWarnings("serial")
@TableName("contact")
public class ContactDO implements Serializable {
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 姓名
     */
    private String name;

    /**
     * 地址
     */
    private String address;

    /**
     *
     */
    private String company;

    /**
     * 访客者IP
     */
    private String ip;

    /**
     * 访客者时间
     */
    private Date createtime;

    /**
     * 0：未读，1：已读
     */
    private Integer status;

}
