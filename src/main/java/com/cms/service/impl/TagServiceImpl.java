package com.cms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cms.dao.TagDao;
import com.cms.domain.TagDO;
import com.cms.service.TagService;
import com.ifast.common.base.CoreServiceImpl;

import java.util.List;

/**
 * <pre>
 *
 * </pre>
 * <small> 2019-04-12 16:09:20 | Aron</small>
 */
@Service
public class TagServiceImpl extends CoreServiceImpl<TagDao, TagDO> implements TagService {

    @Autowired
    TagDao tagDao;

    @Override
    public List<TagDO> selectByArticleId(Integer id) {
        return tagDao.selectByArticleId(id);
    }
}
