var prefix = "/cms/article";
$(function () {
    load();
});

(function ($) {
    $.getUrlParam = function (name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return decodeURI(r[2]);
        return '';
    }
})(jQuery);

function load() {
    var searchTag = $.getUrlParam('searchTag');
    var searchTitle = $.getUrlParam('searchTitle');
    var pageNumber = $.getUrlParam('pageNumber');
    if (searchTag != null && searchTag != '') {
        $(".title").text(searchTag);
        $(".content").text('');
    }
    if (searchTitle != null && searchTitle != '') {
        $(".title").text(searchTitle);
        $(".content").text('');
    }
    if (!pageNumber) {
        pageNumber = 1;
    }
    $.ajax({
        type: "GET",
        url: "/article/list",
        data: {"pageNumber": pageNumber, "pageSize": "6", "searchTag": searchTag, "searchTitle": searchTitle},
        async: false,
        error: function (request) {
        },
        success: function (data) {
            handleData(data);
        }
    });
    $('.box-title').click(function () {
        var id = $(this).parent().parent().attr("id");
        if (!id) {
            id = $(this).parent().parent().parent().attr("id");
        }
        window.open("/article/" + id);
    });
    $('.background').click(function () {
        window.open("/article/" + $(this).parent().attr("id"));
    });
    $('.load-more').click(function () {
        var title = $.getUrlParam('searchTitle');
        var tag = $.getUrlParam('searchTag');
        var pageNumber = $.getUrlParam('pageNumber');
        if ((tag != '' || title != '') || (tag == '' && title == '')) {
            var url = "/page/article?pageSize=6";
            if (pageNumber != '') {
                url = url + "&pageNumber=" + (parseInt(pageNumber) + 1);
            } else {
                url = url + "&pageNumber=2";
            }
            if (tag != '') {
                url = url + "&searchTag=" + tag;
            }
            if (title != '') {
                url = url + "&searchTitle=" + title;
            }
            window.open(url);
        }
    });
    $('.tag').click(function () {
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
    $('a').click(function () {
        e = window.event || e;
        if (e.stopPropagation) {
            e.stopPropagation();      //阻止事件 冒泡传播
        } else {
            e.cancelBubble = true;   //ie兼容
        }
    })
}

function handleData(data) {
    $('#article-list').empty();
    var row = data.data.records;
    if (row.length === 0) {
        return;
    }
    var line = 0;
    var num = 0;
    var selector;
    line = line + 1;
    var id = 'line-' + line;
    var box = '<div class="boxes am-u-sm-12" id="' + id + '"></div>';
    $('#article-list').append(box);
    selector = $('#' + id);
    var j = 0;
    var len = row.length;
    while (j < len) {
        var obj = row[j];
        var style = obj.style;
        if (style == 2 || style == 3) {
            num = num + 1;
        } else if (style == 1) {
            if (num >= 2) {
                style = 2;
                num = num + 1;
            } else {
                num = num + 2;
            }
        } else if (style == 4) {
            if (num < 2) {
                style = 1;
                num = num + 2;
            } else {
                style = 2;
                num = num + 1;
            }
        }
        if (num > 4) {
            num = 0;
            line = line + 1;
            var id = 'line-' + line;
            var box = '<div class="boxes am-u-sm-12" id="' + id + '"></div>';
            $('#article-list').append(box);
            selector = $('#' + id)
        }
        var html;
        if (style == 1) {
            html = '<div id="' + obj.id + '" class="box box1">\n' +
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
            html = '<div id="' + obj.id + '" class="box box2">\n' +
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
            html = '<div id="' + obj.id + '" class="box box3">\n' +
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
                $("#" + obj.id).append('<a href="' + json.url + '" target="_blank"><img class="social-icon" src="' + prefix + '"/></a>');
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
                $("#" + obj.id).append('<a href="' + json.url + '" target="_blank"><img class="social-icon" src="' + prefix + '"/></a>');
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
                $("#" + obj.id).append('<a href="' + json.url + '" target="_blank"><img class="social-icon" src="' + prefix + '"/></a>');
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
                $("#" + obj.id).append('<a href="' + json.url + '" target="_blank"><img class="social-icon" src="' + prefix + '"/></a>');
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
                $("#" + obj.id).append('<a href="' + json.url + '" target="_blank"><img class="social-icon" src="' + prefix + '"/></a>');
            }
        }
        var width = $("#" + obj.id).outerWidth();
        var height = $("#" + obj.id).outerHeight();
        if (style == 3) {
            $("#" + obj.id).css({
                "background": "url(" + obj.thumbnail + ")"
                , "background-size": "cover"
            });
            $("#" + obj.id + " .overlay").css({
                "width": "" + width + ""
                , "height": "" + height + ""
            })
        }
        var tagList = $("#" + obj.id + " .tag-list");
        for (var i = 0; i < obj.tag.length; i++) {
            var tagHtml = '<div class="tag">' + obj.tag[i] + '</div>';
            tagList.append(tagHtml);
        }
        j++
    }
}

function search() {
    var title = $("#search-title").val();
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