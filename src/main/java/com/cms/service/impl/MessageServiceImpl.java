package com.cms.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.cms.core.TagConstant;
import com.cms.domain.ArticleDO;
import com.cms.domain.EventDO;
import org.springframework.stereotype.Service;

import com.cms.dao.MessageDao;
import com.cms.domain.MessageDO;
import com.cms.service.MessageService;
import com.ifast.common.base.CoreServiceImpl;

import java.util.Date;

/**
 * <pre>
 *
 * </pre>
 * <small> 2019-04-29 22:08:03 | Aron</small>
 */
@Service
public class MessageServiceImpl extends CoreServiceImpl<MessageDao, MessageDO> implements MessageService {

    @Override
    public void saveArticle(ArticleDO article, Long userId) {
        EntityWrapper<MessageDO> wrapper = new EntityWrapper<>();
        wrapper.eq("typeId", article.getId()).eq("type", TagConstant.ARTICLE.type);
        MessageDO message = this.selectOne(wrapper);
        if (message == null) {
            message = new MessageDO();
        }
        message.setType(TagConstant.ARTICLE.type);
        message.setTypeid(article.getId());
        message.setCreatetime(new Date());
        message.setStatus(article.getStatus());
        message.setUrl("/article/" + article.getId());
        message.setUserid(userId.intValue());
        insertOrUpdate(message);
    }

    @Override
    public void saveEvent(EventDO event, Long userId) {
        EntityWrapper<MessageDO> wrapper = new EntityWrapper<>();
        wrapper.eq("typeId", event.getId()).eq("type", TagConstant.EVNENT.type);
        MessageDO message = selectOne(wrapper);
        if (message == null) {
            message = new MessageDO();
        }
        message.setType(TagConstant.EVNENT.type);
        message.setTypeid(event.getId());
        message.setCreatetime(new Date());
        message.setStatus(event.getStatus());
        message.setUserid(userId.intValue());
        insertOrUpdate(message);
    }
}
