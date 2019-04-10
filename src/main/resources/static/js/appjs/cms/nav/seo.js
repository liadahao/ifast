$().ready(function () {
    validateRule();
});

$.validator.setDefaults({
    submitHandler: function () {
        save();
    }
});

/**
 * 保存并进入下一步
 */
function save() {
    var seo = $('#signupForm').serializeJSON();
    var step2data = $.cookie("nav_2");
    var nav = $.parseJSON(step2data);
    $.extend(true, nav, seo);
    var new_data = JSON.stringify(nav);
    console.log(new_data);
    $.ajax({
        cache: true,
        type: "POST",
        url: "/cms/nav/save",
        data: new_data,
        dataType: "json",
        contentType: "application/json",
        async: false,
        error: function (request) {
            parent.layer.alert("Connection error");
        },
        success: function (data) {
            $.cookie("nav_1", null, {path: '/'});
            $.cookie("nav_2", null, {path: '/'});
            if (data.code == 0) {
                parent.layer.msg("操作成功");
                window.location.href = "/cms/nav";
            } else {
                parent.layer.alert(data.msg)
            }

        }
    });
}

function validateRule() {
    var icon = "<i class='fa fa-times-circle'></i> ";
    $("#signupForm").validate({
        rules: {
            name: {
                required: true
            }
        },
        messages: {
            name: {
                required: icon + "请输入姓名"
            }
        }
    })
}