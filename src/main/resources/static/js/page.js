function navslidepage(index) {
    slide.slideTo(index);
    $("#doc-oc-demo3").offCanvas("close");
}

$(".workshop-right-side-prev").on("click", function () {
    id = id.split('-')[0];
    var locatList = $("#" + id + "-right-side-locat");
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
});

$(".workshop-right-side-next").on("click", function () {
    var id = $(this).attr('id');
    id = id.split('-')[0];
    var locatList = $("#" + id + "-right-side-locat");
    var len = locatList.children().size();
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
});

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
            $("#" + id + "-people-image").attr("src", src)
        }
    });
});

// 设置shop页

var productImageList = $(".image-list").children();
var productImageListLen = productImageList.size();
$(".image-controller").click(function () {
    var controllerIndex = $(this).index();
    $(".controller-list").children().each(function (index) {
        if (index !== controllerIndex) {
            $(".controller-list").children().eq(index).removeClass("image-controller-select");
        } else {
            $(".controller-list").children().eq(index).addClass("image-controller-select");
        }
    });
    var showIndex = productImageListLen - $(this).index() - 1;
    productImageList.each(function (index) {
        if (index !== showIndex) {
            $(this).hide();
        } else {
            $(this).show();
        }
    });
});

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
        $.ajax({
            type: "GET",
            url: "/shop/" + $(this).attr("id"),
            async: false,
            error: function (request) {
            },
            success: function (data) {
                loadProductData(data);
            }
        });
    });
}

function loadProductData(data) {
    if (data) {
        $(".product-title").text(data.name);
        $(".product-description").text(data.description);
        $(".price").text(data.price);
        $(".product-detail").text(data.detail);
        $(".image-list").empty();
        $(".controller-list").empty();
        if (data.image1) {
            $(".image-list").append('<img src="' + data.image1 + '" class="product-image"/>');
            $(".controller-list").prepend('<div class="image-controller image-controller-select"></div>')
        }
        if (data.image2) {
            $(".image-list").append('<img src="' + data.image2 + '" class="product-image" style="display: none"/>');
            $(".controller-list").prepend('<div class="image-controller"></div>')
        }
        if (data.image3) {
            $(".image-list").append('<img src="' + data.image3 + '" class="product-image" style="display: none"/>');
            $(".controller-list").prepend('<div class="image-controller"></div>')
        }
        if (data.image4) {
            $(".image-list").append('<img src="' + data.image4 + '" class="product-image" style="display: none"/>');
            $(".controller-list").prepend('<div class="image-controller"></div>')
        }
        if (data.image5) {
            $(".image-list").append('<img src="' + data.image5 + '" class="product-image" style="display: none"/>');
            $(".controller-list").prepend('<div class="image-controller"></div>')
        }
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
        });
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
    }
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

//引用方法
$(function () {
    var id = '#doc-oc-demo3';
    var $myOc = $(id);
    $('.side-close').on('click', function () {
        $myOc.offCanvas($(this).data('rel'));
    });

    function GetQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]);
        return null;
    }

    pageParams = GetQueryString('page') * 1;
    renderPagination();
    var initPage = pageParams || 1;
    var currentPage = initPage;
    var slide = new slidePage({
        slidePages: '.slide-page',
        slideContainer: '#slide-container',
        refresh: true,
        page: initPage,
        before: function (origin, diraction, target) {
            pagepages = document.querySelectorAll('#pagination li');
            pagepages[origin - 1].classList.remove('select-circular');
            pagepages[origin - 1].classList.add('circular');
            pagepages[target - 1].classList.add('select-circular');
            pagepages[target - 1].classList.remove('circular');
            currentPage = target
        },
        after: function (origin, diraction, target) {
            if (target > 1) {
                var topname = document.querySelectorAll('.slide-page')[target - 2].getAttribute('data-name');
                document.querySelectorAll('.top-text')[0].innerHTML = topname;
                document.querySelectorAll('.top a')[0].href = '#';
            } else {
                document.querySelectorAll('.top-text')[0].innerHTML = 'Home';
                document.querySelectorAll('.top a')[0].href = '/index';
            }
            var len = document.querySelectorAll('.slide-page').length;
            if (target < len) {
                var bottomname = document.querySelectorAll('.slide-page')[target].getAttribute('data-name');
                document.querySelectorAll('.bottom-text')[0].innerHTML = bottomname;
            }
        },
    });
    window.slide = slide;
    // -- 由于slidePage不提供分页组件，所以以下是当前示例的分页器逻辑
    pagination.querySelectorAll('li')[initPage - 1].classList.remove('circular');
    pagination.querySelectorAll('li')[initPage - 1].classList.add('select-circular');
    if (initPage > 1) {
        var topname = document.querySelectorAll('.slide-page')[initPage - 2].getAttribute('data-name');
        document.querySelectorAll('.top-text')[0].innerHTML = topname;
        document.querySelectorAll('.top a')[0].href = '#';
    } else {
        document.querySelectorAll('.top-text')[0].innerHTML = 'Home';
        document.querySelectorAll('.top a')[0].href = '/index';
    }
    var len = document.querySelectorAll('.slide-page').length;
    if (initPage < len) {
        var bottomname = document.querySelectorAll('.slide-page')[initPage].getAttribute('data-name');
        document.querySelectorAll('.bottom-text')[0].innerHTML = bottomname;
    }

    function renderPagination() {
        var pagination = document.querySelector('#pagination');
        var len = document.querySelectorAll('.slide-page').length;
        var paginationContent = '';
        // 渲染页码
        for (var i = 1; i <= len; i++) {
            paginationContent += '<li onclick="slide.slideTo(' + i + ')" class="circular"></li>';
        }
        pagination.querySelector('.pagination-page').innerHTML = paginationContent;
    }

    init();

    function init() {
        var len = document.querySelectorAll('.slide-page').length;
        for (var i = 0; i < len; i++) {
            var page = document.querySelectorAll('.slide-page')[i];
            var template = page.getAttribute('data-template');
            if (template == 'workshop') {
                workshopInit(page.id);
            }
        }
    }

    function workshopInit(id) {
        id = id.split('-')[0];
        const players = Plyr.setup('#' + id + ' .workshop-player', {controls, clickToPlay: false});
    }

    var width = $(window).width();
    var navWidth = (width - 1240) / 2;
    $(".article-body").css('margin-left', navWidth);
    $(".event-body").css('margin-left', navWidth);
    // The slider being synced must be initialized first
    $('#gallery-carousel').flexslider({
        animation: "slide",
        controlNav: false,
        animationLoop: true,
        slideshow: false,
        itemWidth: 140,
        itemMargin: 24,
        asNavFor: '#gallery-slider',
        prevText: '',
        nextText: ''
    });

    $('#gallery-slider').flexslider({
        animation: "slide",
        controlNav: false,
        directionNav: false,
        animationLoop: true,
        slideshow: false,
        sync: "#gallery-carousel"
    });
});

//初始化视频
const controls = '<button type="button" class="plyr__control plyr__control--overlaid plyr__tab-focus"><svg role="presentation" focusable="false"><use xlink:href="#plyr-play"></use></svg><span class="plyr__sr-only">Play</span></button>';
const player = new Plyr('#video-popup-player');
const players = Plyr.setup('.player', {controls, clickToPlay: false});
const player1s = Plyr.setup('.testimonials-player', {controls, clickToPlay: false});

$('#video-popup').on('close.modal.amui', function () {
    player.pause();
});

$(".video-container").on('click', function () {
    var url = $(this).attr('video-url');
    player.source = {
        type: 'video',
        sources: [
            {
                src: url,
                provider: 'youtube',
            },
        ],
    };
});

$('.collapse-video-container').on('click', function () {
    var url = $(this).attr('video-url');
    player.source = {
        type: 'video',
        sources: [
            {
                src: url,
                provider: 'youtube',
            },
        ],
    };
});

$('.workshop-carousel-img').on('click', function () {
    var url = $(this).attr('data-thumb');
    player.source = {
        type: 'video',
        sources: [
            {
                src: url,
                provider: 'youtube',
            },
        ],
    };
});

$(".video-thumbnail").click(function () {
    var id = $(this).attr('id');
    id = id.split("-")[0];
    var selector = $("#" + id + "-carousel-img");
    var url = $(this).parent().attr('data-thumb');
    var bg = $(this).find(".plyr__poster").css("background-image");
    var html = '<button type="button" class="plyr__control plyr__control--overlaid"\n' +
        '                                style="display: block;top: 60%">\n' +
        '                            <svg role="presentation" focusable="false">\n' +
        '                                <use xlink:href="#plyr-play"></use>\n' +
        '                            </svg>\n' +
        '                            <span class="plyr__sr-only">Play</span></button>';
    selector.empty();
    selector.append(html);
    selector.css("background-image", bg);
    selector.attr("data-thumb", url);
});

$(".second-video").on('click', function () {
    var url = $(this).attr('data-thumb');
    player.source = {
        type: 'video',
        sources: [
            {
                src: url,
                provider: 'youtube',
            },
        ],
    };
});

$(".up-video").on('click', function () {
    var id = $(this).attr('id');
    id = id.split("-")[0];
    var selector1 = $("#" + id + "-first-video");
    var selector2 = $("#" + id + "-second-video");
    var selector3 = $("#" + id + "-third-video");

    var url1 = selector1.attr('data-thumb');
    var url2 = selector2.attr('data-thumb');
    var url3 = selector3.attr('data-thumb');
    var bg1 = selector1.find(".plyr__poster").css("background-image");
    var bg2 = selector2.find(".plyr__poster").css("background-image");
    var bg3 = selector3.find(".plyr__poster").css("background-image");

    selector1.attr('data-thumb', url2);
    selector2.attr('data-thumb', url3);
    selector3.attr('data-thumb', url1);
    selector1.find(".plyr__poster").css("background-image", bg2);
    selector2.find(".plyr__poster").css("background-image", bg3);
    selector3.find(".plyr__poster").css("background-image", bg1);
});

$(".down-video").on('click', function () {
    var id = $(this).attr('id');
    id = id.split("-")[0];
    var selector1 = $("#" + id + "-first-video");
    var selector2 = $("#" + id + "-second-video");
    var selector3 = $("#" + id + "-third-video");

    var url1 = selector1.attr('data-thumb');
    var url2 = selector2.attr('data-thumb');
    var url3 = selector3.attr('data-thumb');
    var bg1 = selector1.find(".plyr__poster").css("background-image");
    var bg2 = selector2.find(".plyr__poster").css("background-image");
    var bg3 = selector3.find(".plyr__poster").css("background-image");

    selector1.attr('data-thumb', url3);
    selector2.attr('data-thumb', url1);
    selector3.attr('data-thumb', url2);
    selector1.find(".plyr__poster").css("background-image", bg3);
    selector2.find(".plyr__poster").css("background-image", bg1);
    selector3.find(".plyr__poster").css("background-image", bg2);
});