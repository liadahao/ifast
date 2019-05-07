function navslidepage(index) {
    slide.slideTo(index);
    $("#doc-oc-demo3").offCanvas("close");
}

function workshopPrev(id) {
    id = id.split('-')[0];
    $('#' + id + '-right-container').children().each(function (index) {
        if (index === 0) {
            return true;
        }
        if (!$(this).is(':hidden')) {
            locatList.children().eq(index - 1)
                .attr("src", "/img/0301locaL.png")
                .attr("class", "locat-img-l");
            locatList.children().eq(index)
                .attr("src", "/img/0301locaS.png")
                .attr("class", "locat-img-s");
            $(this).prev().show();
            $(this).hide();
            return false;
        }
    });
}

function workshopNext(id) {
    id = id.split('-')[0];
    $('#' + id + '-right-container').children().each(function (index) {
        if (index === (len - 1)) {
            return true;
        }
        if (!$(this).is(':hidden')) {
            locatList.children().eq(index + 1)
                .attr("src", "/img/0301locaL.png")
                .attr("class", "locat-img-l");
            locatList.children().eq(index)
                .attr("src", "/img/0301locaS.png")
                .attr("class", "locat-img-s");
            $(this).next().show();
            $(this).hide();
            return false;
        }
    });
}

function testimonialsPrev(id) {
    id = id.split("-")[0];
    var list = $('#' + id + '-right-list').children();
    list.each(function (index) {
        if (index === 0) {
            return true;
        }
        if (!$(this).is(':hidden')) {
            $(this).prev().show();
            $(this).hide();
            return false;
        }
    });
}

function testimonialsNext(id) {
    id = id.split("-")[0];
    var list = $('#' + id + '-right-list').children();
    var len = list.length;
    list.each(function (index) {
        if (index === (len - 1)) {
            return true;
        }
        if (!$(this).is(':hidden')) {
            $(this).next().show();
            $(this).hide();
            return false;
        }
    });
}

//workshop
var list = $('.workshop-right-container').children();
var locatList = $('.right-side-locat');
var len = list.length;
for (var i = 1; i <= len; i++) {
    var html = '<img class="locat-img-s" src="/img/0301locaS.png"/>';
    locatList.append(html);
}
list.each(function (index) {
    if (index !== 0) {
        $(this).hide();
    } else {
        locatList.children().eq(index)
            .attr("src", "/img/0301locaL.png")
            .attr("class", "locat-img-l");
    }
});
// 设置about页事件
var about_list = $(".info-list").children();
about_list.each(function (index) {
    if (index !== 0) {
        $(this).hide();
    } else {
        var src = $(this).find('input').val();
        $(".people-image").attr("src", src)
    }
});
$('.about-who-carousel').find('li').on('click', function () {
    var id = $(this).parents('.about-who-carousel').attr('id');
    id = id.split('-')[0];
    var list = $("#" + id + "-info-list").children();
    var showIndex = $(this).index();
    list.each(function (index) {
        if (index !== showIndex) {
            $(this).hide();
        } else {
            $(this).show();
            var src = $(this).find('input').val();
            $(".people-image").attr("src", src)
        }
    });
});

// 设置shop页

var productImageList = $(".image-list").children();
var len = productImageList.size();
$(".image-controller").click(function () {
    var controllerIndex = $(this).index();
    $(".controller-list").children().each(function (index) {
        if (index !== controllerIndex) {
            $(".controller-list").children().eq(index).removeClass("image-controller-select");
        } else {
            $(".controller-list").children().eq(index).addClass("image-controller-select");
        }
    });
    var showIndex = len - $(this).index() - 1;
    productImageList.each(function (index) {
        if (index !== showIndex) {
            $(this).hide();
        } else {
            $(this).show();
        }
    });
})

var id = $("#productId").val();
$.ajax({
    type: "GET",
    url: "/shop/" + id + "/maylike",
    data: {"pageNumber": "1", "pageSize": "5"},
    async: false,
    error: function (request) {
    },
    success: function (data) {
        handleProductData(data);
    }
});

function handleProductData(data) {
    var row = data.data.records;
    if (row.length === 0) {
        return;
    }
    var list = $(".product-list");
    list.empty();
    for (var j = 0, len = row.length; j < len; j++) {
        var obj = row[j];
        var html = '<li class="product-like" id="' + obj.id + '">\n' +
            '                        <img src="' + obj.image1 + '"/>\n' +
            '                        <div class="product-info">\n' +
            '                            <p class="am-text-center">' + obj.name + '</p>\n' +
            '                            <p class="am-text-center">' + obj.price + '</p>\n' +
            '                        </div>\n' +
            '                    </li>';
        list.append(html);
    }
    $('.product-like').on('click', function () {
        window.location.href = "/shop/" + $(this).attr("id");
    });
}

function productPrev() {
    var pageNumber = $("#productPageNumber").val();
    if (pageNumber > 1) {
        pageNumber = parseInt(pageNumber) - 1;
        $("#productPageNumber").val(pageNumber);
        $.ajax({
            type: "GET",
            url: "/shop/" + id + "/maylike",
            data: {"pageNumber": pageNumber, "pageSize": "5"},
            async: false,
            error: function (request) {
            },
            success: function (data) {
                handleProductData(data);
            }
        });
    }
}

function productNext() {
    var pageNumber = $("#productPageNumber").val();
    pageNumber = parseInt(pageNumber) + 1;
    $.ajax({
        type: "GET",
        url: "/shop/" + id + "/maylike",
        data: {"pageNumber": pageNumber, "pageSize": "5"},
        async: false,
        error: function (request) {
        },
        success: function (data) {
            if (data.data.records.length > 0) {
                $("#productPageNumber").val(pageNumber);
            }
            handleProductData(data);
        }
    });
}