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
    var tagId = $.getUrlParam('tagId');
    var starttime = $.getUrlParam('starttime');
    var pageNumber = $.getUrlParam('pageNumber');
    var pageSize = 8;
    if (!pageNumber) {
        pageNumber = 1;
    } else if (parseInt(pageNumber) === 2) {
        pageNumber = 1;
        pageSize = 16;
    }
    $.ajax({
        type: "GET",
        url: "/event/list",
        data: {"pageNumber": pageNumber, "pageSize": pageSize, "tagId": tagId, "starttime": starttime},
        async: false,
        error: function (request) {
        },
        success: function (data) {
            handleData(data);
        }
    });
    $('.load-more').click(function () {
        var tagId = $.getUrlParam('tagId');
        var date = $.getUrlParam('starttime');
        var pageNumber = $.getUrlParam('pageNumber');
        if ((tagId != '' || date != '') || (tagId == '' && date == '')) {
            var url;
            if (pageNumber != '' && parseInt(pageNumber) > 1) {
                url = "/event/list?pageSize=8";
                url = url + "&pageNumber=" + (parseInt(pageNumber) + 1);
            } else {
                url = "/page/event?pageSize=8";
                url = url + "&pageNumber=2";
            }
            if (tagId != '') {
                url = url + "&tagId=" + tagId;
            }
            if (date != '') {
                url = url + "&starttime=" + date;
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
                        handleData(data);
                    }
                });
            } else {
                window.open(url);
            }
        }
    });
    $('.tag').click(function () {
        var tag = $(this).attr('data-id');
        var url = "/page/event?pageNumber=1&pageSize=8";
        if (tag != '') {
            url = url + "&tagId=" + tag;
        }
        window.open(url);
    });
}

function search() {
    var tagId = $("#search-tag").val();
    var date = $("#search-date").val();
    if ((tagId != '' || date != '') || (tagId == '' && date == '')) {
        var url = "/page/event?pageNumber=1&pageSize=8";
        if (tagId != '') {
            url = url + "&tagId=" + tagId;
        }
        if (date != '') {
            url = url + "&starttime=" + date;
        }
        window.open(url);
    }
}

function handleData(data) {
    var eventList = $("#event-list");
    var row = data.data.records;
    if (row.length === 0) {
        return;
    }
    var line = eventList.children().size();
    var selector;
    for (var j = 0, len = row.length; j < len; j++) {
        var obj = row[j];
        if (j % 4 === 0) {
            line = line + 1;
            var id = "line-" + line;
            var box = '<div id="' + id + '" class="boxes am-avg-sm-2 am-avg-md-3 am-avg-lg-4"></div>';
            eventList.append(box);
            selector = $('#' + id);
        }
        var html = '<li id="' + obj.id + '" class="box">\n' +
            '            <div class="tag" data-id="' + obj.tagId + '">' + obj.tag + '</div>\n' +
            '            <img src="/img/8a30e88df3c32bc450f315ec62283436.jpg"/>\n' +
            '            <div class="text" data-url="' + obj.linkto + '">\n' +
            '                <h3 class="event-title">\n' +
            obj.title +
            '                </h3>\n' +
            '                <p class="event-date">\n' +
            obj.starttime +
            '                </p>\n' +
            '                <div class="event-address">\n' +
            '                    <img src="/img/0701Location.png"/>\n<p class="am-text-top">' +
            obj.address +
            '                </p></div>\n' +
            '                <p class="event-price">\n' +
            obj.price +
            '                </p>\n' +
            '            </div>\n' +
            '        </li>';
        selector.append(html);
        if (obj.thumbnail && obj.thumbnail !== '') {
            $('#' + obj.id).children('img').attr('src', obj.thumbnail);
        }
    }
    $(".text").click(function () {
        var url = $(this).attr("data-url");
        window.open(url);
    })
}

