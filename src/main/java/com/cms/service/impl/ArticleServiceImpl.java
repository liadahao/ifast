package com.cms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cms.dao.ArticleDao;
import com.cms.domain.ArticleDO;
import com.cms.service.ArticleService;
import com.ifast.common.base.CoreServiceImpl;

import java.util.List;

/**
 * <pre>
 * 文章表
 * </pre>
 * <small> 2019-04-08 18:31:25 | Aron</small>
 */
@Service
public class ArticleServiceImpl extends CoreServiceImpl<ArticleDao, ArticleDO> implements ArticleService {

    @Autowired
    ArticleDao articleDao;

    @Override
    public List<ArticleDO> selectByTagId(Long id, int offsetCurrent, int size) {
        return articleDao.selectByTagId(id.intValue(), offsetCurrent, size);
    }
}
