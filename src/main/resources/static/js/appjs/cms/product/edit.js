function cancel() {
    window.location.href = "/cms/product/";
}

function preview() {
    var data = $('#signupForm').serialize();
    data = "status=4&" + data;
    $.ajax({
        cache: true,
        type: "POST",
        url: "/cms/product/save",
        data: data,
        async: false,
        error: function (request) {
            parent.layer.alert("Connection error");
        },
        success: function (data) {
            if (data.code == 0) {
                parent.layer.msg("操作成功");
                window.open("/shop/" + data.data);
                window.location.href = "/cms/product/";
            } else {
                parent.layer.alert(data.msg)
            }
        }
    });
}

function update() {
    var data = $('#signupForm').serialize();
    data = "status=1&" + data;
    $.ajax({
        cache: true,
        type: "POST",
        url: "/cms/product/update",
        data: data,// 你的formid
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
