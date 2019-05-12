package com.ifast.common.shiro.config;

import at.pollux.thymeleaf.shiro.dialect.ShiroDialect;
import com.ifast.api.shiro.JWTAuthenticationFilter;
import com.ifast.api.shiro.JWTAuthorizingRealm;
import com.ifast.common.shiro.cache.SpringCacheManagerWrapper;
import com.ifast.common.shiro.realm.IFastModularRealm;
import com.ifast.common.utils.SpringContextHolder;
import com.ifast.common.shiro.session.RedisSessionDAO;
import com.ifast.sys.config.BDSessionListener;
import com.ifast.sys.shiro.SysUserAuthorizingRealm;
import org.apache.shiro.authc.Authenticator;
import org.apache.shiro.authc.pam.AtLeastOneSuccessfulStrategy;
import org.apache.shiro.authz.Authorizer;
import org.apache.shiro.authz.ModularRealmAuthorizer;
import org.apache.shiro.cache.CacheManager;
import org.apache.shiro.codec.Base64;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.realm.Realm;
import org.apache.shiro.session.SessionListener;
import org.apache.shiro.session.mgt.SessionManager;
import org.apache.shiro.session.mgt.eis.SessionDAO;
import org.apache.shiro.spring.LifecycleBeanPostProcessor;
import org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.CookieRememberMeManager;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.servlet.SimpleCookie;
import org.apache.shiro.web.session.mgt.DefaultWebSessionManager;
import org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.StringRedisSerializer;

import javax.servlet.Filter;
import java.util.*;

/**
 * . cache ehcache
 * . realm(cache)
 * . securityManager（realm）
 * . ShiroFilterFactoryBean 注册
 *
 * @author dahao
 */
@Configuration
public class ShiroConfiguration {

    @Bean
    ShiroFilterFactoryBean shiroFilterFactoryBean(SecurityManager securityManager) {
        ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
        shiroFilterFactoryBean.setSecurityManager(securityManager);
        shiroFilterFactoryBean.setLoginUrl("/login");
        shiroFilterFactoryBean.setSuccessUrl("/admin/index");
        shiroFilterFactoryBean.setUnauthorizedUrl("/shiro/405");

        LinkedHashMap<String, String> filterChainDefinitionMap = new LinkedHashMap<>();

        filterChainDefinitionMap.put("/api/**", "jwt"); // api
        filterChainDefinitionMap.put("/emil/**", "anon");
        filterChainDefinitionMap.put("/doc.html**", "anon");
        filterChainDefinitionMap.put("/swagger-resources/**", "anon");
        filterChainDefinitionMap.put("/webjars/**", "anon");
        filterChainDefinitionMap.put("/v2/**", "anon");
        filterChainDefinitionMap.put("/page/**", "anon");
        filterChainDefinitionMap.put("/index", "anon");
        filterChainDefinitionMap.put("/page", "anon");
        filterChainDefinitionMap.put("/article/**", "anon");
        filterChainDefinitionMap.put("/product/**", "anon");
        filterChainDefinitionMap.put("/shop/**", "anon");
        filterChainDefinitionMap.put("/event/**", "anon");
        filterChainDefinitionMap.put("/shiro/**", "anon");
        filterChainDefinitionMap.put("/login", "anon");
        filterChainDefinitionMap.put("/css/**", "anon");
        filterChainDefinitionMap.put("/js/**", "anon");
        filterChainDefinitionMap.put("/fonts/**", "anon");
        filterChainDefinitionMap.put("/img/**", "anon");
        filterChainDefinitionMap.put("/video/**", "anon");
        filterChainDefinitionMap.put("/docs/**", "anon");
        filterChainDefinitionMap.put("/druid/**", "anon");
        filterChainDefinitionMap.put("/upload/**", "anon");
        filterChainDefinitionMap.put("/files/**", "anon");
        filterChainDefinitionMap.put("/test/**", "anon");
        filterChainDefinitionMap.put("/logout", "logout");
        filterChainDefinitionMap.put("/", "anon");
        filterChainDefinitionMap.put("/**", "user");

        // 添加jwt过滤器
        Map<String, Filter> filterMap = new HashMap<>();
        filterMap.put("jwt", new JWTAuthenticationFilter());
        shiroFilterFactoryBean.setFilters(filterMap);

        shiroFilterFactoryBean.setFilterChainDefinitionMap(filterChainDefinitionMap);
        return shiroFilterFactoryBean;
    }

    @Bean
    SessionDAO sessionDAO(ShiroProperties config) {
        return new RedisSessionDAO(config.getSessionKeyPrefix());
    }

    @Bean
    public SimpleCookie rememberMeCookie() {
        SimpleCookie cookie = new SimpleCookie("rememberMe");
        cookie.setMaxAge(86400);
        return cookie;
    }

    @Bean
    public RedisTemplate<Object, Object> redisTemplate(RedisConnectionFactory redisConnectionFactory) {
        RedisTemplate<Object, Object> template = new RedisTemplate<>();
        template.setConnectionFactory(redisConnectionFactory);
        template.setKeySerializer(new StringRedisSerializer());
//        Jackson2JsonRedisSerializer jackson2JsonRedisSerializer = new Jackson2JsonRedisSerializer( Object.class );
//        ObjectMapper om = new ObjectMapper ();
//        jackson2JsonRedisSerializer.setObjectMapper ( om );
//        template.setValueSerializer(jackson2JsonRedisSerializer);
//        template.setHashKeySerializer(new StringRedisSerializer());
//        template.afterPropertiesSet();
        return template;
    }

    @Bean
    public SessionManager sessionManager(SessionDAO sessionDAO, SimpleCookie simpleCookie) {
        DefaultWebSessionManager sessionManager = new DefaultWebSessionManager();
        Collection<SessionListener> sessionListeners = new ArrayList<>();
        sessionListeners.add(new BDSessionListener());
        sessionManager.setSessionListeners(sessionListeners);
        sessionManager.setSessionDAO(sessionDAO);
        sessionManager.setGlobalSessionTimeout(24 * 60 * 60 * 1000);
        // 去掉 JSESSIONID
        sessionManager.setSessionIdUrlRewritingEnabled(false);
        return sessionManager;
    }

    @Bean(name = "shiroCacheManager")
    @DependsOn({"springContextHolder", "cacheConfiguration"})
    public CacheManager cacheManager() {
        SpringCacheManagerWrapper springCacheManager = new SpringCacheManagerWrapper();
        org.springframework.cache.CacheManager cacheManager = SpringContextHolder.getBean(org.springframework.cache.CacheManager.class);
        springCacheManager.setCacheManager(cacheManager);
        return springCacheManager;
    }

    @Bean
    Authenticator authenticator(SysUserAuthorizingRealm sysUserAuthorizingRealm, JWTAuthorizingRealm jwtAuthorizingRealm) {
        IFastModularRealm authenticator = new IFastModularRealm();
        authenticator.setAuthenticationStrategy(new AtLeastOneSuccessfulStrategy());
        List<Realm> realms = new ArrayList<>();
        realms.add(jwtAuthorizingRealm);
        realms.add(sysUserAuthorizingRealm);
        authenticator.setRealms(realms);
        return authenticator;
    }

    @Bean
    Authorizer authorizer(SysUserAuthorizingRealm sysUserAuthorizingRealm, JWTAuthorizingRealm jwtAuthorizingRealm) {
        ModularRealmAuthorizer authorizer = new ModularRealmAuthorizer();
        List<Realm> realms = new ArrayList<>();
        realms.add(jwtAuthorizingRealm);
        realms.add(sysUserAuthorizingRealm);
        authorizer.setRealms(realms);
        return authorizer;
    }

    @Bean
    SecurityManager securityManager(SessionManager sessionManager, Authorizer authorizer, Authenticator authenticator) {
        DefaultWebSecurityManager manager = new DefaultWebSecurityManager();
        manager.setAuthenticator(authenticator);
        manager.setAuthorizer(authorizer);
        manager.setCacheManager(cacheManager());
        manager.setSessionManager(sessionManager);
        manager.setRememberMeManager(rememberMeManager());
        return manager;
    }

    /**
     * cookie管理对象
     *
     * @return
     */
    public CookieRememberMeManager rememberMeManager() {
        CookieRememberMeManager cookieRememberMeManager = new CookieRememberMeManager();
        cookieRememberMeManager.setCookie(rememberMeCookie());
        // rememberMe cookie加密的密钥
        cookieRememberMeManager.setCipherKey(Base64.decode("3AvVhmFLUs0KTA3Kprsdag=="));
        return cookieRememberMeManager;
    }

    @Bean
    public LifecycleBeanPostProcessor lifecycleBeanPostProcessor() {
        return new LifecycleBeanPostProcessor();
    }

    @Bean
    public DefaultAdvisorAutoProxyCreator defaultAdvisorAutoProxyCreator() {
        DefaultAdvisorAutoProxyCreator proxyCreator = new DefaultAdvisorAutoProxyCreator();
        proxyCreator.setProxyTargetClass(true);
        return proxyCreator;
    }

    @Bean
    public ShiroDialect shiroDialect() {
        return new ShiroDialect();
    }

    @Bean
    public AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor(SecurityManager securityManager) {
        AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor = new AuthorizationAttributeSourceAdvisor();
        authorizationAttributeSourceAdvisor.setSecurityManager(securityManager);
        return authorizationAttributeSourceAdvisor;
    }

}
