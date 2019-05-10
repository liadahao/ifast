$(function () {
    load_event();
    $("#event-list img").on('click', function f() {
        var url = $(this).next().attr("data-url");
        window.open(url);
    });
});

(function ($) {
    $.getUrlParam = function (name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return decodeURI(r[2]);
        return '';
    }
})(jQuery);

function load_event() {
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
            handleEventData(data);
        }
    });
    $('.event-body .load-more').click(function () {
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
                        handleEventData(data);
                    }
                });
            } else {
                window.open(url);
            }
        }
    });
    $('.event-body .tag').click(function () {
        var tag = $(this).attr('data-id');
        var url = "/page/event?pageNumber=1&pageSize=8";
        if (tag != '') {
            url = url + "&tagId=" + tag;
        }
        window.open(url);
    });
}

function search() {
    var tagId = $("#event-search-tag").val();
    var date = $("#event-search-date").val();
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

function handleEventData(data) {
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
            var id = "event-line-" + line;
            var box = '<div id="' + id + '" class="boxes am-avg-sm-2 am-avg-md-3 am-avg-lg-4"></div>';
            eventList.append(box);
            selector = $('#' + id);
        }
        if (obj.tag.length > 30) {
            obj.tag = obj.tag.substring(0, 30);
        }
        var html = '<li id="event-' + obj.id + '" class="box">\n' +
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
        var tag = $('#event-' + obj.id).find('.tag');
        tag.css({
            'margin-left': ($('#event-' + obj.id).width() - tag.outerWidth()) / 2,
        });
        if (obj.thumbnail && obj.thumbnail !== '') {
            $('#event-' + obj.id).children('img').attr('src', obj.thumbnail);
        }
    }
    $(".event-title").click(function () {
        var url = $(this).parent().attr("data-url");
        window.open(url);
    })
}

