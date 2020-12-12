$(function(){
	
	if( /Android/i.test(navigator.userAgent)) {
	    // 안드로이드
	}else if (/iPhone|iPad|iPod/i.test(navigator.userAgent)) {
	    // iOS 아이폰, 아이패드, 아이팟
		$('.contentWrap').css({'padding':'50px 0 170px 0'});
	}else {
	    // 그 외 디바이스
	}
	
	//disable dd touch zoom
	var lastTouchEnd = 0;
	document.documentElement.addEventListener('touchend', function (event) {
	    var now = (new Date()).getTime();
	    if (now - lastTouchEnd <= 300) {
	      event.preventDefault();
	    }
	    lastTouchEnd = now;
	}, false);
	
	//disable pinch zoom
	document.documentElement.addEventListener('touchstart', function (event) {
		if (event.touches.length > 1) { 
			event.preventDefault(); 
		} 
	}, false);


});