var prefix = "/cms/article";
$(function () {
    load();
});

function load() {
    $.ajax({
        type: "GET",
        url: "/article/list",
        data: {"pageNumber": "1", "pageSize": "6"},
        async: false,
        error: function (request) {
        },
        success: function (data) {
            handleData(data);
        }
    });
    $('.box').click(function () {
        window.location.href = "/article/" + $(this).attr("id");
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
    if(row.length===0){
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
    for (var j = 0, len = row.length; j < len; j++) {
        var obj = row[j];
        var style = obj.style;
        if (style == 2 || style == 3) {
            num = num + 1;
        } else if (style == 1) {
            num = num + 2;
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
            var box = '<div class="boxes" id="' + id + '"></div>';
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
            if (json.isTop) {
                $("#" + obj.id).append('<a href="' + json.url + '" target="_blank"><img class="social-icon" src="/img/0501share_facebook_def.png"/></a>');
            }
        }
        if (obj.linkedin) {
            var json = JSON.parse(obj.linkedin);
            if (json.isTop) {
                $("#" + obj.id).append('<a href="' + json.url + '" target="_blank"><img class="social-icon" src="/img/0501share_linkedin_def.png"/></a>');
            }
        }
        if (obj.twitter) {
            var json = JSON.parse(obj.twitter);
            if (json.isTop) {
                $("#" + obj.id).append('<a href="' + json.url + '" target="_blank"><img class="social-icon" src="/img/0501share_twitter_def.png"/></a>');
            }
        }
        if (obj.medium) {
            var json = JSON.parse(obj.medium);
            if (json.isTop) {
                $("#" + obj.id).append('<a href="' + json.url + '" target="_blank"><img class="social-icon" src="/img/0501share_medium_def.png"/></a>');
            }
        }
        if (obj.instagram) {
            var json = JSON.parse(obj.instagram);
            if (json.isTop) {
                $("#" + obj.id).append('<a href="' + json.url + '" target="_blank"><img class="social-icon" src="/img/0501share_instagram_def.png"/></a>');
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
    }
}

function search() {
    var title = $("#search-title").val();
    var tag = $("#search-tag").val();
    if ((tag != '' || title != '') || (tag == '' && title == '')) {
        $.ajax({
            type: "GET",
            url: "/article/list",
            data: {"pageNumber": "1", "pageSize": "8", "searchTag": tag, "searchTitle": title},
            async: false,
            error: function (request) {
            },
            success: function (data) {
                handleData(data);
            }
        });
    }
}