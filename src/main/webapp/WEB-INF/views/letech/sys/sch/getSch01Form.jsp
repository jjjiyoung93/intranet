<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"  %>
<html>
<head>
<jsp:include page="/resources/com/inc/meta.jsp" />
<title>Letech Intranet</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
</head>
<style>
td{
	border-collapse : collapse; 
	border-spacing: 0;
}
</style>
<body class="pop">
	<div id="wrap" class="container">

		<form class="pp_form" id="form2" name="form2" method="post" action="">
			<fieldset>
				<h1 class="" id="title">이력조회</h1>
		<!-- 
		<div class="row" style="padding : 0 20px 0 20px;">
			<h3 class="page-title clearfix" style="padding-bottom :13px;">
			 비즈플레이 이력조회
			</h3>
		</div>
		-->
			<!-- 이력조회 테이블 -->
			<div class="table-responsive" style="padding :10px 20px 5px 20px;">
				<!-- 테이블 -->
				<table class="table table-bordered" style="border-collapse: collapse; border-spacing: 0">
					<caption>그룹별급수 정보관리</caption>
					<colgroup>
						<col width="10%" />
						<col width="*" />
						<col width="20%" />
						<col width="20%" />
						<col width="20%" />
					</colgroup>
					<thead>
						<tr>
							<th>순번</th>
							<th>실행일</th>
							<th>결과</th>
							<th>대상건 수</th>
							<th>처리건 수</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td align="center">5</td>
							<td align="center">2020.10.21</td>
							<td align="center">성공</td>
							<td align="right">100</td>
							<td align="right">100</td>
						</tr>
						<tr>
						<td align="center">4</td>
							<td align="center">2020.10.21</td>
							<td align="center">성공</td>
							<td align="right">150</td>
							<td align="right">150</td>
						</tr>
						<tr>
							<td align="center">3</td>
							<td align="center">2020.10.21</td>
							<td align="center">성공</td>
							<td align="right">120</td>
							<td align="right">120</td>
						</tr>
						<tr>
							<td align="center">2</td>
							<td align="center">2020.10.21</td>
							<td align="center">성공</td>
							<td align="right">130</td>
							<td align="right">130</td>
						</tr>
						<tr>
							<td align="center">1</td>
							<td align="center">2020.10.21</td>
							<td align="center">성공</td>
							<td align="right">100</td>
							<td align="right">100</td>
						</tr>
					</tbody>
				</table>
			</div><!-- table 끝 -->
				
			<!-- 
			<div class="text-center">
				<ul class="pagination pagination-sm">
						${pageNavigator}
				</ul>
			</div>
			-->
		
			
			<div class="text-center">
			 <br>
			    <!-- page nav -->
		       <ul class="pagination pagination-sm">
		          <li class="active"><a href="#">1</a></li>
		       </ul>
			</div>
			
			
			</fieldset>
		</form>
	</div>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">

</script>
</body>
</html>