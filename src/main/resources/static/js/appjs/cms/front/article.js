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
}

function handleData(data) {
    var row = data.data.records;
    var line = 0;
    var num = 0;
    var selector;
    line = line + 1;
    var id = 'line-' + line;
    var box = '<div class="boxes" id="' + id + '"></div>';
    $('.article').append(box);
    selector = $('#' + id)
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
            $('.article').append(box);
            selector = $('#' + id)
        }
        var html;
        if (style == 1) {
            html = '<div class="box box1">\n' +
                '            <img src="' + obj.thumbnail + '"/>\n' +
                '            <div class="text">\n' +
                '                <h1 class="box-title">\n' +
                obj.title +
                '                </h1>\n' +
                '                <div class="box-conetnt">\n' +
                obj.content +
                '                </div><div class="tag-list">\n' +
                '' +
                '                </div><div class="author">\n' +
                obj.author +
                '                </div><div class="create-time">' + obj.createTime + '</div></div>\n' +
                '        </div>'
        }
        if (style == 2) {
            html = '<div class="box box2">\n' +
                '            <img src="' + obj.thumbnail + '"/>\n' +
                '            <div class="text">\n' +
                '                <h1 class="box-title">\n' +
                obj.title +
                '                </h1>\n' +
                '                <div class="box-conetnt">\n' +
                obj.content +
                '                </div><div class="tag-list">\n' +
                '' +
                '                </div><div class="author">\n' +
                obj.author +
                '                </div><div class="create-time">' + obj.createTime + '</div></div>\n' +
                '        </div>'
        }
        if (style == 3) {
            html = '<div class="box box3">\n' +
                '            <img src="' + obj.thumbnail + '"/>\n' +
                '            <div class="text">\n' +
                '                <h1 class="box-title">\n' +
                obj.title +
                '                </h1>\n' +
                '                <div class="box-conetnt">\n' +
                obj.content +
                '                </div><div class="tag-list">\n' +
                '' +
                '                </div><div class="author">\n' +
                obj.author +
                '                </div><div class="create-time">' + obj.createTime + '</div></div>\n' +
                '        </div>'
        }
        selector.append(html);
    }
}