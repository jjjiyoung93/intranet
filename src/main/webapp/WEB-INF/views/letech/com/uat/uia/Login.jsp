<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Letech Intranet</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
</head>
<body class="login">
	<div id="wrapper">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-md-4 col-md-offset-4">
					<form name="loginForm" action ="<%=request.getContextPath()%>/uat/uia/actionLogin.do" method="post">
						<input type="hidden" name="file1" id="file1" value=""/>
						<input type="hidden" name="file2" id="file2" value=""/>
						<input type="hidden" name="seq_no" id="seq_no" value="1111111"/>
						<input type="hidden" name="flag" id="flag" value="Y"/>
							<div class="account-wall">
								<img src="<%=request.getContextPath()%>/resources/images/layout/log_pflie.png"  alt=""/>
								<p class="text">이곳은 엘이테크 임직원 전용 인트라넷 입니다.<br>
								인트라넷은 외부에는 비공개로 운영되며, 외부인의 접근을 금합니다.
								</p>
							<div class="form-signin">
								<input type="text" id="id" name="id" value="" class="form-control form-group" placeholder="ID">
								<input type="password" id="password"  class="form-control form-group" name="password"  placeholder="Password">
								<input type="submit" value="LOGIN" class="btn btn-warning btn-block" >
							</div>
						</div>
					</form>
					</div>
				</div>
			</div>
	</div>
</body>
</html>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">

function fnGoJoin(){
	alert("이동");
	document.frm1.submit();
}

function actionLogin() {

    if (document.loginForm.id.value =="") {
        alert("아이디를 입력하세요");
    } else if (document.loginForm.password.value =="") {
        alert("비밀번호를 입력하세요");
    } else {
        document.loginForm.action="<c:url value='/uat/uia/actionLogin.do'/>";
        //document.loginForm.j_username.value = document.loginForm.userSe.value + document.loginForm.username.value;
        //document.loginForm.action="<c:url value='/j_spring_security_check'/>";
        document.loginForm.submit();
    }
}


</script>