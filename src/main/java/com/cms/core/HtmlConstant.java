package com.cms.core;

/**
 * Html类型
 *
 * @author dahao
 */
public enum HtmlConstant {

    /**
     * 首页
     */
    INDEX(1, "index"),

    /**
     * Techtour页
     */
    TECHTOUR(2, "techtour"),

    WORKSHOP(3, "workshop"),

    SERVICE(4, "service"),

    TESTIMONIALS(5, "testimonials"),

    ABOUT(6, "about"),

    ADD_LINK(7, "add-link"),

    ARTICLE(8, "article"),

    EVENT(9, "event"),

    GALLERY(10, "gallery"),

    SHOP(11, "shop");

    public int type;
    public String html;

    HtmlConstant(int type, String html) {
        this.type = type;
        this.html = html;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getHtml() {
        return html;
    }

    public void setHtml(String html) {
        this.html = html;
    }

    public static String getHtml(int type) {
        for (HtmlConstant htmlConstant : values()) {
            if (htmlConstant.getType() == type) {
                return htmlConstant.getHtml();
            }
        }
        return null;
    }

}
