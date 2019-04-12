package com.cms.dao;

import com.cms.domain.TagDO;
import com.ifast.common.base.BaseDao;

import java.util.List;

/**
 * 
 * <pre>
 * 
 * </pre>
 * <small> 2019-04-12 16:09:20 | Aron</small>
 */
public interface TagDao extends BaseDao<TagDO> {

    List<TagDO> selectByArticleId(Integer id);
}
