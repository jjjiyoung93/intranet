<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<jsp:include page="/resources/com/inc/meta.jsp" />
	<title>Letech Intranet</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
</head>
	<body class="login" onload="loginCheck()">
		<div id="wrapper">
			<div class="container">
				<form name="loginForm" action ="<%=request.getContextPath()%>/uat/uia/actionLogin.do" method="post" onsubmit="return actionLogin()">
					<input type="hidden" name="file1" id="file1" value=""/>
					<input type="hidden" name="file2" id="file2" value=""/>
					<input type="hidden" name="seq_no" id="seq_no" value="1111111"/>
					<input type="hidden" name="flag" id="flag" value="Y"/>
					<input type="hidden" name="loginYn" id="loginYn" value="${loginYn }"/>
					<div class="login-box">
						<div class="clearfix">
							<div class="col-sm-6 login-cont">
								<div class="login-back">
									<h1 class="login-logo clearfix">
										<img src="<%=request.getContextPath()%>/resources/images/layout/login-logo-white.png" alt="login-logo.png" />
										<span class="pull-right visible-xs">Intranet</span>
									</h1>
									<h2 class="login-intra">INTRANET</h2>
									<p>
									인트라넷은 외부에는 비공개로 운영되며, 외부인의 접근을 금합니다.
									</p>
								</div>
							</div>
							<div class="col-sm-6 login-form">
								<h3>Sing in</h3>
								<p> <strong>엘이테크 임직원 전용 인트라넷</strong> </p>
								<input type="text" id="id" name="id" value="" class="form-control form-group input-lg" placeholder="ID">
										<input type="password" id="password"  class="form-control form-group input-lg" name="password"  placeholder="Password">
										<input type="submit" value="LOGIN" class="btn btn-lg btn-info btn-block">
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</body>
</html>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
function loginCheck(){
	 if (document.loginForm.loginYn.value == "N") {
		 alert("일치하는 정보가 없습니다.\n아이디와 비밀번호를 확인해주세요.");
	 }
	 document.loginForm.id.focus();
}

function actionLogin() {
    if (document.loginForm.id.value =="") {
        alert("아이디를 입력하세요");
        document.loginForm.id.focus();
        return false;
    } else if (document.loginForm.password.value =="") {
        alert("비밀번호를 입력하세요");
        document.loginForm.password.focus();
        return false;
    } else if (document.loginForm.password.value.length <= 3) {
    	alert("비밀번호는 4자리 이상 입력하셔야합니다.");
    	document.loginForm.password.focus();
    	return false;
    } /* else {
        document.loginForm.action="<c:url value='/uat/uia/actionLogin.do'/>";
        //document.loginForm.j_username.value = document.loginForm.userSe.value + document.loginForm.username.value;
        //document.loginForm.action="<c:url value='/j_spring_security_check'/>";
        document.loginForm.submit();
    } */
}


</script>