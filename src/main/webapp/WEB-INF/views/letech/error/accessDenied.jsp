<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<jsp:include page="/resources/com/inc/meta.jsp" />
<title>[NullPointerException]에러</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
</head>
<body class="error-body">
	<div class="wapper">
		<div class="container">
			<div class="login-box er_box">
				<h1 class="error_title">
					<span>ACCESS</span> DENIED
				</h1>
				<h3 class="er_txt">사용자 권한이 없습니다.<br>
					다시 한번 확인 해 주시기 바랍니다.
				</h3>
			</div>
	</div>
</div>				
<script type="text/javascript">
setTimeout("gomain()", 5000);
function gomain(){
	location.href = "/uat/uia/actionLogout.do";
}
</script>
</body>
</html>

