<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no">
        <title>test</title>
        <link rel="stylesheet" href="/css/reset.css" />
        <link type="text/css" href="/css/tui/tui-color-picker.css" rel="stylesheet">
        <link type="text/css" href="/css/service-mobile.css" rel="stylesheet">
        <link rel="stylesheet" href="/css/all.min.css" />
    </head>
    <body>
        <div class="header">
           
            <div class="menu">
            	<span class="title">이미지 수정</span>
           		<span class="button">
                    <img src="img/openImage.png" style="margin-top: 5px;" />
                    <form id="fileForm" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
                    	<input type="file" accept="image/*" name="input-image-file" id="input-image-file">
                    </form>
                </span>
                <button class="button disabled" id="btn-undo"><i class="fas fa-undo"></i></button>
                <button class="button disabled" id="btn-redo"><i class="fas fa-redo"></i></button>
                <button class="button" id="btn-remove-active-object" onclick="fn_remove();"><i class="far fa-trash-alt"></i></button>
                <button class="button" id="sendImage" onclick="fn_submit();">보내기</button>
            </div>
        </div>
        <!-- Image editor area -->
        <div class="tui-image-editor"></div>
        <!-- Image editor controls - bottom area -->
        <div class="tui-image-editor-controls">
            <ul class="scrollable">
                <li class="menu-item">
                    <button class="menu-button" id="btn-crop"><i class="fas fa-crop-alt"></i></button>
                    <div class="submenu">
                        <button class="btn-prev"><i class="fas fa-chevron-left"></i></button>
                        <ul class="scrollable">
                            <li class="menu-item"><button class="submenu-button" id="btn-apply-crop">적용</button></li>
                        </ul>
                    </div>
                </li>
                <li class="menu-item">
                    <button class="menu-button"><i class="fas fa-sync-alt"></i></button>
                    <div class="submenu">
                        <button class="btn-prev"><i class="fas fa-chevron-left"></i></button>
                        <ul class="scrollable">
                            <li class="menu-item"><button class="submenu-button" id="btn-rotate-clockwise">Rotate +90</button></li>
                            <li class="menu-item"><button class="submenu-button" id="btn-rotate-counter-clockwise">Rotate -90</button></li>
                        </ul>
                    </div>
                </li>
                <li class="menu-item">
                    <button class="menu-button" id="btn-add-text">T</button>
                    <div class="submenu txtGroup">
                        <button class="btn-prev"><i class="fas fa-chevron-left"></i></button>
                        <ul class="scrollable">
                            <li class="menu-item">
                                <button class="submenu-button" id="btn-change-size">Size</button>
                                <div class="hiddenmenu">
                                    <input id="input-text-size-range" type="range" min="10" max="240" value="120">
                                </div>
                            </li>
                            <li class="menu-item">
                                <button class="submenu-button" id="btn-change-style">Style</button>
                                <div class="hiddenmenu">
                                    <button class="hiddenmenu-button btn-change-text-style" data-style-type="bold"><b>Bold</b></button>
                                    <button class="hiddenmenu-button btn-change-text-style" data-style-type="italic"><i>Italic</i></button>
                                    <button class="hiddenmenu-button btn-change-text-style" data-style-type="underline"><u>Underline</u></button>
                                </div>
                            </li>
                            <li class="menu-item">
                                <button class="submenu-button" id="btn-change-text-color">Color</button>
                                <div class="hiddenmenu">
                                    <div id="tui-text-color-picker"></div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </li>
            </ul>
        </div>
        <script type="text/javascript" src="/js/tui/fabric.js"></script>
        <script type="text/javascript" src="/js/tui/tui-code-snippet.min.js"></script>
        <script type="text/javascript" src="/js/tui/tui-color-picker.min.js"></script>
        <script type="text/javascript" src="/js/jquery-3.3.1.min.js"></script>
        <script type="text/javascript" src="/js/tui/FileSaver.min.js"></script>
        <script type="text/javascript" src="/js/tui-image-editor.js"></script>
        <script src="/js/service-mobile.js"></script>
        <script>
        
        function fn_remove(){
        	
        }
        
        function fn_submit(){
       		var param = new FormData($("form")[0]);
       		param.append("name", $('#input-image-file').val());
       		param.append('content', imageEditor.toDataURL());
	     	$.ajax({
		        url:"/ajax/member/insert/insertImageUpload2.do",
		        data: param,
		        type:'POST',
		        processData : false,
		     	contentType : false,
		        success:function(data){
			        var value = data.result;
			        console.log(data);
		        
		        },
		        error:function(jqXHR, textStatus, errorThrown){
		        	alert("에러!");
		        }
	        });
    	};
    	
    	$('.btn-prev, #btn-apply-crop').click(function(){
    		$('.submenu').hide();
    	});
        $('.tui-image-editor').click(function(){
        	console.log($('.upper-canvas').css('cursor'));
        });
        </script>
    </body>
</html>
