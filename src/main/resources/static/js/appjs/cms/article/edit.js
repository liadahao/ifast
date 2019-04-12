$().ready(function () {
    validateRule();

});

$(function () {
    var id = $('#id').val();
    $.ajax({
        type: "GET",
        url: '/cms/article/edit/' + id,
        async: false,
        error: function (request) {
        },
        success: function (data) {
            handleData(data);
        }
    });
});

function handleData(data) {
    if (data.title) {
        $('#title').val(data.title);
    }
    if (data.summary) {
        $('#summary').val(data.summary);
    }
    if (data.author) {
        $('#author').val(data.author);
    }
    if (data.style) {
        $('#optionsRadios' + data.style).attr('checked', 'checked');
    }
    if (data.social) {
        for (var i = 0; i < data.social.length; i++) {
            var obj = data.social[i];
            $('#social' + i + 'type').val(obj.type);
            $('#social' + i + 'url').val(obj.url);
            $('#social' + i + 'order').val(obj.order)
        }
    }
    if (data.tag) {
        for (var i = 0; i < data.tag.length; i++) {
            var obj = data.tag[i];
            $('#tag' + i).val(obj);
        }
    }
    if (data.content) {
        $('#editor').val(data.content);
    }
    if (data.metaTitle) {
        $('#metaTitle').val(data.metaTitle);
    }
    if (data.metaKeywords) {
        $('#metaKeywords').val(data.metaKeywords);
    }
    if (data.metaDescription) {
        $('#metaDescription').val(data.metaDescription);
    }
}

$.validator.setDefaults({
    submitHandler: function () {
        update();
    }
});

function update() {
    // $.ajax({
    // 	cache : true,
    // 	type : "POST",
    // 	url : "/cms/article/update",
    // 	data : $('#signupForm').serialize(),// 你的formid
    // 	async : false,
    // 	error : function(request) {
    // 		parent.layer.alert("Connection error");
    // 	},
    // 	success : function(data) {
    // 		if (data.code == 0) {
    // 			parent.layer.msg("操作成功");
    // 			parent.reLoad();
    // 			var index = parent.layer.getFrameIndex(window.name); // 获取窗口索引
    // 			parent.layer.close(index);
    //
    // 		} else {
    // 			parent.layer.alert(data.msg)
    // 		}
    //
    // 	}
    // });

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
                required: icon + "请输入名字"
            }
        }
    })
}