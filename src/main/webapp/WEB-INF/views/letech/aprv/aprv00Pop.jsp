<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
<jsp:include page="/resources/com/inc/meta.jsp" />
<title>Letech Intranet</title>
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.print.css' rel='stylesheet' media='print' />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/bbs_${bbsInfo.LAYOUT_TY}.css">
<link href="${pageContext.request.contextPath}/resources/js/css/ui-lightness/jquery-ui-1.9.2.custom.min.css" rel="stylesheet">
<style type="text/css">
body{
	background: white;
}

.table tbody tr td{
	vertical-align: middle;
}
</style>
</head>

<body>
	<!-- 전체 감싸는 id -->
	<div class="container">
		<!-- 컨텐츠-->
		<section class="clearfix">
			<div class="form-group">
				<label class="control-label h3" for="searchArea"><strong>출발지 및 도착지 검색</strong></label>
				<table class="table table-bordered" id="searchArea">
					<colgroup>
						<col width="25%"></col>
						<col width="25%"></col>
						<col width="25%"></col>
						<col width="25%"></col>
					</colgroup>
					<thead>
						<tr>
							<th class="text-center">구분</th>
							<th class="text-center">시/도</th>
							<th class="text-center">시/군</th>
							<th class="text-center">구</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="text-center">출발지</td>
							<td class="text-center">
								<select class="form-control">
									<option>--선택--</option>
									<option>서울특별시</option>
									<option>세종특별시</option>
									<option>부산광역시</option>
									<option>대구광역시</option>
									<option>인천광역시</option>
									<option>광주광역시</option>
									<option>대전광역시</option>
								</select></td>
							<td class="text-울산광역시center">
								<select class="form-control">
									<option>--선택--</option>
								</select>
							</td>
							<td class="text-center">
								<select class="form-control">
									<option>--선택--</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="text-center">도착지</td>
							<td class="text-center">
								<select class="form-control">
									<option>--선택--</option>
									<option>서울특별시</option>
									<option>세종특별시</option>
									<option>부산광역시</option>
									<option>대구광역시</option>
									<option>인천광역시</option>
									<option>광주광역시</option>
									<option>대전광역시</option>
								</select>
							</td>
							<td class="text-center">
								<select class="form-control">
									<option>--선택--</option>
								</select>
							</td>
							<td class="text-center">
								<select class="form-control">
									<option>--선택--</option>
								</select>
							</td>
						</tr>

					</tbody>
				</table>
				<div class="text-right">
					<input type="button" class="btn btn-info" value="저장">
					<input type="button" class="btn" value="닫기" onclick="self.close()">
				</div>
			</div>
		</section>
	</div>
	<!-- js파일 및 공통스크립트사용 -->
	<jsp:include page="/resources/com/inc/javascript.jsp" />
</body>
</html>