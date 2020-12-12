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
  	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<title>Anniver</title>   
	<%@ include file="/WEB-INF/include/include-head.jspf" %>
	<link type="text/css" href="/css/tui/tui-color-picker.css" rel="stylesheet">
    <link type="text/css" href="/css/service-mobile.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/all.min.css" />
</head>
<body>
	<div class="wrap">
		<form  method="post" enctype="multipart/form-data"  id="frmUpload">
		<div class="bg"></div>
		<div class="friendWrap contentWrap">
			<div class="title">친구 목록</div>
			<c:if test="${fn:length(friend_send_request) != 0 }">
			<div class="sendRequest content">
				<h4>보낸요청</h4>
				<ul>
					<c:forEach var="friendSendRequest" items="${friend_send_request}" varStatus="status">
					<li onclick="fn_friendCancelRequest(this, ${friendSendRequest.request_seq}, ${friendSendRequest.member_seq},'${friendSendRequest.name}');"><i class="fas fa-exchange-alt"></i>${friendSendRequest.name}</li>
					</c:forEach>
				</ul>
			</div>
			</c:if> 
			<c:if test="${fn:length(friend_request) != 0 }">
			<div class="request content">
				<h4>친구요청</h4>
				<ul>
					<c:forEach var="friendRequest" items="${friend_request}" varStatus="status">
					<li onclick="fn_friendRequest(this, ${friendRequest.request_seq}, ${friendRequest.member_seq});"><i class="fas fa-exchange-alt"></i>${friendRequest.name}</li>
					</c:forEach>
				</ul>
			</div>
			</c:if>
			<div class="group content">
				<h4>그룹<i class="fas fa-cog setting" onclick="fn_groupUpdate()" type="true"></i><i class="fas fa-plus add" onclick="fn_groupAdd();"></i></h4>
				<ul>
					<c:if test="${fn:length(group_info) == 0 }">
						<li style="text-align: center;">등록된 그룹이 없습니다.</li>
					</c:if>
					<c:forEach var="groupInfo" items="${group_info}" varStatus="status">
					<li onclick="fn_groupInfo(this, ${groupInfo.group_seq},'${groupInfo.group_name}');"><i class="fas fa-users"></i>${groupInfo.group_name}</li>
					</c:forEach>
					
				</ul>
			</div>
			<div class="friend content">
				<h4>친구 <i class="fas fa-search fridel"></i><i class="fas fa-cog setting" onclick="fn_friendDelChange()"></i><i class="fas fa-plus add" onclick="fn_frindAdd()"></i></h4>
				<ul>
					
					<c:if test="${fn:length(friend_info) == 0 }">
						<li style="text-align: center; border-bottom:1px solid #ccc; ">등록된 친구가 없습니다.</li>
					</c:if> 
					
					<c:forEach var="friendInfo" items="${friend_info}" varStatus="status">
					<li onclick="fn_chkFriend(this, ${friendInfo.friend_seq});"><input type="checkbox" name="friend" value="${friendInfo.friend_seq}" /><i class="far fa-user"></i>${friendInfo.name}</li>
					</c:forEach>
				</ul> 
			</div>
		</div>
		
		<div class="groupMemberWrap">
			<h4>
				<span>거래처</span>
				<div class="groupBtnWrap">
					<div class="groupmemberBtn allchk" onclick="fn_groupAllChk()">전체선택</div>
					<div class="groupmemberBtn" onclick="fn_groupAddBtn()">추가</div>
					<div class="groupmemberBtn" onclick="fn_groupInfoDel()">제거</div>
				</div>	
				<i class="fas fa-times" id="groupTypeBtn" type="true"></i>
			</h4>
			<ul class="groupMember">
			</ul>
		</div>
		
		<!-- 그룹 추가 창 -->
		<div class="groupMembeWrapSm">
			<h4><span>그룹추가</span><i></i></h4>
			<div class="groupMembeWraptext">
				<input type="text" placeholder="그룹명을 입력하세요" name="id">
				<div class="groupMembeWrapSmBtn" onclick="fn_smBtn();">추가</div>
			</div>	
		</div>
		
		<!-- 친구 추가 창 -->
		<div class="friendMembeWrapSm">
			<h4><span>친구추가</span><i></i></h4>
			<div class="friendMembeWraptext">
				<input type="text" placeholder="아이디를 입력하세요" id="addFriend_input">
				<ul class="friendMemberSearch">
				</ul>
				<div class="friendMembeWrapSmBtn" onclick="fn_frindAddrequest();">추가</div>
			</div>	
		</div>
		
		<div class="send" onclick="deleteGroupMember();">보내기</div>
		
		<input type="file" style="display: none;" name="uploadFile" id="uploadFile"   accept='image/jpeg,image/gif,image/png'>
		</form>
		<%@ include file="/WEB-INF/include/include-member-nav.jspf" %>
		
	</div>
	
	<div class="imageEditor">
        <div class="header2">
           <div class="menu">
            	<span class="title">이미지 수정</span>
           		<span class="button" style="display: none;">
                    <form id="fileForm" method="post" enctype="multipart/form-data" accept-charset="UTF-8" >
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
        	<button class="btn-prov"><i class="fas fa-chevron-right"></i></button>
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
                            <li class="menu-item"><button class="submenu-button" id="btn-rotate-clockwise">+90 회전</button></li>
                            <li class="menu-item"><button class="submenu-button" id="btn-rotate-counter-clockwise">-90 회전</button></li>
                        </ul>
                    </div>
                </li>
                <li class="menu-item">
                    <button class="menu-button" id="btn-add-text">T</button>
                    <div class="submenu txtGroup">
                        <button class="btn-prev"><i class="fas fa-chevron-left"></i></button>
                        <ul class="scrollable">
                            <li class="menu-item">
                                <button class="submenu-button" id="btn-change-size">크기</button>
                                <div class="hiddenmenu">
                                    <input id="input-text-size-range" type="range" min="10" max="600" value="360">
                                </div>
                            </li>
                            <li class="menu-item">
                                <button class="submenu-button" id="btn-change-style">스타일</button>
                                <div class="hiddenmenu">
                                    <button class="hiddenmenu-button btn-change-text-style" data-style-type="bold"><b>굵게</b></button>
                                    <button class="hiddenmenu-button btn-change-text-style" data-style-type="italic"><i>이탤릭</i></button>
                                    <button class="hiddenmenu-button btn-change-text-style" data-style-type="underline"><u>밑줄</u></button>
                                </div>
                            </li>
                            <li class="menu-item">
                                <button class="submenu-button" id="btn-change-text-color">색상</button>
                                <div class="hiddenmenu">
                                    <div id="tui-text-color-picker"></div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </li>
            </ul>
        </div>
      
    </div>
</body>
<script type="text/javascript" src="/js/tui/fabric.js"></script>
<script type="text/javascript" src="/js/tui/tui-code-snippet.min.js"></script>
<script type="text/javascript" src="/js/tui/tui-color-picker.min.js"></script>
<script type="text/javascript" src="/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/js/tui/FileSaver.min.js"></script>
<script type="text/javascript" src="/js/tui-image-editor.js"></script>
<script src="/js/service-mobile.js"></script>
<script> 

	var list = [];
	var img_seq = 0;
	var seleceted_group_seq = 0;
	var seleceted_group_name = ""; 
	$('.fridel').attr('type',true);
	
	function fn_friendRequest(e, r, f){
		var n = $(e).text();
		swal({
		    title: n + '님을 추가하시겠습니까?',
		    buttons: ["NO", "YES"]})
		.then((willDelete) => {
        	if(willDelete){
        		var param = {
        				'request_seq' : r,
        				'friend_seq' : f
        		}
        		$.ajax({
                    url:"/ajax/member/insert/insertFriendInfo.do",
                    data: param,
                    type:'POST',
                    success:function(data){
                    	var value = data.result;
                    	var state = data.state;
                    	console.log(state);
                    	if(state == 'true'){
                    		
                    		if(value == 'passed'){
                          		swal('상대방이 친구요청을 철회했습니다.')
                            	.then((willDelete) => {
                		        	if(willDelete){
                		        		location.reload();
                		        	}else{
                		        		location.reload();
                		        	}
                		        });
                        	}
                    		 
                    	}else{
                    		
                    		if(value == 'passed'){
                          		swal('친구등록이 완료되었습니다.')
                            	.then((willDelete) => {
                		        	if(willDelete){
                		        		location.reload();
                		        	}else{
                		        		location.reload();
                		        	}
                		        });
                        	}
                    		
                    	}
                    	
                    },
                    error:function(jqXHR, textStatus, errorThrown){
                        alert("에러!");
                    }
                });
        	}else{
        		var param = {
        				'request_seq' : r,
        				'friend_seq' : f
            		}
            	
            		$.ajax({
                        url:"/ajax/member/delete/friendCancelRequest.do",
                        data: param,
                        type:'POST',
                        success:function(data){
                        	
                        	var state = data.state;
                  			console.log(state);
                        	if(state == "true"){
                        		
                        		swal('친구 요청이 거절되었습니다.')
                            	.then((willDelete) => {
                		        	if(willDelete){
                		        		location.reload();
                		        	}else{
                		        		location.reload();
                		        	}
                		        });
                        		
                        	}else{
                        		swal('친구 요청이 거절되었습니다.')
                            	.then((willDelete) => {
                		        	if(willDelete){
                		        		location.reload();
                		        	}else{
                		        		location.reload();
                		        	}
                		        });
                        	}
                        	
                        	
                        },
                        error:function(jqXHR, textStatus, errorThrown){
                            alert("에러!");
                        }
                    }); 
        	}
        });
	};
	
	/* 그룹 선택시 그룹창 뜸 */
	function fn_groupInfo(e, g, r){
		$('.friend ul li').css({'background-color' : '#fff'});  
		$('.friend ul li').find('input[type="checkbox"]').prop('checked', false);
		list=[];
		$('.send').hide();

		$('.groupMemberWrap span').text(r);
		var param = {
				'group_seq' : g
		} 
		
		var state = $('#groupTypeBtn').attr('type');
		console.log(state);
		if(state == 'true'){
			$.ajax({
	            url:"/ajax/member/select/selectGroupMemberInfo.do",
	            data: param,
	            type:'POST',
	            success:function(data){
	            	var body = $('.groupMember');
	            	var str = '';
	            	body.empty();
	            	if(data.group_friend_list.length == 0){
						str += '<li style="text-align: center;">그룹원을 추가해 주세요.</li>'
					}else{
		            	$.each(data.group_friend_list, function(key, value){
							str += '<li onclick="fn_chkFriend(this,'+value.friend_seq+')"><input type="checkbox" name="friend" value="'+value.friend_seq+'"/><i class="far fa-user"></i>'+value.name+'</li>'
						});
					}
	            	body.append(str);
	            	$('#groupTypeBtn').attr('type',true);
	            	$('.groupMemberWrap').show();
	            },
	            error:function(jqXHR, textStatus, errorThrown){
	                alert("에러!");
	            }
	        });
		} else {
			$.ajax({
	            url:"/ajax/member/select/selectGroupMemberInfo.do",
	            data: param,
	            type:'POST',
	            success:function(data){
	            	var body = $('.groupMember');
	            	var str = '';
	            	body.empty();
	            	if(data.group_friend_list.length == 0){
						str += '<li style="text-align: center;">제거할 그룹원이 없습니다.</li>'
					}else{
		            	$.each(data.group_friend_list, function(key, value){
							str += '<li onclick="fn_chkFriend(this,'+value.friend_seq+')"><input type="checkbox" name="friend" value="'+value.friend_seq+'"/><i class="far fa-user"></i>'+value.name+'<i class="fas fa-minus minus"></i></li>'
						});
					}
	            	body.append(str);
	            	$('.groupMemberWrap').show();
	            },
	            error:function(jqXHR, textStatus, errorThrown){
	                alert("에러!");  
	            }
	        });
		}
		
		$('.bg').show();
		seleceted_group_seq = g;
		seleceted_group_name = r;
		$('.allchk').show();
				
	}
			
	function fn_chkFriend(e, f){
		var $this = $(e);
		var chk = $this.find('input[type="checkbox"]').prop('checked');
		if(!chk){
			$this.css({'background-color' : '#eee'});
			$this.find('input[type="checkbox"]').prop('checked', true);
			list.push(f);
		}else{
			$this.css({'background-color' : '#fff'});
			$this.find('input[type="checkbox"]').prop('checked', false);
			list.splice(list.indexOf(f),1);
		}
		
		var l = $('input[type="checkbox"]:checked').length;
		if(l == 0){
			$('.send').hide();
		}else{
			$('.send').show();
		}
	}
	
	function fn_sendImage(){
		console.log(list)
		$('#input-image-file').click();
	}
	
	function fn_remove(){
	/* 	$('.friend li, .groupMember li').css({'background-color':'#fff'});
    	$('.friend li input[type="checkbox"], .groupMember li input[type="checkbox"]').prop('checked', false);
		$('#input-image-file').val('');
		$('.imageEditor, .groupMemberWrap, .bg').hide();
    	$('.loading').remove();
    	$('.send').hide();
		 */
		location.reload();
    }
    
    function fn_submit(){
    	swal({
		    title: '이미지를 공유하시겠습니까?',
		    buttons: ["NO", "YES"]})
		.then((willDelete) => {
        	if(willDelete){
        		var param = {
           				'name' : $('#input-image-file').val(),
           				'content' : imageEditor.toDataURL()
           		};
           		
    	     	$.ajax({
    		        url:"/ajax/member/insert/insertImageUpload.do",
    		        data: param,
    		        type:'POST',
    		        dataType : 'json',
    		        success:function(data){
    			        var img_seq = data.img_seq;
    			        if(img_seq != 'failed'){
	    			        fn_shrareImage(img_seq);
	    		        }else{
	    		        	swal('시스템 오류입니다.');
	    		        }
    		        
    		        },beforeSend: function() {
    		            $('body').append('<div class="loading"><div><img src="/img/loading.gif" alt="loading"></div></div>');
    	            },

    		        error:function(jqXHR, textStatus, errorThrown){
    		        	alert("에러!");
    		        }
    	        });
        	}else{
        		return false;
        	}
		});
   		
	};
	
	function fn_shrareImage(img_seq){
		jQuery.ajaxSettings.traditional = true;
		var friend_seq_list = [];
		
		$('input[name="friend"]').each(function(){
			var chk = $(this).prop('checked');
			if(chk){
				friend_seq_list.push($(this).val());
			}
		});
		friend_seq_list = friend_seq_list.toString();
		console.log(friend_seq_list)
		var param = {
				'friend_seq_list' : friend_seq_list,
				'img_seq' : img_seq
		}
		$.ajax({
            url:"/ajax/member/insert/insertSendImage.do",
            data: param,
            type:'POST',
            success:function(data){
		        swal('정상적으로 전송되었습니다.')
		        .then((willDelete) => {
					if(willDelete){
						location.reload();			
					}else{
						location.reload();
					}
		 		});
		        $('.friend li, .groupMember li').css({'background-color':'#fff'});
            	$('.friend li input[type="checkbox"], .groupMember li input[type="checkbox"]').prop('checked', false);
             	$('.imageEditor, .groupMemberWrap, .bg').hide();
            	$('.loading').remove();
            	
            },
            error:function(jqXHR, textStatus, errorThrown){
                alert("에러!");
                $('.loading').remove();
            }
        });
	}
	
	$('#input-image-file').change(function(){
		$('.imageEditor').show();
	});
	
	$('.btn-prev, #btn-apply-crop').click(function(){
		$('.submenu').hide();
	});
    $('.tui-image-editor').click(function(){
    	console.log($('.upper-canvas').css('cursor'));
    });
	
	$('.bg').click(function(){
		$(this).hide();
		$('.groupMemberWrap').hide();
		$('.groupMembeWrapSm').hide();
		$('.groupMembeWrapSmBtn').hide(); 
		$('.send').hide();
		list = [];
		$('.groupMemberAddBtn').empty();
		$('.groupMemberDelBtn').empty();
		$('.groupMemberWrap h4 i').attr({'type':'true'});
		
		$('.send').text('보내기');
	
		$('.friendMembeWrapSm').hide();
		$('.friendMembeWrapSmBtn').hide();
		$('.allchk').show();
		$('input[name="id"]').attr('value','');
		$('input[name="id"]').val("");

	});

	/* 친구 추가 버튼 클릭시  */
	function fn_frindAddrequest(){
		
		var id = $('.friendMembeWraptext input').val();
		var param={ 
				'id' : id
		}		

	
		if(id.length == 0 || isKor(id) || isSpecial(id)){
			swal('아이디 : 영문 및 숫자만 입력해주세요.');
			return false;
		}
		
		console.log(id);
		
		swal({
		    title: id+'님에게 친구 요청을 보내시겠습니까?',
		    buttons: ["NO", "YES"]})
		.then((willDelete) => {
			if(willDelete){
				
				$.ajax({
					url:"/ajax/member/insert/insertFriendRequest.do",
					data: param,
					type: 'POST',
					 success:function(data){
			            	$('.loading').remove();
			            	$('.bg').hide();
			            	$('.friendAdd').hide();
			        		$('.fradd').show();
			        		var msg = data.msg;
			        		swal(msg)
			        		.then((willDelete) => {
			        			if(willDelete){
			    				location.reload();
			        			}else{
			        				location.reload();
			        			}
					 		});
			        		
			        		
			            },
			            error:function(jqXHR, textStatus, errorThrown){
			            	swal("친구 추가 실패");
			                $('.loading').remove();
			            }
					
				})
			
			}else{
				return false;
			}
 		});
		
		
		$('.bg').hide();
		$('.friendMembeWrapSm').hide();
		$('.friendMembeWrapSmBtn').hide();
	}
	
	/* 친구 추가  */
	function fn_frindAdd(){
		$('.bg').show();
		$('.friendMembeWrapSm').show();
		$('.friendMembeWrapSmBtn').show();
		$('.friendMembeWrapSmBtn').text('추가');
		$('.friendMembeWrapSm h4 span').text('친구추가');
		$('.groupMembeWrapSmBtn').attr('value', 'friend');
		$('#addFriend_input').val("");
		$('.friendMemberSearch').empty();
		$('.send').hide();
		list = [];
		$('.friend ul li input').prop('checked', false);
		$('.friend ul li').css({'background-color' : '#fff'});
	}
	
	/* 그룹 추가 버튼 클릭시 */
	function fn_groupAddrequest(){
		var group_name = $('input[name=id]').val();
		var param ={
			'group_name' : group_name,
			'group_seq' : seleceted_group_seq
		}
		
		if(group_name.length == 0 || isSpecial(group_name)){
			swal('그룹명을 공란이 없이 입력해주세요');
			return false;
		}
		
		if(group_name.length > 11 ){
			swal('10자 이내로 작성해주세요');
			return false;
		}
		
		console.log(group_name);
		$.ajax({
			url:"/ajax/member/insert/insertGroupInfo.do",
            data: param,
            type:'POST',
            success:function(data){
            	console.log('그룹 추가 성공');
            	$('.loading').remove();
            	location.reload();
        		
            },
            error:function(jqXHR, textStatus, errorThrown){
            	swal("그룹 추가 실패");
                $('.loading').remove();
            }
		});
	}
	
	
	/* 친구 추가 및 그룹 추가 버튼 클릭시 불러오는 함수  */
	function fn_smBtn(){
		var key = $('.groupMembeWrapSmBtn').attr('value');
		console.log(key);
		if(key == 'group'){
			fn_groupAddrequest();
			/* console.log('그룹 추가 함수 소한'); */
		} else if(key == 'updateGroup'){
			/* console.log('그룹명변경');	 */
			fn_updateGroupName();
		}
		
	}
	
	/* 그룹 추가 함수  */
	
	function fn_groupAdd(){
		$('.bg').show();
		$('.groupMembeWrapSm').show();
		$('.groupMembeWrapSmBtn').show();
		
		$('.groupMembeWrapSm h4 span').text('그룹추가');
    	$('input[name="member_id"]').attr('placeholder', '그룹명을 입력하세요');
		$('.groupMembeWrapSmBtn').attr('value', 'group'); 
		$('.groupMembeWrapSmBtn').text('추가');
		$('.send').hide();
		list = [];	
		$('.friend ul li input').prop('checked', false);
		$('.friend ul li').css({'background-color' : '#fff'});
	}
	

	/* 르룹창에서 x 클릭시 */
	$('.groupMemberWrap i').click(function(){
		
		var state = $('#groupTypeBtn').attr('type');
		console.log(state);
		
		if( state == 'true' ){
			$('.groupMemberWrap').hide();
			$('.bg').hide();
			$('.send').hide();
			list = [];	
			$('.send').text('보내기');
			location.reload();
		} else if( state == 'false'){
			$('.send').hide();
			list = [];
			$('#groupTypeBtn').attr('type',true);
			fn_groupInfo(1, seleceted_group_seq, seleceted_group_name);
		}
		
	});
	
	/* 버튼 클릭시 그룹원 추가 select */
	function fn_groupAddBtn(){
		$('.send').hide();
		list = [];
		$('.groupMember').empty();		
		$('.allchk').hide();
		var param = {
				'group_seq' : seleceted_group_seq
		}
		
		$.ajax({
			url: "/ajax/member/select/selectGroupFriendAdd.do",
			data: param,
			type: 'POST',
			success: function(data){
				var body = $('.groupMember');
				var str = '';
				$('#groupTypeBtn').attr('type',false);
				
				body.empty();
				if(data.friend_list.length == 0){
					str += '<li style="text-align: center;">추가 가능한 친구가 없습니다.</li>'
				} else{
					$.each(data.friend_list, function(key, value){
						str += '<li>'+value.name+'<i class="fas fa-plus i_right" onclick="fn_insertGroup(this, '+value.friend_seq+',\''+value.name+'\')"></i></li>'
					});
				}
				body.append(str);
			},
			error: function(jqXHR, textstatus, errorThrown){
				
			}
		})
		    
	}
	
	/* 그룹원 추가 insert */
	function fn_insertGroup(e, g, n){
		console.log(seleceted_group_name);
		var $this = e;
		var group_seq = seleceted_group_seq;
		var param = {
			'group_name' : seleceted_group_name,
			'friend_seq' : g,
			'group_seq' : group_seq
		}
		
		swal({
		    title: n+'님을 '+seleceted_group_name+'그룹에 추가 하시겠습니까?', 
		    buttons: ["NO", "YES"]})
		.then((willDelete) => {
        	if(willDelete){
        		
        		$.ajax({
        			url: "/ajax/member/insert/insertGroupAdd.do",
        			data: param,
        			type: 'POST',
        			success: function(data){
        				$($this).css({'color': 'gray'});
        			}, error: function(jqXHR, textstatus, errorThrown){
        				swal("그룹원 추가 실패");
        			}
        		});
        		
        	}else{
        		return false;
        	}
        });
		
		
	}
	
	function fn_groupDelBtn(){
		
		var param = {
				'group_seq' : seleceted_group_seq
		}
		
		$.ajax({
            url:"/ajax/member/select/selectGroupMemberInfo.do",
            data: param,
            type:'POST',
            success:function(data){
            	var body = $('.groupMember');
            	var str = '';
            	body.empty();
            	$.each(data.group_friend_list, function(key, value){
					str += '<li onclick="fn_chkFriend(this,'+value.friend_seq+')"><input type="checkbox" name="friend" value="'+value.friend_seq+'"/><i class="far fa-user"></i>'+value.name+'</li>'
				});
            	body.append(str);
            },
            error:function(jqXHR, textStatus, errorThrown){
                alert("에러!");
            }
        });
		
	}
	
	function fn_groupInfoDel(){
		
		var g = seleceted_group_seq;
		var r =seleceted_group_name;
				
		$('#groupTypeBtn').attr('type',false);
		fn_groupInfo(this, g, r);
		
		$('.send').hide();
		list = [];
		$('.send').text('삭제');
		$('.allchk').hide();
		
		
		
	}
	/* fn_shrareImage */
	function deleteGroupMember(){
		
		var state = $('#groupTypeBtn').attr('type');
		console.log(state);
		
		if( state == 'false'){
			
			var group_seq = seleceted_group_seq;
			var member_seq_list = [];
			
			$('input[name="friend"]').each(function(){
				var chk = $(this).prop('checked');
				if(chk){
					member_seq_list.push($(this).val());
				}
			});
			
			member_seq_list = member_seq_list.toString();
			
			console.log(member_seq_list);
			
			
			swal({
			    title: '선택된 친구를 삭제 하시겠습니까?',
			    buttons: ["NO", "YES"]})
			.then((willDelete) => {
	        	if(willDelete){
	        		
	        		var param = {
	    					'group_seq' : seleceted_group_seq,
	    					'member_seq_list' : member_seq_list
	    			}
	    			
	        		
	        		$.ajax({
	    	            url:"/ajax/member/delete/deleteGroupMember.do",
	    	            data: param,
	    	            type:'POST',
	    	            success:function(data){
	    	            	console.log('삭제 완료');
	    	            	$('.groupMember li').each(function(){
	    	            		var chk = $(this).find('input[type="checkbox"]').prop('checked');
	    	            		if(chk){
	    	            			$(this).remove();
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
			
			
			
			
		}else{
			fn_sendImage();
		}
	}
	
	function fn_groupUpdate(){
		
		var state = $('.setting').attr('type');
		var param = {
			
		}
		
		if(state == 'true'){
			$('.setting').attr('type',false);
			
			$.ajax({
	            url:"/ajax/member/select/selectGroupInfo.do",
	            data: param,
	            type:'POST',
	            success:function(data){
	            	var body = $('.group ul');
	            	var str = '';
	            	body.empty();
	            	$('.group ul li').css({'position':'relative'});
	            	$.each(data.group_info, function(key, value){
						str += '<li><i class="fas fa-users"></i>'+value.group_name+'<div class="update" onclick="groupUpdate(this,'+value.group_seq+',\''+value.group_name+'\')">수정</div><div class="del" onclick="groupDel(this,'+value.group_seq+',\''+value.group_name+'\')">삭제</div></li>'
					});
	            	body.append(str);
	            	
	            },
	            error:function(jqXHR, textStatus, errorThrown){
	                alert("에러!");
	            }
	        });
			
		}else{
			$('.setting').attr('type',true);
			
			$.ajax({
	            url:"/ajax/member/select/selectGroupInfo.do",
	            data: param,
	            type:'POST',
	            success:function(data){
	            	var body = $('.group ul');
	            	var str = '';
	            	body.empty();
	            	$('.group ul li').css({'position':'relative'});
	            	
	            	$.each(data.group_info, function(key, value){
						str += '<li onclick="fn_groupInfo(this,'+value.group_seq+',\''+value.group_name+'\')"><i class="fas fa-users"></i>'+value.group_name+'</li>'
					});
					
	            	body.append(str);
	            	
	            },
	            error:function(jqXHR, textStatus, errorThrown){
	                alert("에러!");
	            }
	        });
		}
		
	}
	
function fn_friendDelChange(){
		
		var state = $('.fridel').attr('type');
		var param = {
			
		}
		
		if(state == 'true'){
			$('.fridel').attr('type',false);
			
			$.ajax({
	            url:"/ajax/member/select/friendSelectList.do",
	            data: param,
	            type:'POST',
	            success:function(data){
	            	$('.friend ul li').css({'position':'relative'});
	            	
	            	console.log('삭제창');
	            	var body = $('.friend ul');
	            	var str = '';
	            	body.empty();
	            	$.each(data.friend_info, function(key, value){
						str += '<li><i class="far fa-user"></i>'+value.name+'<div class="update" onclick="fn_friendDel(this,'+value.friend_seq+',\''+value.name+'\')">삭제</div></li>'
					});
	            	body.append(str);
	            	
	            },
	            error:function(jqXHR, textStatus, errorThrown){
	                alert("에러!");
	            }
	        });
			
		}else{
			$('.fridel').attr('type',true);
			
			$.ajax({
				url:"/ajax/member/select/friendSelectList.do",
	            data: param,
	            type:'POST',
	            success:function(data){
	            	console.log('기본창'); 
	            	var body = $('.friend ul');
	            	var str = '';
	            	body.empty();
	            	
	            	$.each(data.friend_info, function(key, value){
						str += '<li onclick="fn_chkFriend(this,'+value.friend_seq+');"><input type="checkbox" name="friend" value="${'+value.friend_seq+'}" /><i class="far fa-user"></i>'+value.name+'</li>'
						

					});
					
	            	body.append(str);
	            	
	            },
	            error:function(jqXHR, textStatus, errorThrown){
	                alert("에러!");
	            }
	        });
		}
		
	}
	
	function fn_friendDel(e, m, n){
		
		swal({
		    title: n + ' 친구 추가를 취소하시겠습니까?',
		    buttons: ["NO", "YES"]})
		.then((willDelete) => {
        	if(willDelete){
        		
        		var param = {
        				'friend_seq': m,
        				'name': n
        		}
        		 
        		$.ajax({
                    url:"/ajax/member/delete/deletefriend.do",
                    data: param,
                    type:'POST',
                    success:function(data){
                    	swal('취소가 완료 되었습니다.')
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
	
	function groupDel(e, r, g){
		
		swal({
		    title: g + '를 삭제 하시겠습니까?',
		    buttons: ["NO", "YES"]})
		.then((willDelete) => {
        	if(willDelete){
        		
        		var param = {
        				'group_seq': r,
        				'group_name': g
        		}
        		
        		$.ajax({
                    url:"/ajax/member/delete/deleteGroupAll.do",
                    data: param,
                    type:'POST',
                    success:function(data){
                    	swal('삭제가 완료 되었습니다.')
                    	.then((willDelete) => {
        		        	if(willDelete){
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
	
	function groupUpdate(e, r, g){
		console.log('그룹명 수정');
		var group_name = seleceted_group_name;
		console.log(group_name);
		
		$('.bg').show();
		$('.groupMembeWrapSm').show();
		$('.groupMembeWrapSmBtn').show();
		$('.groupMembeWrapSm h4 span').text('그룹명 변경');
    	$('input[name="id"]').attr('placeholder', '그룹명을 입력하세요');
    	$('input[name="id"]').val(g);
    	$('.groupMembeWrapSmBtn').attr('type', r );
		$('.groupMembeWrapSmBtn').attr('value', 'updateGroup'); 
		$('.groupMembeWrapSmBtn').text('변경');
		$('.send').hide();
		list = [];	
		$('.friend ul li input').prop('checked', false);
		$('.friend ul li').css({'background-color' : '#fff'});
	}
	
	function fn_updateGroupName(){
		var group_name = $('input[name=id]').val();
		var group_seq = $('.groupMembeWrapSmBtn').attr('type');
		
		console.log(group_seq);
		
		var param = {
				'group_name' : group_name,
				'group_seq' : group_seq
		}
		
		$.ajax({
            url:"/ajax/member/update/updateGroupName.do",
            data: param,
            type:'POST',
            success:function(data){
            	swal('변경이 완료 되었습니다.')
            	.then((willDelete) => {
		        	if(willDelete){
		        		$('.bg').hide();
		        		$('.groupMembeWrapSm').hide();
		        		$('.groupMembeWrapSmBtn').hide();
		        		location.reload();
		        	}else{
		        		$('.bg').hide();
		        		$('.groupMembeWrapSm').hide();
		        		$('.groupMembeWrapSmBtn').hide();
		        		location.reload();
		        	}
		        });
            	
        		
            },
            error:function(jqXHR, textStatus, errorThrown){
                alert("에러!");
            }
        });
	}

	/* fn_frindAddrequest 연결 */
	$('#addFriend_input').keyup(function(){
		var id = $(this).val();
		if(id == ''){
			$('.friendMemberSearch').empty();
			return false;
		}
		var param = {
				'id' : id
		}
		$.ajax({
            url:"/ajax/member/select/selectAddFriendInfo.do", 
            data: param,
            type:'POST',
            success:function(data){ 
            	var body = $('.friendMemberSearch');
            	body.empty();
            	var str = '';
            	if(data.length == 0){
            		body.empty();
            	}
            	$.each(data.member_info, function(key, value){
					str += '<li onclick="fn_addFriendInput(this,\''+value.id+'\','+value.member_seq+',\''+value.name+'\')"><i class="fas fa-users"></i>'+value.name+'</li>'
				});
            	body.append(str);
            },
            error:function(jqXHR, textStatus, errorThrown){
                alert("에러!");
            }
        });
	});
	
	function fn_addFriendInput(e, r, g, e){
		$('.friendMembeWraptext input').attr('value',r);
		$('.friendMembeWraptext input').val(r);
	}
	
	function fn_groupAllChk() {
		$('.groupMember li').css({'background-color' : '#eee'});
		$('.groupMember li input').prop('checked', true);
		$('.send').show();
		console.log('전체 선택');
		$('.allchk').show();
		
	}
	
	function fn_friendCancelRequest(e, r, m, n){
		
		swal({
		    title: n+'에게 보낸 친구 요청을 취소하시겠습니까?',
		    buttons: ["NO", "YES"]})
		.then((willDelete) => {
        	if(willDelete){
        		
        		var param = {
        			'request_seq' : r,
        			'friend_seq' : m,
        			'name' : n
        		}
        	
        		$.ajax({
                    url:"/ajax/member/delete/friendCancelRequest.do",
                    data: param,
                    type:'POST',
                    success:function(data){
                    	console.log(state);
                    	
                    	var state = data.state;
              			console.log(state);
                    	if(state == "true"){
                    		
                    		swal('삭제가 완료 되었습니다.')
                        	.then((willDelete) => {
            		        	if(willDelete){
            		        		location.reload();
            		        	}else{
            		        		location.reload();
            		        	}
            		        });
                    		
                    	}else{
                    		
                    		swal('이미 친구 추가가 완료 되었습니다.')
                        	.then((willDelete) => {
            		        	if(willDelete){
            		        		location.reload();
            		        	}else{
            		        		location.reload();
            		        	}
            		        });
                    		
                    	}
                    	
                    	
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
















