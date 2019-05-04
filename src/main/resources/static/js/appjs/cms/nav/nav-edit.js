var form = $("#signupForm").show();
// 初始化步骤表单
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
            isShowStr = 0;
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
        , accept: 'images'
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

    upload.render({
        elem: '.about-upload-btn'
        , url: '/common/sysFile/upload'
        , before: function (obj) {
            var id = this.item[0].id;
            //预读本地文件示例，不支持ie8
            obj.preview(function (index, file, result) {
                var type = id.split('-')[0];
                var count = id.split('-')[2];
                $('#' + type + '-' + count).attr('src', result); //图片链接（base64）
            });
        }
        , done: function (res) {
            //如果上传失败
            if (res.code > 0) {
                return layer.msg('上传失败');
            } else {
                var id = this.item[0].id;
                var type = id.split('-')[0];
                var count = id.split('-')[2];
                var demoText = $('#' + type + '-text-' + count);
                demoText.html('<span style="color: #FF5722;">上传成功</span>');
                $('#' + type + '-value-' + count).val(res.data); //图片链接（base64）
            }
            //上传成功
        }
        , error: function () {
            //演示失败状态，并实现重传
            var demoText = $('#demoText');
            demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
            demoText.find('.demo-reload').on('click', function () {
                uploadInst.upload();
            });
        }
    });
});

function addAboutModel() {
    var page = $('#tab1-model-list');
    var len = page.children().length;
    if (len >= 6) {
        alert('模块已到达6个');
        return;
    }
    var html = '<div class="layui-card">' +
        '<div class="layui-card-header">\n' +
        '        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">\n' +
        '            <legend>模块' + (len + 1) + '</legend>\n' +
        '        </fieldset>\n' +
        '    </div>\n' +
        '    <div class="layui-card-body">\n' +
        '        <div class="form-group">\n' +
        '            <label class="col-sm-1 control-label">人物姓名：</label>\n' +
        '            <div class="col-sm-4">\n' +
        '                <input id="model-' + len + '-name" name="content[tab1][model][' + len + '][name]"\n' +
        '                       class="form-control"\n' +
        '                       type="text"/>\n' +
        '            </div>\n' +
        '            <label class="col-sm-1 control-label">人物简介 ：</label>\n' +
        '            <div class="col-sm-4">\n' +
        '        <textarea id="model-' + len + '-description" name="content[tab1][model][' + len + '][description]"\n' +
        '                  class="form-control"\n' +
        '                  rows="3"></textarea>\n' +
        '            </div>\n' +
        '        </div>\n' +
        '        <div class="form-group">\n' +
        '            <label class="col-sm-1 control-label">人物排序 ：</label>\n' +
        '            <div class="col-sm-4">\n' +
        '                <input id="model-' + len + '-order" name="content[tab1][model][' + len + '][order]"\n' +
        '                       class="form-control"\n' +
        '                       type="number"/>\n' +
        '            </div>\n' +
        '            <label class="col-sm-1 control-label">段落 ：</label>\n' +
        '            <div class="col-sm-6">\n' +
        '        <textarea id="model-' + len + '-content" name="content[tab1][model][' + len + '][content]"\n' +
        '                  class="form-control"\n' +
        '                  rows="5"></textarea>\n' +
        '            </div>\n' +
        '        </div>\n' +
        '<div class="form-group">\n' +
        '    <label class="col-sm-1 control-label">人物肖像：</label>\n' +
        '    <div class="layui-upload col-sm-4">\n' +
        '        <button type="button" class="layui-btn about-upload-btn"\n' +
        '                id="pic-button-' + len + '">上传图片\n' +
        '        </button>\n' +
        '        <button type="button" class="layui-btn about-upload-clear"\n' +
        '                id="pic-clear-' + len + '">清除\n' +
        '        </button>\n' +
        '        <div class="layui-upload-list">\n' +
        '            <img \n' +
        '                 class="layui-upload-img" id="pic-' + len + '">\n' +
        '            <p id="pic-text-' + len + '"></p>\n' +
        '        </div>\n' +
        '    </div>\n' +
        '    <input id="pic-value-' + len + '"\n' +
        '           name="content[tab1][model][' + len + '][pic]"\n' +
        '           class="form-control" type="hidden"/>\n' +
        '    <label class="col-sm-1 control-label">图片：</label>\n' +
        '    <div class="layui-upload col-sm-4">\n' +
        '        <button type="button" class="layui-btn about-upload-btn"\n' +
        '                id="image-button-' + len + '">上传图片\n' +
        '        </button>\n' +
        '        <button type="button" class="layui-btn about-upload-clear"\n' +
        '                id="image-clear-' + len + '">清除\n' +
        '        </button>\n' +
        '        <div class="layui-upload-list">\n' +
        '            <img' +
        '                 class="layui-upload-img"id="image-' + len + '">\n' +
        '            <p id="image-text-' + len + '"></p>\n' +
        '        </div>\n' +
        '    </div>\n' +
        '    <input id="image-value-' + len + '"\n' +
        '           name="content[tab1][model][' + len + '][image]"\n' +
        '           class="form-control" type="hidden"/>\n' +
        '</div>' +
        '        <div class="form-group">\n' +
        '            <div class="col-sm-8 link-table">\n' +
        '                <div class="ibox float-e-margins">\n' +
        '                    <div class="ibox-title">\n' +
        '                        <h5>社交媒体链接添加(每个媒体只能添加一个，重复会被覆盖)</h5>\n' +
        '                    </div>\n' +
        '                    <span id="addLink" class="btn btn-primary"\n' +
        '                          onclick="addLink(' + len + ')">添加</span>\n' +
        '                    <div class="ibox-content">\n' +
        '                        <table class="table">\n' +
        '                            <thead>\n' +
        '                            <tr>\n' +
        '                                <th>社交媒体名称</th>\n' +
        '                                <th>url链接</th>\n' +
        '                                <th>排序</th>\n' +
        '                            </tr>\n' +
        '                            </thead>\n' +
        '                            <tbody id="linktable-' + len + '">\n' +
        '                            </tbody>\n' +
        '                        </table>\n' +
        '                    </div>\n' +
        '                </div>\n' +
        '            </div>\n' +
        '        </div>\n' +
        '    </div>\n' +
        '</div>\n';
    page.append(html);
    layui.use('upload', function () {
        var $ = layui.jquery
            , upload = layui.upload;
        //普通图片上传
        var uploadInst = upload.render({
            elem: '.about-upload-btn'
            , url: '/common/sysFile/upload'
            , before: function (obj) {
                var id = this.item[0].id;
                //预读本地文件示例，不支持ie8
                obj.preview(function (index, file, result) {
                    var type = id.split('-')[0];
                    var count = id.split('-')[2];
                    $('#' + type + '-' + count).attr('src', result); //图片链接（base64）
                });
            }
            , done: function (res) {
                //如果上传失败
                if (res.code > 0) {
                    return layer.msg('上传失败');
                } else {
                    var id = this.item[0].id;
                    var type = id.split('-')[0];
                    var count = id.split('-')[2];
                    var demoText = $('#' + type + '-text-' + count);
                    demoText.html('<span style="color: #FF5722;">上传成功</span>');
                    $('#' + type + '-value-' + count).val(res.data); //图片链接（base64）
                }
                //上传成功
            }
            , error: function () {
                //演示失败状态，并实现重传
                var demoText = $('#demoText');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function () {
                    uploadInst.upload();
                });
            }
        });
    });
};


$('#background-clear').click(function () {
    $('#background-img').removeAttr('src'); //图片链接（base64）
    $('#background').removeAttr('value');
});

$('#video-clear').click(function () {
    $('#video-img').removeAttr('src'); //图片链接（base64）
    $('#video-img').hide(); //图片链接（base64）
    $('#indexVideo').removeAttr('value');
});

$(".about-upload-clear").click(function () {
    var id = $(this).attr("id");
    var type = id.split('-')[0];
    var count = id.split('-')[2];
    $('#' + type + '-' + count).removeAttr('src');
    $('#' + type + '-value-' + count).removeAttr('value');
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
        content: '/cms/nav/add/12'
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
        content: '/cms/nav/add/12',
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

$().ready(function () {
    $("#album").click(function () {
        layer.open({
            type: 2,
            title: '相册',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['950px', '520px'],
            content: '/cms/nav/album', // iframe的url
            success: function (layero, index) {
                var parentId = layer.getChildFrame('#parentImage', index);
                parentId.val("background");
            }
        });
    });
});