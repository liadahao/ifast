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
        var isShow = document.getElementById('isShow').checked;
        var isShowStr;
        if (isShow) {
            isShowStr = 1;
        } else {
            isShowStr = 2;
        }
        nav['isshow'] = isShowStr;
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

layui.use('upload', function () {
    var $ = layui.jquery
        , upload = layui.upload;

    //普通图片上传
    var uploadInst = upload.render({
        elem: '#background-button'
        , url: '/common/sysFile/upload'
        ,accept:'images'
        , before: function (obj) {
            //预读本地文件示例，不支持ie8
            obj.preview(function (index, file, result) {
                $('#background-img').attr('src', result); //图片链接（base64）
            });
        }
        , done: function (res) {
            //如果上传失败
            if (res.code != 0) {
                return layer.msg('上传失败');
            }
            layer.msg("上传成功");
            //上传成功
            $('#background').val(res.data);
        }
        , error: function () {
            //演示失败状态，并实现重传
            var demoText = $('#background-text');
            demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
            demoText.find('.demo-reload').on('click', function () {
                uploadInst.upload();
            });
        }
    });


});

$('#background-clear').click(function () {
    $('#background-img').removeAttr('src'); //图片链接（base64）
    $('#background').removeAttr('value');
});

$('#video-clear').click(function () {
    $('#video-img').removeAttr('src'); //图片链接（base64）
    $('#video-img').hide(); //图片链接（base64）
    $('#indexVideo').removeAttr('value');
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
            if (isShow == "on") {
                childShow.prop("checked", true);
            } else {
                childShow.prop("checked", false);
            }
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