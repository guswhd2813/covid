// input 길이제한
function maxLengthCheck(object){
	if (object.value.length > object.maxLength){
		object.value = object.value.slice(0, object.maxLength);
	}    
}

String.prototype.replaceAll = function(org, dest) {
    return this.split(org).join(dest);
}

// 한글 체크 정규식
function isKor(asValue) {
	var regExp = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
	return regExp.test(asValue); // 형식에 맞는 경우 true 리턴	
}

// 영문 체크 정규식
function isEng(asValue) {
	var regExp = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
	return regExp.test(asValue); // 형식에 맞는 경우 true 리턴	
}

// 숫자 체크 정규식
function isNum(asValue) {
	var regExp = /[0-9]/;
	return regExp.test(asValue); // 형식에 맞는 경우 true 리턴	
}

// 특수문자 체크 정규식
function isSpecial(asValue) {
	var regExp = /[~!@#$%^&*()_+|<>?:{}]/;;
	return regExp.test(asValue); // 형식에 맞는 경우 true 리턴	
}

// 이메일 체크 정규식
function isEmail(asValue) {
	var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	return regExp.test(asValue); // 형식에 맞는 경우 true 리턴	
}

// 핸드폰 번호 체크 정규식
function isCelluar(asValue) {
	var regExp = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/;
	return regExp.test(asValue); // 형식에 맞는 경우 true 리턴
}

//비밀번호 체크 정규식
function isPassword(asValue) {
	var regExp = /^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,20}$/; //  8 ~ 20자 영문, 숫자 조합
	return regExp.test(asValue); // 형식에 맞는 경우 true 리턴
}

// input 공백 제거
function rmBlank(e){
    var txt = $(e).val().replace(/ /gi, '');
    $(e).val(txt);
}

// replace all
String.prototype.replaceAll = function(org, dest) {
    return this.split(org).join(dest);
}