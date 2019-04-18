package com.cms.core;

/**
 * @author dahao
 * @version 2019/4/18.
 */
public enum TagConstant {

    ARTICLE(1, "文章"),
    EVNENT(2, "活动"),
    PRODUCT(3, "商品");

    public int type;
    public String name;

    TagConstant(int type, String name) {
        this.type = type;
        this.name = name;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public static String getName(int type) {
        for (TagConstant tagConstant : values()) {
            if (tagConstant.getType() == type) {
                return tagConstant.getName();
            }
        }
        return null;
    }

}
