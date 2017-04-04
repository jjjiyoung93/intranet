<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>[Exception]에러</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
</head>

<body class="login">
<div class="container">
	<div class="er_box">
		<div class="col_md_12">
			<h1 class="error_title">
				Exception<span> Error</span> 
			</h1>
		</div>
		<h3 class="er_txt">요청을 처리하는 과정에서 문제가 발생했습니다.(java.lang.Exception)<br>
				다시 한번 확인 해 주시기 바랍니다.
		</h3>
	</div>
</div>

<!-- <script type="text/javascript">
setTimeout("gomain()", 5000);
function gomain(){
	location.href = "/index.do";
}
</script> -->

</body>
</html>