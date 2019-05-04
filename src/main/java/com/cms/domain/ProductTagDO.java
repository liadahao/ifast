package com.cms.domain;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;

import java.io.Serializable;

/**
 * <pre>
 *
 * </pre>
 * <small> 2019-04-12 16:09:20 | Aron</small>
 */
@Data
@SuppressWarnings("serial")
@TableName("product_tag")
public class ProductTagDO implements Serializable {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long productId;
    private Long tagId;

}
