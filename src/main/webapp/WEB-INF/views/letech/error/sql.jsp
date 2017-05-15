<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<jsp:include page="/resources/com/inc/meta.jsp" />
<title>[데이터베이스]에러</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
</head>

<body class="error-body">
	<div class="wapper">
		<div class="container">
			<div class="er_box">
				<div class="col_md_12">
					<h1 class="error_title">
						SQL<span>Error</span>
					</h1>
				</div>
				<h3 class="er_txt">요청을 처리하는 과정에서 문제가 발생했습니다.<br>
						다시 한번 확인해 주시기 바랍니다.
				</h3>
			</div>
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