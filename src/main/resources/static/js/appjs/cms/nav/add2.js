$().ready(function () {
    validateRule();
});

$.validator.setDefaults({
    submitHandler: function () {
        save();
    }
});

function getJson() {
    var obj = $('#signupForm');
    console.log(obj.serializeJSON());
    console.log(JSON.stringify(obj.serializeJSON()));
    return JSON.stringify(obj.serializeJSON());
}

/**
 * 保存并进入下一步
 */
function save() {
    var step1data = $.cookie("nav_1");
    console.log(step1data);
    var nav = $.parseJSON(step1data);
    console.log(nav);
    nav["content"] = getJson();
    var new_data = JSON.stringify(nav);
    $.cookie("nav_2", null, {path: '/'});
    $.cookie("nav_2", new_data, {path: '/'});
    console.log(new_data);
    window.location.href = '/cms/nav/add/seo';
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