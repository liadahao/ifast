package com.cms.service;

import com.cms.domain.TagDO;
import com.ifast.common.base.CoreService;

import java.util.List;

/**
 * 
 * <pre>
 * 
 * </pre>
 * <small> 2019-04-12 16:09:20 | Aron</small>
 */
public interface TagService extends CoreService<TagDO> {

    List<TagDO> selectByArticleId(Integer id);
}
