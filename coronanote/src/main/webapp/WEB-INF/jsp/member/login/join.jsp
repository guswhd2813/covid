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
		<div class="loginWrap joinWrap">
			<div class="logo">
				<img src="/img/member/logo.png" alt="로고" />
				<p class="mt20">회원가입</p>
			</div>
			<ul class="login mt120">
				<li><i class="far fa-user"></i><input type="text" name="id" placeholder="아이디를 입력하세요." maxlength="15" onkeyup="rmBlank(this);"/></li>
				<li><i class="fas fa-signature"></i><input type="text" name="name" placeholder="이름을 입력해주세요." onkeyup="rmBlank(this);"/></li>
				<li><i class="far fa-envelope"></i><input type="text" name="email" placeholder="이메일을 입력해주세요." onkeyup="rmBlank(this);"/></li>
				<li><i class="fas fa-lock"></i><input type="password" name="pw" placeholder="비밀번호를 입력해주세요." maxlength="20"/></li>
				<li><i class="fas fa-lock"></i><input type="password" name="pw2" placeholder="비밀번호를 다시 입력해주세요." onkeyup="rmBlank(this);" maxlength="20"/></li>
			</ul>
			<button class="mt40" onclick="fn_save();">가입</button>
		</div>
	</div>
</body>
<script>	
	function fn_save(){
		var id = $('input[name=id]').val(),
			name = $('input[name="name"]').val(),
			email = $('input[name=email]').val(),
			pw = $('input[name=pw]').val(),
			pw2 = $('input[name=pw2]').val()
		
		if(id.length == 0 || isKor(id) || isSpecial(id)){
			swal('아이디 : 영문 및 숫자만 입력해주세요.');
			return false;
		}
		
		if(name.length == 0 || isSpecial(name) || isNum(name)){
			swal('이름 : 한글 및 영문만 입력해주세요.');
			return false;
		}
		
		if(!isEmail(email)){
			swal('이메일 : 형식에 맞게 입력해주세요.');
			return false;
		}
		
		if(pw.length < 8 ){
			swal('비밀번호 : 8자리 이상 입력해주세요.');
			return false;
		}
		
		if(pw != pw2){
			swal('비밀번호를 확인해주세요.');
			return false;
		}
			
		var param = {
			'id' : id,
			'name' : name,
			'email' : email,
			'pw' : pw
		};
		
		$.ajax({
            url:"/ajax/member/insert/insertMemberJoin.do",
            data: param,
            type:'POST',
            success:function(data){
            
            	var value = data.result;
            	console.log(data);
            	if(value == 'passed'){
            		swal('가입이 완료되었습니다.')
					.then((willDelete) => {
			        	if(willDelete){
			        		location.href = '/login.do';
			        	}else{
			        		location.href = '/login.do';
			        	}
			        });
            	}else if(value == 'duplication'){
            		swal('중복된 아이디입니다.');
            	}
            },
            error:function(jqXHR, textStatus, errorThrown){
                alert("에러!");
            }
        });
	};
</script>
</html>