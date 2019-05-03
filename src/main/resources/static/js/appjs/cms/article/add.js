$().ready(function () {
    $(".social-checkbox").click(function () {
        if ($(this).prop("checked")) {
            $(".social-checkbox").prop("checked", false);
            $(this).prop("checked", true);
        }
    });
    $("#album").click(function () {
        layer.open({
            type: 2,
            title: '相册',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['950px', '520px'],
            content: '/cms/nav/album' // iframe的url
        });
    })
});


var form = $("#article-form").show();
form.steps({
    headerTag: "h3",
    bodyTag: "fieldset",
    labels: {finish: "发布审核"},
    transitionEffect: "slideLeft",
    onStepChanging: function (event, currentIndex, newIndex) {
        // Allways allow previous action even if the current form is not valid!
        if (currentIndex > newIndex) {
            return true;
        }
        // Forbid next action on "Warning" step if the user is to young
        if (newIndex === 3 && Number($("#age-2").val()) < 18) {
            return false;
        }
        // Needed in some cases if the user went back (clean up)
        if (currentIndex < newIndex) {
            // To remove error styles
            form.find(".body:eq(" + newIndex + ") label.error").remove();
            form.find(".body:eq(" + newIndex + ") .error").removeClass("error");
        }
        if (newIndex === 2) {
            $('<li aria-hidden="false"><a href="#finish" role="menuitem" id="save-preview">保存预览</a></li>')
                .insertBefore($('ul[role="menu"]').children().eq(2));
        }
        form.validate().settings.ignore = ":disabled,:hidden";
        return form.valid();
    },
    onStepChanged: function (event, currentIndex, priorIndex) {
        // Used to skip the "Warning" step if the user is old enough.
        if (currentIndex === 2 && Number($("#age-2").val()) >= 18) {
            form.steps("next");
        }
        // Used to skip the "Warning" step if the user is old enough and wants to the previous step.
        if (currentIndex === 2 && priorIndex === 3) {
            form.steps("previous");
        }
    },
    onFinishing: function (event, currentIndex) {
        form.validate().settings.ignore = ":disabled";
        return form.valid();
    },
    onCanceled: function (event, currentIndex) {
        window.location.href = "/cms/article/"
    },
    onFinished: function (event, currentIndex) {
        var data = $('#article-form').serialize();
        data = "status=1&" + data;
        $.ajax({
            cache: true,
            type: "POST",
            url: "/cms/article/save",
            data: data,
            async: false,
            error: function (request) {
                parent.layer.alert("Connection error");
            },
            success: function (data) {
                if (data.code == 0) {
                    parent.layer.msg("操作成功");
                    window.location.href = "/cms/article";
                } else {
                    parent.layer.alert(data.msg)
                }
            }
        });
    }
}).validate({});

$("#save-preview").on('click', function () {
    var data = $('#article-form').serialize();
    data = "status=4&" + data;
    $.ajax({
        cache: true,
        type: "POST",
        url: "/cms/article/save",
        data: data,
        async: false,
        error: function (request) {
            parent.layer.alert("Connection error");
        },
        success: function (data) {
            if (data.code == 0) {
                parent.layer.msg("操作成功");
                window.location.href = "/cms/article";
            } else {
                parent.layer.alert(data.msg)
            }
        }
    });
});
// 初始化Web Uploader
var uploader = WebUploader.create({

    // 选完文件后，是否自动上传。
    auto: true,

    // swf文件路径
    swf: '/js/Uploader.swf',

    // 文件接收服务端。
    server: '/common/sysFile/upload',

    // 选择文件的按钮。可选。
    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
    pick: '#filePicker',

    // 只允许选择图片文件。
    accept: {
        title: 'Images',
        extensions: 'jpg,jpeg,bmp,png',
        mimeTypes: 'image/*'
    }
});

// 当有文件添加进来的时候
uploader.on('fileQueued', function (file) {
    var $li = $(
        '<div id="' + file.id + '" class="file-item">' +
        '<img>' +
        '<div class="info">' + file.name + '</div>' +
        '</div>'
        ),
        $img = $li.find('img');

    var $list = $("#fileList");
    // $list为容器jQuery实例
    $list.html($li);

    // 创建缩略图
    // 如果为非图片文件，可以不用调用此方法。
    // thumbnailWidth x thumbnailHeight 为 100 x 100
    uploader.makeThumb(file, function (error, src) {
        if (error) {
            $img.replaceWith('<span>不能预览</span>');
            return;
        }

        $img.attr('src', src);
    }, 400, 400);
});

// 文件上传过程中创建进度条实时显示。
uploader.on('uploadProgress', function (file, percentage) {
    var $li = $('#' + file.id),
        $percent = $li.find('.progress span');

    // 避免重复创建
    if (!$percent.length) {
        $percent = $('<p class="progress"><span></span></p>')
            .appendTo($li)
            .find('span');
    }

    $percent.css('width', percentage * 100 + '%');
});

// 文件上传成功，给item添加成功class, 用样式标记上传成功。
uploader.on('uploadSuccess', function (file, response) {
    $('#' + file.id).addClass('upload-state-done');
    $('#thumbnail').val(response.data);
});

// 文件上传失败，显示上传出错。
uploader.on('uploadError', function (file) {
    var $li = $('#' + file.id),
        $error = $li.find('div.error');

    // 避免重复创建
    if (!$error.length) {
        $error = $('<div class="error"></div>').appendTo($li);
    }

    $error.text('上传失败');
});

// 完成上传完了，成功或者失败，先删除进度条。
uploader.on('uploadComplete', function (file) {
    $('#' + file.id).find('.progress').remove();
});

(function () {
    $(function () {
        var toolbar = ['title', 'bold', 'italic', 'underline', 'strikethrough', 'color',
            '|', 'ol', 'ul', 'blockquote', 'code', 'table',
            '|', 'link', 'image', 'hr',
            '|', 'indent', 'outdent', 'alignment'];
        var editor = new Simditor({
            textarea: $('#editor'),
            placeholder: '这里输入文字...',
            toolbar: toolbar,
            pasteImage: true,
            defaultImage: '/img/image.png',
            upload: {
                url: '/common/sysFile/upload',
                fileKey: 'file',
                connectionCount: 3,
                leaveConfirm: '正在上传文件'
            }
        });

    });

}).call(this);