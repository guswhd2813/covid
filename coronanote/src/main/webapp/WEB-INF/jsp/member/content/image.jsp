<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
  	<meta name="google" content="notranslate">
  	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimun-scale=1.0, maximum-scale=2.0, user-scalable=yes">
	<title>Anniver</title>
	<%@ include file="/WEB-INF/include/include-head.jspf" %>
	<script src="/js/download.js"></script>
</head>
<body>
	<div class="wrap">
		<div class="bg"></div>
		<div class="imageWrap contentWrap">
			<div class="title">공유 이미지</div>
			<ul>
				<c:forEach var="imageList" items="${img_list}" varStatus="status">
				<li class="imgs" style="background-image: url('/sharedImage.do?img_seq=${imageList.img_seq}" onclick="fn_imageView(this, ${imageList.img_seq}, '${imageList.name}')"></li>
				</c:forEach>
			</ul>		
		</div>
		
		<!-- 사진 클릭시 나오는 뷰어 -->
		<div class="imageViewWrap">
			<div class="userName"></div>
			<div class="imgeViewBtnWrap">
				<a id="imgDownload" href="#" download="anniver"><i class="fas fa-file-download"></i></a>
				<i class="far fa-trash-alt" id="imgDel" onclick="fn_imgDelete();"></i>
				<i class="fas fa-times" onclick="fn_imageViewClose();"></i>
			</div>
			<div class="movImg">
				<i class="fas fa-chevron-left m_left" onclick="fn_movImage('L');"></i>
				<i class="fas fa-chevron-right m_right" onclick="fn_movImage('R');"></i>
			</div>
			<img id="imgViewer" src="" alt="loading">
			<div class="imgBg" onclick="fn_imageViewClose();"></div>
		</div>
		
		<%@ include file="/WEB-INF/include/include-member-nav.jspf" %>
		
		
	</div>
</body>
<script>
	var len = '${fn:length(img_list)}';
	var idx;
	function fn_imageView(e, r, n){
		idx = $(e).index();
		console.log(len);
		console.log(idx);
		$('.movImg i').show();
		if(idx == 0){
			$('.m_left').hide();
		}else if((len-1) == idx){
			$('.m_right').hide();
		};
		var body = $('.wrap');
		$('.imageViewWrap').show();
		$('.imageViewWrap .userName').html(n);
		$('.imageViewWrap img').attr('src','/sharedImage.do?img_seq='+r);
		$('#imgDownload').attr('href','/sharedImage.do?img_seq='+r);
		$('#imgDel').attr('onclick','fn_imgDelete(this,'+r+')');
	}     
	
	function fn_movImage(t){
		if(t == 'L' && idx != 0){
			idx = idx - 1;
		}else if(t == 'R' && idx != (len-1)){
			idx = idx + 1;
		};
		
		$('.movImg i').show();
		if(idx == 0){
			$('.m_left').hide();
		}else if((len-1) == idx){
			$('.m_right').hide();
		};
		
		var list = $('.imgs').eq(idx).attr('onclick').split('(')[1].split(')')[0].split(',');
		var n = list[2].replaceAll('\'', '');
		var r = list[1].replaceAll('\'', '');
		$('.imageViewWrap .userName').html(n);
		$('.imageViewWrap img').attr('src','/sharedImage.do?img_seq='+r);
		$('#imgDownload').attr('href','/sharedImage.do?img_seq='+r);
		$('#imgDel').attr('onclick','fn_imgDelete(this,'+r+')');
	}
	
	function fn_imageViewClose(){   
		$('.imageViewWrap').hide();
	}
	
	function fn_imgDelete(e, i){
		console.log(i);
		
		swal({
		    title: '사진을 삭제 하시겠습니까?',
		    buttons: ["NO", "YES"]})
		.then((willDelete) => {
        	if(willDelete){
        		var param = {
        			'img_seq' : i
        		}
        		
        		$.ajax({
                    url:"/ajax/member/update/imgDelete.do",
                    data: param,
                    type:'POST',
                    success:function(data){
                   		swal('삭제가 완료 되었습니다.')
            			.then((willDelete) => {
            	        	if(willDelete){ 
            	        		location.reload();
            	        	}else{
            	        		location.reload();
            	        	}	
            			});
                    		
                    },
                    error:function(jqXHR, textStatus, errorThrown){
                        alert("에러!");
                    }
                });
        		
        	}else{
        		return false;
        	}
        });
		
	}
	
	var imgCnt = '${imgCnt}';
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
	                      		swal('사진을 받아왔습니다.')
	                      		.then((willDelete) => {
	                      			if(willDelete){
	                      				location.reload();
	                      			}else{
	                      				location.reload();
	                      			}
	                      		});
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
















