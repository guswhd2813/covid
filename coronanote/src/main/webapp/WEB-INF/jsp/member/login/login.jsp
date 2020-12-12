<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
  	<meta name="google" content="notranslate">
  	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<title>Anniver</title>
	<%@ include file="/WEB-INF/include/include-head.jspf" %>
</head>
<body>
	<div class="wrap">
		<div class="loginWrap">
			<div class="logo">
				<img src="/img/member/logo.png" alt="로고" />
				<p>우리만의 추억공유 SNS</p>
			</div>
			<ul class="login mt120">
				<li class="id"><input type="text" name="id" placeholder="아이디를 입력하세요." maxlength="15" tabindex="1"></li>
				<li class="pw mt10"><input type="password" name="pw" placeholder="비밀번호를 입력하세요." maxlength="20" tabindex="2"/></li>
			</ul>
			<button class="mt40" onclick="fn_loginChk();" tabindex="3">로그인</button>
			<button class="mt10" onclick="fn_toJoin();">회원가입</button>
		</div>
	</div>
</body>
<script>

	function fn_loginChk(){
		var id = $('input[name=id]').val(),
			pw = $('input[name=pw]').val();
		var param = {
			'id' : id,
			'pw' : pw
		};
		
		$.ajax({
            url:"/ajax/member/select/selectIdChk.do",
            data: param,
            type:'POST',
            success:function(data){
            	var value = data.result;
            	console.log(data);
            	if(value == 'passed'){
            		location.href = '/main.do';
            	}else{
            		swal('아이디 또는 비밀번호를 확인해 주세요.');
            	};
            },
            error:function(jqXHR, textStatus, errorThrown){
                alert("에러!");
            }
        });
	};
	
	function fn_toJoin(){
		location.href = '/join.do';
	};
	
</script>
</html>