$(function () {
    load();
});

function load() {
    $.ajax({
        type: "GET",
        url: "/event/list",
        data: {"pageNumber": "1", "pageSize": "8"},
        async: false,
        error: function (request) {
        },
        success: function (data) {
            handleData(data);
        }
    });
}

function search() {
    var type = $("#search-type").val();
    var date = $("#search-date").val();
    $.ajax({
        type: "GET",
        url: "/event/list",
        data: {"pageNumber": "1", "pageSize": "8", "type": type, "starttime": date},
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
    var selector;
    $('#event-list').empty()
    for (var j = 0, len = row.length; j < len; j++) {
        var obj = row[j];
        if (j % 4 === 0) {
            line = line + 1;
            var id = "line-" + line;
            var box = '<div id="' + id + '" class="boxes am-avg-sm-2 am-avg-md-3 am-avg-lg-4"></div>';
            $('#event-list').append(box);
            selector = $('#' + id);
        }
        var html = '<li class="box">\n' +
            '            <img src="/img/8a30e88df3c32bc450f315ec62283436.jpg"/>\n' +
            '            <div class="text" data-url="' + obj.linkto + '">\n' +
            '                <h3 class="event-title">\n' +
            obj.title +
            '                </h3>\n' +
            '                <p class="event-date">\n' +
            obj.starttime +
            '                </p>\n' +
            '                <p class="event-address">\n' +
            '                    <img src="/img/0701Location.png"/>\n' +
            obj.address +
            '                </p>\n' +
            '                <p class="event-price">\n' +
            obj.price +
            '                </p>\n' +
            '            </div>\n' +
            '        </li>';
        selector.append(html);
    }
    $(".text").click(function () {
        var url = $(this).attr("data-url");
        window.open(url);
    })
}

