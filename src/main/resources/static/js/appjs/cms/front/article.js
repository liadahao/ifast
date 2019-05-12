var prefix = "/cms/article";
$(function () {
    load_article();
});

(function ($) {
    $.getUrlParam = function (name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return decodeURI(r[2]);
        return '';
    }
})(jQuery);

function load_article() {
    var searchTag = $.getUrlParam('searchTag');
    var searchTitle = $.getUrlParam('searchTitle');
    var pageNumber = $.getUrlParam('pageNumber');
    var pageSize = 6;
    if (searchTag != null && searchTag != '') {
        $(".article-body .title").text(searchTag);
        $(".article-body .title").css('width', '100%');
        $(".article-body .content").text('');
        $(".article-body .content").hide('');
    }
    if (searchTitle != null && searchTitle != '') {
        $(".article-body .title").text(searchTitle);
        $(".article-body .title").css('width', '100%');
        $(".article-body .content").hide('');
    }
    if (!pageNumber) {
        pageNumber = 1;
    } else if (parseInt(pageNumber) === 2) {
        pageNumber = 1;
        pageSize = 12;
    }
    $.ajax({
        type: "GET",
        url: "/article/list",
        data: {"pageNumber": pageNumber, "pageSize": pageSize, "searchTag": searchTag, "searchTitle": searchTitle},
        async: false,
        error: function (request) {
        },
        success: function (data) {
            handleArticleData(data);
        }
    });
    $('.article-body .box-title').click(function () {
        var id = $(this).parent().parent().attr("id");
        if (!id) {
            id = $(this).parent().parent().parent().attr("id");
        }
        id = id.split("-")[1];
        window.open("/article/" + id);
    });
    $('.article-body .background').click(function () {
        var id = $(this).parent().attr("id");
        id = id.split("-")[1];
        window.open("/article/" + id);
    });
    $('.article-body .load-more').click(function () {
        var title = $.getUrlParam('searchTitle');
        var tag = $.getUrlParam('searchTag');
        var pageNumber = $.getUrlParam('pageNumber');
        if ((tag != '' || title != '') || (tag == '' && title == '')) {
            var url;
            if (pageNumber != '' && parseInt(pageNumber) > 1) {
                url = "/article/list?pageSize=6";
                url = url + "&pageNumber=" + (parseInt(pageNumber) + 1);
            } else {
                url = "/page/article?pageSize=6";
                url = url + "&pageNumber=2";
            }
            if (tag != '') {
                url = url + "&searchTag=" + tag;
            }
            if (title != '') {
                url = url + "&searchTitle=" + title;
            }
            if (pageNumber != '' && parseInt(pageNumber) > 1) {
                $.ajax({
                    type: "GET",
                    url: url,
                    async: false,
                    error: function (request) {
                    },
                    success: function (data) {
                        window.history.pushState({}, "", url);
                        if (data.data.records.length === 0) {
                            return;
                        }
                        handleArticleData(data);
                    }
                });
            } else {
                window.open(url);
            }
        }
    });
    $('.article-body .tag').click(function () {
        var tag = $(this).text();
        if ((tag != '' || title != '') || (tag == '' && title == '')) {
            var url = "/page/article?pageNumber=1&pageSize=6";
            if (tag != '') {
                url = url + "&searchTag=" + tag;
            }
            window.open(url);
        }
        e = window.event || e;
        if (e.stopPropagation) {
            e.stopPropagation();      //阻止事件 冒泡传播
        } else {
            e.cancelBubble = true;   //ie兼容
        }
    });
    $('.article-body a').click(function () {
        e = window.event || e;
        if (e.stopPropagation) {
            e.stopPropagation();      //阻止事件 冒泡传播
        } else {
            e.cancelBubble = true;   //ie兼容
        }
    })
}

function handleArticleData(data) {
    var articleList = $("#article-list");
    var row = data.data.records;
    if (row.length === 0) {
        $(".article-body .load-more").parent().hide();
        var textDiv = $('<div>No Search Results</div>').css({
            "margin": "50px auto",
            "text-align": "center",
            "font-size": "42px",
            "color": "white"
        });
        articleList.append(textDiv);
        return;
    }
    var line = articleList.children().size();
    var num = 0;
    var selector;
    line = line + 1;
    var id = 'article-line-' + line;
    var box = '<div class="boxes am-u-sm-12" id="' + id + '"></div>';
    articleList.append(box);
    selector = $('#' + id);
    var j = 0;
    var len = row.length;
    while (j < len) {
        num++;
        var obj = row[j];
        var style;
        if (num > 3) {
            num = 1;
            line = line + 1;
            var id = 'article-line-' + line;
            var box = '<div class="boxes am-u-sm-12" id="' + id + '"></div>';
            articleList.append(box);
            selector = $('#' + id)
        }
        if (line % 3 === 1) {
            style = num;
        }
        if (line % 3 === 2) {
            style = num + 1;
            if (style > 3) {
                style = style - 3;
            }
        }
        if (line % 3 === 0) {
            if (num === 1) {
                style = 2;
            }
            if (num === 2) {
                style = 1;
            }
            if (num === 3) {
                style = 3;
            }
        }
        var html;
        if (style == 1) {
            html = '<div id="article-' + obj.id + '" class="box box1">\n' +
                '            <img class="background" src="' + obj.thumbnail + '"/>\n' +
                '            <div class="text">\n' +
                '                <h1 class="box-title">\n' +
                obj.title +
                '                </h1>\n' +
                '                <div class="box-conetnt">\n' +
                obj.summary +
                '                </div><div class="tag-list">\n' +
                '' +
                '                </div><div class="author">\n' +
                obj.author +
                '                </div><div class="create-time">' + obj.createTime + '</div></div>\n' +
                '        </div>'
        }
        if (style == 2) {
            html = '<div id="article-' + obj.id + '" class="box box2">\n' +
                '            <img class="background" src="' + obj.thumbnail + '"/>\n' +
                '            <div class="text">\n' +
                '                <h1 class="box-title">\n' +
                obj.title +
                '                </h1>\n' +
                '                <div class="box-conetnt">\n' +
                obj.summary +
                '                </div><div class="tag-list">\n' +
                '' +
                '                </div><div class="author">\n' +
                obj.author +
                '                </div><div class="create-time">' + obj.createTime + '</div></div>\n' +
                '        </div>'
        }
        if (style == 3) {
            html = '<div id="article-' + obj.id + '" class="box box3">\n' +
                '            <div class="overlay">\n' +
                '            <div class="text">\n' +
                '                <h1 class="box-title">\n' +
                obj.title +
                '                </h1>\n' +
                '                <div class="box-conetnt">\n' +
                obj.summary +
                '                </div><div class="tag-list">\n' +
                '' +
                '                </div><div class="author">\n' +
                obj.author +
                '                </div><div class="create-time">' + obj.createTime + '</div></div>\n' +
                '        </div></div>'
        }
        selector.append(html);
        if (obj.facebook) {
            var json = JSON.parse(obj.facebook);
            var prefix;
            if (style != 3) {
                prefix = "/img/0501share_facebook_def.png";
            } else {
                prefix = "/img/0503share_facebook_def.png";
            }
            if (json.isTop) {
                $("#article-" + obj.id).append('<a href="' + json.url + '" target="_blank"><img class="social-icon" src="' + prefix + '"/></a>');
            }
        }
        if (obj.linkedin) {
            var json = JSON.parse(obj.linkedin);
            var prefix;
            if (style != 3) {
                prefix = "/img/0501share_linkedin_def.png";
            } else {
                prefix = "/img/0503share_linkedin_def.png";
            }
            if (json.isTop) {
                $("#article-" + obj.id).append('<a href="' + json.url + '" target="_blank"><img class="social-icon" src="' + prefix + '"/></a>');
            }
        }
        if (obj.twitter) {
            var json = JSON.parse(obj.twitter);
            var prefix;
            if (style != 3) {
                prefix = "/img/0501share_twitter_def.png";
            } else {
                prefix = "/img/0503share_twitter_def.png";
            }
            if (json.isTop) {
                $("#article-" + obj.id).append('<a href="' + json.url + '" target="_blank"><img class="social-icon" src="' + prefix + '"/></a>');
            }
        }
        if (obj.medium) {
            var json = JSON.parse(obj.medium);
            var prefix;
            if (style != 3) {
                prefix = "/img/0501share_medium_def.png";
            } else {
                prefix = "/img/0503share_medium_def.png";
            }
            if (json.isTop) {
                $("#article-" + obj.id).append('<a href="' + json.url + '" target="_blank"><img class="social-icon" src="' + prefix + '"/></a>');
            }
        }
        if (obj.instagram) {
            var json = JSON.parse(obj.instagram);
            var prefix;
            if (style != 3) {
                prefix = "/img/0501share_instagram_def.png";
            } else {
                prefix = "/img/0503share_instagram_def.png";
            }
            if (json.isTop) {
                $("#article-" + obj.id).append('<a href="' + json.url + '" target="_blank"><img class="social-icon" src="' + prefix + '"/></a>');
            }
        }
        var width = $("#article-" + obj.id).outerWidth();
        var height = $("#article-" + obj.id).outerHeight();
        if (style == 3) {
            $("#article-" + obj.id).css({
                "background": "url(" + obj.thumbnail + ")"
                , "background-size": "cover"
            });
            $("#article-" + obj.id + " .overlay").css({
                "width": "" + width + ""
                , "height": "" + height + ""
            })
        }
        var tagList = $("#article-" + obj.id + " .tag-list");
        var tagListWidth = tagList.width();
        var tempWidth = 0, tagIndex = 0;
        while (tempWidth < tagListWidth && tagIndex < obj.tag.length) {
            var tagHtml = '<div class="tag">' + obj.tag[tagIndex] + '</div>';
            tagList.append(tagHtml);
            tempWidth = tempWidth + tagList.children().eq(tagIndex).outerWidth();
            if (tagIndex !== (obj.tag.length - 1)) {
                tempWidth = tempWidth + 10;
            }
            if (tempWidth > tagListWidth) {
                tagList.find(":last-child").remove();
            }
            tagIndex++;
        }
        j++
    }
}

function article_search() {
    var title = $("#article-search-title").val();
    var tag = $.getUrlParam('searchTag');
    if ((tag != '' || title != '') || (tag == '' && title == '')) {
        var url = "/page/article?pageNumber=1&pageSize=6";
        if (tag != '') {
            url = url + "&searchTag=" + tag;
        }
        if (title != '') {
            url = url + "&searchTitle=" + title;
        }
        window.open(url);
    }
}