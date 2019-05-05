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

    ARTICLE(5, "article"),
    GALLERY(6, "gallery"),
    EVENT(7, "event"),
    TESTIMONIALS(8, "testimonials"),
    SHOP(9, "shop"),
    ABOUT(10, "about"),
    CONTACT(11, "contact"),
    ADD_LINK(12, "add-link");

    public int type;
    public String html;

    HtmlConstant(int type, String html) {
        this.type = type;
        this.html = html;
    }

    public static int getType(String name) {
        for (HtmlConstant htmlConstant : values()) {
            if (htmlConstant.getHtml().equals(name)) {
                return htmlConstant.getType();
            }
        }
        return 0;
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
