package com.cms.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.cms.core.TagConstant;
import com.cms.domain.ArticleDO;
import com.cms.domain.EventDO;
import com.cms.domain.ProductDO;
import com.ifast.sys.domain.UserDO;
import org.apache.commons.lang3.StringUtils;
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
    public void saveArticle(ArticleDO article, UserDO user) {
        if (article.getStatus() != ArticleDO.VERIFYING_STATUS) {
            return;
        }
        EntityWrapper<MessageDO> wrapper = new EntityWrapper<>();
        wrapper.eq("typeId", article.getId())
                .eq("type", TagConstant.ARTICLE.type)
                .eq("status", ArticleDO.VERIFYING_STATUS);
        MessageDO message = this.selectOne(wrapper);
        if (message == null) {
            message = new MessageDO();
        }
        String userName = user.getUsername();
        if (StringUtils.isEmpty(userName)) {
            userName = "";
        }
        message.setContent(userName + "发布文章内容，需要审核");
        message.setType(TagConstant.ARTICLE.type);
        message.setTypeid(article.getId());
        message.setCreatetime(new Date());
        message.setStatus(article.getStatus());
        message.setUrl("/article/" + article.getId());
        message.setUserid(user.getId().intValue());
        insertOrUpdate(message);
    }

    @Override
    public void saveEvent(EventDO event, UserDO user) {
        if (event.getStatus() != ArticleDO.VERIFYING_STATUS) {
            return;
        }
        EntityWrapper<MessageDO> wrapper = new EntityWrapper<>();
        wrapper.eq("typeId", event.getId())
                .eq("type", TagConstant.EVNENT.type)
                .eq("status", ArticleDO.VERIFYING_STATUS);
        MessageDO message = selectOne(wrapper);
        if (message == null) {
            message = new MessageDO();
        }
        String userName = user.getUsername();
        if (StringUtils.isEmpty(userName)) {
            userName = "";
        }
        message.setContent(userName + "发布活动内容，需要审核");
        message.setType(TagConstant.EVNENT.type);
        message.setTypeid(event.getId());
        message.setCreatetime(new Date());
        message.setStatus(event.getStatus());
        message.setUserid(user.getId().intValue());
        insertOrUpdate(message);
    }

    @Override
    public void saveProduct(ProductDO product, UserDO user) {
        if (product.getStatus() != ArticleDO.VERIFYING_STATUS) {
            return;
        }
        EntityWrapper<MessageDO> wrapper = new EntityWrapper<>();
        wrapper.eq("typeId", product.getId())
                .eq("type", TagConstant.PRODUCT.type)
                .eq("status", ArticleDO.VERIFYING_STATUS);
        MessageDO message = selectOne(wrapper);
        if (message == null) {
            message = new MessageDO();
        }
        String userName = user.getUsername();
        if (StringUtils.isEmpty(userName)) {
            userName = "";
        }
        message.setContent(userName + "发布商品，需要审核");
        message.setType(TagConstant.PRODUCT.type);
        message.setTypeid(product.getId());
        message.setCreatetime(new Date());
        message.setStatus(product.getStatus());
        message.setUrl("/shop/" + product.getId());
        message.setUserid(user.getId().intValue());
        insertOrUpdate(message);
    }
}
