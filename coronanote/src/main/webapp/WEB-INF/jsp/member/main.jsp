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
	<div class="wrap" style="background-image: url('/img/member/main_bg.png');">
		<div class="mainWrap">
			<div class="title">
				<p>
					평범한 순간도 특별한 날로 만드는<br>
					우리만의 추억 공유 SNS	
				</p>
				<div class="logo mt10">
					<img src="/img/member/main_logo.png" alt="로고" />
				</div>
			</div>
			<ul class="content mt40">
				<li onclick="fn_tofriend();">
					<div class="img">
						<img src="/img/member/main_icon_1.png" alt="친구 목록" />
					</div>
					<p>친구 목록</p>
				</li>
				<li onclick="fn_toimage();">
					<div class="img">
						<img src="/img/member/main_icon_2.png" alt="공유 앨범" />
					</div>
					<p>공유 앨범</p>
				</li>
				<!-- <li>
					<div class="img">
						<img src="/img/member/main_icon_3.png" alt="메시지" />
					</div>
					<p>메시지</p>
				</li>
				<li>
					<div class="img">
						<img src="/img/member/main_icon_4.png" alt="카드 쓰기" />
					</div>
					<p>카드 쓰기</p>
				</li> -->
			</ul>
		</div>

		<img class="banner" src="http://anniver.iozenweb.co.kr/theme/anniver/img/banner.png" alt="배너" />

	</div>
</body>
<script>
	var imgCnt = '${imgCnt}';
		
	function fn_tofriend(){
		location.href = '/friend.do';
	}
	
	function fn_toimage(){
		location.href = '/image.do';
	}
	
	imgRequest();
	function imgRequest() {
		var param;
		
		if(imgCnt != 0){
			swal({
			    title: '공유된 이미지가 있습니다. \n 받으시겠습니까?',
			    buttons: ["NO", "YES"]})
			.then((willDelete) => {
	        	if(willDelete){ 
	        		
	        		param= {
	        				'type' : 'Y'
	        		}
	             		
	            	$.ajax({
	                       url:"/ajax/member/update/updateImgRequest.do",
	                       data: param,
	                       type:'POST',
	                       success:function(data){
	                      		swal('사진을 받아왔습니다.');
	                        },
                        error:function(jqXHR, textStatus, errorThrown){
                            alert("에러!");
                        }
                    });
	        		
	        	}else{
	        		param= {
	        				'type' : 'N'
	        		}
	        		
	        		$.ajax({
	                       url:"/ajax/member/update/updateImgRequest.do",
	                       data: param,
	                       type:'POST',
	                       success:function(data){
	                      		swal('거절 되었습니다.');
	                        },
                     error:function(jqXHR, textStatus, errorThrown){
                         alert("에러!");
                     }
                 });
	        	}	
			});
		}
	}		
	
	fn_friendAddedSelect();
	function fn_friendAddedSelect(){
		
		var param = {
			
		}
		
		$.ajax({
            url:"/ajax/member/select/friendAddedSelect.do",
            data: param,
            type:'POST',
            success:function(data){
           		
				var cnt = data.cnt;
            	
            	if(cnt != 0){
            		
            		swal(cnt+'개의 친구 요청이 수락되었습니다.')
              		.then((willDelete) => {
              			if(willDelete){
              				
              				var param = {
              						
              				}
              				
              				$.ajax({
              		            url:"/ajax/member/update/friendAddedRequest.do",
              		            data: param,
              		            type:'POST',
              		            success:function(data){
              		            	console.log('친구추가됨 확인');	         		            		
              		             },
              				      error:function(jqXHR, textStatus, errorThrown){
              				          alert("에러!");
              				      }
              				  });
              				
              				location.reload();
              			}else{
              				
						var param = {
              						
              				}
              				
              				$.ajax({
              		            url:"/ajax/member/update/friendAddedRequest.do",
              		            data: param,
              		            type:'POST',
              		            success:function(data){
              		            	console.log('친구추가됨 확인');	         		            		
              		             },
              				      error:function(jqXHR, textStatus, errorThrown){
              				          alert("에러!");
              				      }
              				  });
              				
              				location.reload();
              				
              			}
              		});
            		
            	}else{
            		return false;
            	}
            	
            	
             },
		      error:function(jqXHR, textStatus, errorThrown){
		          alert("에러!");
		      }
		  });
	}
</script>
</html>