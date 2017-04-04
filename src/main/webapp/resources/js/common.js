/**
 * 
 */

/**
 * 이메일 유효성 체크
 */
function fnEmailCheck(email){
	var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	
	 if(!regEmail.test(email)) {
         return false;
     }else{
    	 return true;
     }
}

/**
 * 전화번호 유효성 체크
 * @param phone
 * @returns {Boolean}
 */
function fnPhoneCheck(phone){
	var re_tel = /^[0-9]{8,11}$/;

	if(!re_tel.test(phone)) {
		return false;
	}else{
		return true;
	}
}

/**
 * 휴대전화번호 유효성 체크
 * @param phone
 */
function fnHandPhoneCheck(phone){
	var regPhone = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;

	if(!regPhone.test(phone)) {
		return false;
	}else{
		return true;
	}
}