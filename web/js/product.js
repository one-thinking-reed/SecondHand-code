$(function(){
    $(".maintip").each(function(index){
        $(this).mouseover(function(){
            var obj=$(this).offset();
            var xobj=obj.left+422+"px";
            console.log(obj.top);
            var yobj=obj.top-496.125+"px";
            $(this).css({"width":"400px","z-index":"9999","border-right":"none","background":"#7BA7AB"});
            $(".tips:eq("+index+")").css({"left":xobj,"top":yobj}).show();

        })
            .mouseout(function(){
                $(".tips").hide();
                $(this).css({"width":"400px","z-index":"2","border":"2px solid #7BA7AB","background":"#A3D0C3","padding":"10px"})
            })
    })

    $(".tips").each(function(){
        $(this).mouseover(function(){
            $(this).prev(".maintip").css({"width":"400px","z-index":"9999","border-right":"none","background":"#7BA7AB","padding":"10px"})
            $(this).show();
        })
            .mouseout(function(){
                $(this).hide();
                $(this).prev(".maintip").css({"width":"400px","z-index":"2","border":"2px solid #7BA7AB","background":"#A3D0C3","padding":"10px"});
            })
    })
});