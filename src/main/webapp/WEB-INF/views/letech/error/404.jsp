<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<jsp:include page="/resources/com/inc/meta.jsp" />
<title>[404]에러</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
</head>
<body class="login">
	<div class="container">
		<div class="er_box">
			<div class="col_md_12">
				<h1 class="error_title">
					404<span>Error</span>
				</h1>
			</div>
			<h3 class="er_txt">호출 주소가 없습니다.<br>
					다시 한번 확인 해 주시기 바랍니다.
			</h3>
		</div>
	</div>
</body>
