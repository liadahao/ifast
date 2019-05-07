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
// 设置about页时间
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