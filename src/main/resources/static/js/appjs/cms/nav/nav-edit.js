var form = $("#signupForm").show();
form.steps({
    headerTag: "h3",
    bodyTag: "fieldset",
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
        window.location.href = "/cms/nav/"
    },
    onFinished: function (event, currentIndex) {
        var nav = $('#signupForm').serializeJSON({useIntKeysAsArrayIndex: true});
        var content = JSON.stringify(nav['content']);
        nav['content'] = content;
        var data = JSON.stringify(nav);
        var url;
        if (nav['id'] == null || nav['id'] === '') {
            url = '/cms/nav/save';
        } else {
            url = '/cms/nav/update';
        }
        $.ajax({
            cache: true,
            type: "POST",
            url: url,
            data: data,// 你的formid
            async: false,
            dataType: 'json',
            contentType: 'application/json',
            error: function (request) {
                parent.layer.alert("Connection error");
            },
            success: function (data) {
                if (data.code == 0) {
                    parent.layer.msg("操作成功");
                    window.location.href = "/cms/nav";
                } else {
                    parent.layer.alert(data.msg)
                }
            }
        });
    }
}).validate({});

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

    let $list = $("#fileList");
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

function addTechtourLink(id) {
    var tbody = $("#linktable-" + id);
    var len = tbody.children('tr').length;
    if (len >= 12) {
        parent.layer.msg("链接已到达12个");
    }
    //iframe层-父子操作
    layer.open({
        type: 2,
        area: ['700px', '450px'],
        fixed: false, //不固定
        maxmin: true,
        content: '/cms/nav/add/7'
    });
}

function editTechtourLink(selector) {
    var trSelector = $(selector).parent().parent('tr');
    var trId = trSelector.attr('id');
    var nameSelector = trSelector.find('td:first-child');
    var name = nameSelector.find('input').val();
    var isShow = nameSelector.next().find('input').val();
    var logo = nameSelector.next().next().find('input').val();
    var order = nameSelector.next().next().next().find('input').val();
    var url = nameSelector.next().next().next().next().find('input').val();
    //iframe层-父子操作
    layer.open({
        type: 2,
        area: ['700px', '450px'],
        fixed: false, //不固定
        maxmin: true,
        content: '/cms/nav/add/7',
        success: function (layero, index) {
            var childId = layer.getChildFrame('#id', index);
            childId.val(trId);
            var childName = layer.getChildFrame('#name', index);
            childName.val(name);
            var childShow = layer.getChildFrame('#isShow', index);
            childShow.val(isShow);
            var childLogo = layer.getChildFrame('#logo', index);
            childLogo.val(logo);
            var childOrder = layer.getChildFrame('#order', index);
            childOrder.val(order);
            var childUrl = layer.getChildFrame('#url', index);
            childUrl.val(url);
        }
    });
}

function removeLink(selector) {
    $(selector).parent().parent('tr').remove();
}