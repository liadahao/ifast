$(function ($) {
    $.fn.screen = function (options) {
        var $this = this;//第一个div
        var set = $.extend({
            before: [],
            after: []
        }, options);

        $this.css({
            overflow: 'hidden',
            position: 'fixed',
            width: '100%',
            height: '100%',
            left: '0',
            top: '0'
        });
        var ch = $this.children('div');
        $this.empty();
        var secondDiv = $('<div></div>').css({
            position: "relative",
            left: '0',
            top: '0',
            width: '100%',
            height: '100%',
            visibility: "visible"
        });
        secondDiv.appendTo($this);
        ch.css({
            height: '100%',
            width: '100%'
        }).appendTo(secondDiv);
        var navbarUl = $("<ul></ul>").css({
            position: 'absolute',
            top: '50%',
            "z-index": "1000",
            right: "1%"
        });

        var leftbarUl = $("<div class='left-nav'></div>").css({
            height: '768px',
            position: 'absolute',
            "z-index": "1000",
            top: '50%',
            left: "1%"
        });
        // var topText =
        var top = $('<div class="top"><a href="#"><img src="/img/up.png"/><div class="top-text">Home</div></a></div>');
        var bottomText = secondDiv.children().eq(1).attr('data-name');
        var bottom = $('<div class="bottom"><a href="#"><div class="bottom-text">' + bottomText + '</div><img src="/img/down.png"/></a></div>');
        top.appendTo(leftbarUl);
        bottom.appendTo(leftbarUl);
        ch.each(function (i) {
            var barele;
            if (i == 0) {
                barele = $("<li></li>").attr("index", i).addClass("select-circular")
            } else {
                barele = $("<li></li>").attr("index", i).addClass("circular")
            }
            barele.appendTo(navbarUl);
        });
        //console.log(navbarUl.height()); //打印0
        //先将其添加到HTML文档流对象中，再设置其top位置，不然其位置计算会忽略掉其自身高度。
        navbarUl.appendTo($this);
        leftbarUl.appendTo($this);
        //console.log(navbarUl.height()); //打印182高度
        navbarUl.css({
            "margin-top": -parseInt(navbarUl.height()) / 2 + "px"
        });
        leftbarUl.css({
            "margin-top": -parseInt(leftbarUl.height()) / 2 + "px"
        });
        var wheelName = navigator.userAgent.indexOf("Firefox") > 0 ? "DOMMouseScroll" : "mousewheel";

        $this.on(wheelName, function () {
            var event = window.event || arguments.callee.caller.arguments[0];
            //console.log(event);
            var contentV = 0;
            //统一线下滚动为负数
            if (event.wheelDelta) {
                contentV = Math.floor(event.wheelDelta / 120) * 60;

            } else if (event.detail) {
                contentV = -Math.floor(event.detail / 3) * 60;
            }
            //console.log(contentV);
            if (contentV < 0) {
                //向下滚动为1，向上滚动为-1
                console.log("下滚动作");
                slide(1);
            } else {
                console.log("上滚动作");
                slide(-1);
            }
        });

        var currentPage = 0;//当前的页数

        var lg = secondDiv.children("div").length;
        //var sht=_i.children('div').outerHeight();//得到屏内容的高度。也就是每次要切屏时div向上向下移动的量。
        var flag = true;

        //n是1就向下切屏，n是-1就向上切屏。
        function slide(n) {
            if (!flag) {

                return;
            }
            flag = false;
            if (n > 0 && currentPage < (lg - 1)) {
                console.log("执行下滚");
                if (set.before[currentPage]) {
                    set.before[currentPage]();
                }
                currentPage++;
                animateDown(currentPage);

            } else {
                if (n < 0 && currentPage > 0) {
                    console.log("执行上滚")
                    if (set.before[currentPage]) {
                        set.before[currentPage]();
                    }
                    currentPage--;
                    animateDown(currentPage);
                } else {
                    flag = true;
                }
            }
        }

        function animateDown(c) {
            secondDiv.animate({top: -c * 100 + '%'}, 'normal', function () {
                navbarUl.find('li').addClass("circular").removeClass("select-circular");
                navbarUl.find('li').eq(c).addClass("select-circular").removeClass("circular");
                if (c > 0) {
                    top.find(".top-text").text(secondDiv.children().eq(c - 1).attr('data-name'));
                } else {
                    top.find(".top-text").text("Home");
                }
                if (c < lg - 1) {
                    bottom.show();
                    bottom.find(".bottom-text").text(secondDiv.children().eq(c + 1).attr('data-name'));
                } else {
                    bottom.hide();
                }
                if (set.after[c]) {
                    set.after[c]();
                }
                flag = true;
            });
        }

        //初始化容器高度
        ch.height($(window).height());
        //窗口改变，容器高度也改变
        $(window).resize(function () {
            ch.height($(window).height());
        });

        navbarUl.children('li').on('click', function () {
            var $index = $(this).index();
            animateDown($index);
            currentPage = $index;
        });

        $(".am-offcanvas-content").children().on('click', function () {
            var $index = $(this).index();
            animateDown($index);
            currentPage = $index;
            $("#doc-oc-demo3").offCanvas("close");
        });

        top.on('click', function () {
            if (currentPage > 0) {
                var $index = currentPage - 1;
                animateDown($index);
                currentPage = $index;
            } else {
                window.location.href = "/index"
            }
        });

        bottom.on('click', function () {
            var $index = currentPage + 1;
            animateDown($index);
            currentPage = $index;
        });

        var $index = $("#currentPage").val();
        $index = parseInt($index);
        if ($index > 0) {
            animateDown($index);
            currentPage = $index;
        } else {
            animateDown(0);
            currentPage = 0;
        }
    }
}(jQuery));

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
$(window).load(function () {
    var width = $(window).width();
    var navWidth = (width - 1240) / 2;
    $(".article-body").css('margin-left', navWidth);
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