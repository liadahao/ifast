//注意：parent 是 JS 自带的全局对象，可用于操作父页面
var index = parent.layer.getFrameIndex(window.name); //获取窗口索引

//让层自适应iframe
$('#add').on('click', function(){
    $('body').append('插入很多酱油。插入很多酱油。插入很多酱油。插入很多酱油。插入很多酱油。插入很多酱油。插入很多酱油。');
    parent.layer.iframeAuto(index);
});
//在父层弹出一个层
$('#new').on('click', function(){
    parent.layer.msg('Hi, man', {shade: 0.3})
});
//给父页面传值
$('#transmit').on('click', function(){

    parent.$('#parentIframe').text('我被改变了');
    parent.layer.tips('Look here', '#parentIframe', {time: 5000});
    parent.layer.close(index);
});
//关闭iframe
$('#closeIframe').click(function(){
    var val = $('#name').val();
    if(val === ''){
        parent.layer.msg('请填写标记');
        return;
    }
    parent.layer.msg('您将标记 [ ' +val + ' ] 成功传送给了父窗口');
    parent.layer.close(index);
});


