$('#cancel').click(function () {
    window.location.href = "/cms/product/";
});

function update() {
    $.ajax({
        cache: true,
        type: "POST",
        url: "/cms/product/update",
        data: $('#signupForm').serialize(),// 你的formid
        async: false,
        error: function (request) {
            parent.layer.alert("Connection error");
        },
        success: function (data) {
            if (data.code == 0) {
                parent.layer.msg("操作成功");
                window.location.href = "/cms/product";
            } else {
                parent.layer.alert(data.msg)
            }
        }
    });

}
