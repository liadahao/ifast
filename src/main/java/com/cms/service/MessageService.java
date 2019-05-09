package com.cms.service;

import com.cms.domain.ArticleDO;
import com.cms.domain.EventDO;
import com.cms.domain.MessageDO;
import com.cms.domain.ProductDO;
import com.ifast.common.base.CoreService;
import com.ifast.sys.domain.UserDO;

/**
 * <pre>
 *
 * </pre>
 * <small> 2019-04-29 22:08:03 | Aron</small>
 */
public interface MessageService extends CoreService<MessageDO> {

    void saveArticle(ArticleDO article, UserDO user);

    void saveEvent(EventDO event, UserDO userId);

    void saveProduct(ProductDO product, UserDO userId);
}
