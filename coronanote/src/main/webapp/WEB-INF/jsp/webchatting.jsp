<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimun-scale=1.0, maximum-scale=2.0, user-scalable=no">
<script src="//code.jquery.com/jquery.min.js"></script>
<link rel="stylesheet" href="/css/reset.css" />
<link rel="stylesheet" href="/css/webcatting.css" />
<link rel="stylesheet" href="/css/all.min.css" />
<title>webCatting</title>
</head>
<body>

<div class="wrap"> 
	<header class="headerwrap">
		<div class="header">
			<img src="img/titlelogo.png">
			<i class="fas fa-times"></i>
			
		</div>
	</header>
	
	<article>
		<div class="contentwrap">
			<ul class="content">
				<li>
					<div class="fl chattingtextFl">
						<div class="chattingImg"></div>
						<div>
							<ul>
								<li>브랜드명</li>
								<li>안녕하세요. infobank입니다.</li>
							</ul>
						</div>
						<div class="chattingTime">14:21</div>
					</div>	
				</li>
				<li>
					<div class="fr chattingtextFr">
						<div class="chattingImg"></div>
						<div>
							<ul>
								<li>브랜드명</li>
								<li>안녕하세요. infobank입니다.</li>
							</ul>
						</div>
						<div class="chattingTime">14:21</div>
					</div>	
				</li>
				
			</ul>
		</div>
	</article>
	 
	<footer class="footerwrap">
		<div class="footer">
			<textarea onkeydown="fn_webCattingTextArea(this)" onkeyup="fn_webCattingTextArea(this)"></textarea>
			<div onclick="fn_sendMsg()">
				<i class="fas fa-paper-plane"></i>
			</div>
		</div>
	</footer>
</div>
</body>

<script> 
	var textArea = 0; 
	var value = '';
	
	function fn_webCattingTextArea(e){
		
		e.style.height = "1px";
		e.style.height = (12+e.scrollHeight)+"px";
	}
	
	/* TextArea 높이 조절 함수 */
/* 	$('.footer textarea').on('keydown', function(key){
		value = $('.footer textarea').val();
		
		console.log(key.keyCode);
		
		if (key.keyCode == 13) {
				
				fn_sendMsg();
				return false 
			}
		
		$(this).height(1).height(
			$(this).prop('scrollHeight')+10	);
		textArea = $(this).height(); 
		fn_textArea();
		
// 		console.log(value);
	}); */
	
	/* TextArea 높이 조절시 버튼 및 footerwrap 위치 조정 함수 */
	function fn_textArea(){
		  
		if(textArea == 44){
			$('.footerwrap').css('bottom','13px');
			$('.footer div').css('height','50px');
		} else if(textArea == 54){
			$('.footerwrap').css('bottom','26px');
			$('.footer div').css('height','60px');
		} else if(textArea == 29){
			$('.footerwrap').css('bottom','0px');
			$('.footer div').css('height','35px');
		}
	
	} 
	
	/* msg 전송 함수 */
	function fn_sendMsg(){
// 		console.log('sendMsg');
		$('.footer textarea').val('');
		$('.content').append('<li><div class="fr chattingtextFr"><div class="chattingImg"></div><div><ul><li>브랜드명</li><li>'+value+'</li></ul></div><div class="chattingTime">14:21</div></div></li>');
		$('.footerwrap').css('bottom','0px');
		$('.footer div').css('height','35px');
		 
	}
	
</script>
</html>