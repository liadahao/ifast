package com.cms.service;

import com.cms.domain.ArticleDO;
import com.ifast.common.base.CoreService;

import java.util.List;

/**
 * 
 * <pre>
 * 文章表
 * </pre>
 * <small> 2019-04-08 18:31:25 | Aron</small>
 */
public interface ArticleService extends CoreService<ArticleDO> {

    List<ArticleDO> selectByTagId(Long id, int offsetCurrent, int size);
}
