package com.cms.dao;

import com.cms.domain.ArticleDO;
import com.ifast.common.base.BaseDao;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <pre>
 * 文章表
 * </pre>
 * <small> 2019-04-08 18:31:25 | Aron</small>
 */
public interface ArticleDao extends BaseDao<ArticleDO> {
    List<ArticleDO> selectByTagId(@Param("tagId") Integer tagId
            , @Param("offset") Integer offset
            , @Param("size") Integer size);
}
