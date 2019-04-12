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
    var obj = $('#signupForm').serializeJSON();
    var data = JSON.stringify(obj);
    console.log(data);
    $.cookie("nav_1", null, {path: '/'});
    $.cookie("nav_1", data, {path: '/'});
    window.location.href = '/cms/nav/edit/' + obj.type;
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