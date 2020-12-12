<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.wapforum.org/DTD/xhtml-mobile12.dtd">
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>chatbot</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/webcommon.css">
<link rel="stylesheet" href="css/weblayout.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<script type="text/javascript" src="${RESOURCE_JS}/jquery/1.12.4/jquery-1.12.4.min.js"></script>
</head>

<body>
<div class="wrap">
	<div class="gnb cb">상담톡<a href="#"><span class="material-icons close">close</span></a></div>
  <div class="con_bx cb">
		<div id="container_title"><hr><h3>2020년 3월 13일 14:21</h3></div>
		<div class="caht01 cb mb30">
			<img class="lgo" src="images/logo.png">
			<div class="caht_g">
				<h2 class="name">웰컴저축은행</h2>
				<div class="cmt_g mb5">					
					<img class="tlk_g" src="images/tlk_tl.png">
					<h2 class="txt01">안녕하세요. 웰컴저축은행입니다. <br />어쩐 점이 궁금하세요?</h2>
					<div class="time">14:21</div>
				</div>
				<div class="cb">
					<a class="btn_01 mb5" href="#">상담원 연결</a><br />
					<a class="btn_01" href="#">자주 묻는 질문</a>
				</div>
				
			</div>
		</div>
	  
	  	<div class="caht01 cb mb30">
			<div class="cmt_g cmt_w">					
				<!-- <img class="tlk_w" src="images/tlk_tl_w.png"> -->
				<h2 class="txt01">상담원 연결</h2>
				<div class="time time02">14:22</div>
			</div>
		</div>
	  
	  	<div class="caht01 cb mb30">
			<img class="lgo" src="images/logo.png">
			<div class="caht_g">
				<h2 class="name">웰컴저축은행</h2>
				<div class="cmt_g mb5">					
					<img class="tlk_g" src="images/tlk_tl.png">
					<h2 class="txt01">상담원 연결해드리겠습니다. <br />잠시만 기다려주세요.</h2>
					<div class="time">14:23</div>
				</div>				
			</div>   
		</div>  
	  
	</div>
	
	<div class="send_bx">
		<input type="text" class="inp01" name="send" placeholder="질문 또는 선택지를 입력해주세요." />
		<a href="#"><img class="send_btn" src="images/icn_send.png"></a>
	</div>
</div>
</body>
<script type="text/javascript">

function fn_webCattingTextArea(e){
	
}
/* msg 전송 함수 */
function fn_sendMsg(){
	
	$('.footer textarea').val('');
	$('.footer textarea').css('height','20');
	$('.footer div').css('height','20');
	$('.content').append('<li><div class="fr chattingtextFr"><div class="chattingImg"></div><div><ul><li>'+value+'</li></ul></div><div class="chattingTime">14:21</div></div></li>');
	$('.footerwrap').css('bottom','0px');
	$('.footer div').css('height','35px');
	 
}

</script>
</html>
