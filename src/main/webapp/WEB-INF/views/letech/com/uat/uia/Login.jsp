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
		<div class="container">
	<form name="loginForm" action ="<%=request.getContextPath()%>/uat/uia/actionLogin.do" method="post">
	<input type="hidden" name="file1" id="file1" value=""/>
	<input type="hidden" name="file2" id="file2" value=""/>
	<input type="hidden" name="seq_no" id="seq_no" value="1111111"/>
	<input type="hidden" name="flag" id="flag" value="Y"/>
			<div class="login_box">
				<div class="col_md_8">
					<div class="">
						<div class="">
							<img src="<%=request.getContextPath()%>/resources/images/layout/log_logo.png" alt="엘이테크 로고">
						</div>
						<h1 class="tit_login">INTRANET</h1>
						<p	>이곳은 엘이테크 임직원 전용 인트라넷 입니다.<br>
							인트라넷은 외부에는 비공개로 운영되며, 외부인의 접근을 금합니다.
						</p>
						<img class="visual_img" src="<%=request.getContextPath()%>/resources/images/layout/log_visual.jpg" alt="로그인 페이지 비주얼 이미지" />
					</div>
				</div>
				<div class="col_md_4">
					<form class="frm_box">
						<fieldset class="log_box">
							<legend>로그인</legend>
							<div class="log_frm">
								<div class="img_pfile">
									<img src="<%=request.getContextPath()%>/resources/images/layout/log_pflie.png"  alt=""/>
								</div>
								<input type="text" id="id" name="id" value=""  class="ipt_black "   placeholder="ID">
								<input type="password" id="password"  class="ipt_black " name="password"  placeholder="Password">
								<input type="submit" value="LOGIN" class="btn_lg btn_primary " >
							</div>
<!-- 							<div class="col_md_12"> -->
<!-- 								<div class=""> -->
<!-- 									<a href="" class="col_md_6 forgot" > -->
<!-- 										아이디/ 비밀번호 찾기 -->
<!-- 									</a> -->
<!-- 									<a href="" class="col_md_6 join" > -->
<!-- 										회원가입 -->
<!-- 									</a> -->
<!-- 								</div> -->
<!-- 							</div> -->
						</fieldset>
					</form>
				</div>
				
			</div>
			

	
	
	</form>
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