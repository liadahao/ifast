package com.cms.core;

/**
 * <pre>
 * </pre>
 * <small> 2018年4月6日 | Aron</small>
 *
 * @author dahao
 */
public enum HtmlConstant {


    TECHTOUR(2, "techtour"),

    WORKSHOP(3, "workshop"),

    SERVICE(4, "service"),

    TESTIMONIALS(5, "testimonials"),

    ABOUT(6, "about");

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
