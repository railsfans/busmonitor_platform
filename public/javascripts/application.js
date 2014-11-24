// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
Ext.onReady(function() {
    var broswer="";
    var platform="";	    
    if(Ext.isIE){ 	
        if(Ext.isIE6){
            broswer = "Internet Explorer 6.x"
        }else if(Ext.isIE7){
            broswer = "Internet Explorer 7.x"
        }else if(Ext.isIE8){
            broswer = "Internet Explorer 8.x"
        }
    }else if(Ext.isSafari){
        if(Ext.isSafari2){
            broswer = "Safari 2.x"
        }else if(Ext.isSafari3){
           broswer = "Safari 3.x"
        }else if(Ext.isSafari4){
            broswer = "Safari 4.x"
        }
    }else if(Ext.isChrome){
        broswer = "Chrome"
    }else if(Ext.isGecko){
        broswer = "Firefox"
        if(Ext.isGecko2){
            broswer = "Firefox 2.x"
        }else if(Ext.isGecko3){
            broswer = "Firefox 3.x"
        }
    }else if(Ext.isOpera){
        broswer = "Opera"
    }else if(Ext.isWebKit){
        broswer = "WebKit"
    }else{
        broswer = "unknown"
    }    
    if(Ext.isWindows){
        platform = "Windows"
    }else if(Ext.isLinux){
        platform = "Linux"
    }else if(Ext.isMac){
        platform = "Mac OS"
    }else{
        broswer = "unknown"
    }	
    $("#platform").text(platform);	
    $("#broswer").text(broswer);

/*
    $(".left-menu a:not('.selected')").click(function(event){
	    event.preventDefault();
		 Ext.Ajax.request({
        url: $(this).attr("href"),
        method: "GET",
        success: function(response){
				eval(response.responseText);
			},
        failure: function(response){
            show_tip_message("数据加载失败!")
       			 }
		})
	    $(".left-menu a").removeClass("selected");
	    $(this).addClass("selected");
		
	});
	$(".left-menu a.selected").click(function(event){
	    event.preventDefault();
	});
*/

$(".left-menu a:not('.selected')").bind("click",function()
{
	$(".left-menu a").removeClass("selected");
	$(this).addClass("selected");
	if(window.location.href!=this.href)
        {
    	$.getScript(this.href);
    	history.pushState(null, document.title, this.href);
        }
	return false
});
$(window).bind("popstate", function() {
	$.getScript(location.href);
});

//$.getScript("http://"+document.location.href.split('/')[2]+'/home/getjs.js',function(){
	
//});


});
   
