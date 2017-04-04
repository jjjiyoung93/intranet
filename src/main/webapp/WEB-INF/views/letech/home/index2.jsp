<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
<P>  <c:if test="${loginVO != null}">
		${loginVO.name }님 환영합니다. <a href="${pageContext.request.contextPath }/uat/uia/actionLogout.do">로그아웃</a>
	</c:if>
	</P>
<form name="frm1" id="frm1" method="post" action="<%=request.getContextPath()%>/usr/join.do" >
<input type="hidden" name="file1" id="file1" value=""/>
<input type="hidden" name="file2" id="file2" value=""/>
<input type="hidden" name="seq_no" id="seq_no" value="1111111"/>
<input type="hidden" name="flag" id="flag" value="Y"/>


<div>
<a href="/letech/usr/memb00L.do">회원가입</a>
<a href="/letech/usr/memb00L.do">로그인</a>
<a href="/letech/sample/list.do">샘플페이지</a>
<a href="/letech/sample/menu.do">샘플프레임</a>
<a href="/letech/sys/cdm/list.do">코드관리</a>
<a href="/letech/sys/mnm/mnm00List.do">메뉴관리</a>
<a href="/letech/uss/umt/uss00List.do">사용자관리</a>
<a href="/letech/cal/cal00List.do">일정관리</a>

</div>

</form>
</body>
</html>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">

function fnGoJoin(){
	alert("이동");
	document.frm1.submit();
}



</script>