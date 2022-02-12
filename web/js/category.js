$(document).ready(function(){
    $(".maintip").each(function(index){   //遍历A部分，注意这里绑定事件用了index参数
        $(this).mouseover(function(){   //鼠标经过A时触发事件
            var obj=$(this).offset();   //获取被鼠标经过的A的偏移位置，offset()是个好东西，不懂的朋友得去了解下
            var xobj=obj.left+200+"px"; //后面要让B水平偏移的距离，这里的“200”是可自定义的，当然你可以改为$(this).width()来获得跟A一样的宽度
            var yobj=obj.top+"px";     //后面要让B垂直偏移的距离
            $(this).css({"width":"200px","z-index":"9999","border-right":"none","background":"#fff"});  //A改变样式，变为选中状态的效果
            $(".tips:eq("+index+")").css({"left":xobj,"top":yobj}).show();   //对应的（这里利用了索引）B改变样式并显示出来
            })
        .mouseout(function(){     //鼠标离开A时触发的事件
            $(".tips").hide();     //B隐藏
            $(this).css({"width":"200px","z-index":"1","border":"1px solid #E5D1A1","background":"#FFFDD2"})   //A变回原始样式
        })
    })

         $(".tips").each(function(){  //遍历B
            $(this).mouseover(function(){  //鼠标经过B时触发事件
            $(this).prev(".maintip").css({"width":"200px","z-index":"9999","border-right":"none","background":"#fff"})  //对应的A变为选中状态效果
            $(this).show();  //A不要隐藏了，解决因为上面写的鼠标离开A导致A隐藏
        })
        .mouseout(function(){  //鼠标离开B触发事件，其实就是让B隐藏，同时A变为原始状态
            $(this).hide();
            $(this).prev(".maintip").css({"width":"200px","z-index":"1","border":"1px solid #E5D1A1","background":"#FFFDD2"});
        })
    })
});