package com.cms.service;

import com.cms.domain.ArticleDO;
import com.cms.domain.EventDO;
import com.cms.domain.MessageDO;
import com.ifast.common.base.CoreService;

/**
 * <pre>
 *
 * </pre>
 * <small> 2019-04-29 22:08:03 | Aron</small>
 */
public interface MessageService extends CoreService<MessageDO> {

    void saveArticle(ArticleDO article, Long userId);

    void saveEvent(EventDO event, Long userId);
}
