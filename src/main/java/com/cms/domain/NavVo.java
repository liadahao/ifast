package com.cms.domain;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.Map;

/**
 * <pre>
 *
 * </pre>
 * <small> 2019-04-08 23:53:56 | Aron</small>
 */
@Data
public class NavVo implements Serializable {
    private Long id;

    /**
     *
     */
    private String name;
    private String navname;

    private Map<String,Object> content;
    /**
     *
     */
    private String background;

    /**
     *
     */
    private String url;
    private String metaTitle;
    private String metaKeywords;
    private String metaDescription;

    private String htmlSuffix;


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
}
