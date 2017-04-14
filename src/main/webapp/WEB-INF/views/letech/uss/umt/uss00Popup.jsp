<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
<jsp:include page="/resources/com/inc/meta.jsp" />
<title>Letech Intranet</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.print.css' rel='stylesheet' media='print' />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">

<jsp:include page="/resources/com/inc/javascript.jsp" />
</head>
<body>
<div id="wrap">
	<section class="col_md_12" >
			<form class="pp_form2" name="frm1" id="frm1" method="post" action="${pageContext.request.contextPath}/search/uss00Popup.do" >
				<input type="hidden" name="cPage" id="cPage" value="${cPage }" />
				 <h2 class="sub_title">사용자 검색</h2>
				<fieldset>
					<div class="col_md_8 full-right">
						<select name="searchGubun" id="searchGubun" class="col_md_3" title="search">
							<option value="01" <c:if test="${params.searchGubun eq '01'}">selected = "selected"</c:if>>ID</option>
							<option value="02" <c:if test="${params.searchGubun eq '02'}">selected = "selected"</c:if>>성명</option>
						</select>
						<input class="col_md_7" type="text" name="searchField" id="searchField"  value="${params.searchField}" class="col_md_5" title="검색어 입력" />
						<input type="button" class="fnSearch btn btn_info" value="검색" title="검색" />
					</div>
				</fieldset>
				<table width="100%" cellspacing="0" cellpadding="0"  summary="사용자관리 목록">
					<caption>사용자관리 목록</caption>
					<colgroup>
						<col width="5%" />
						<col width="16%" />
						<col width="10%" />
						<col width="20%" />
						<col width="*" />
						<col width="20%" />
					</colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>ID</th>
							<th>성명</th>
							<th>권한</th>
							<th>이메일</th>
							<th>전화번호</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${totalCnt < 1 }">
								<tr>
									<td colspan="5">검색된 내용이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="list" items="${resultList}" varStatus="status">
									<tr>
										<th>${totalCnt - status.index - ((cPage-1) * (intListCnt))}</th>
										<td style="text-align: left;">&nbsp;
											<a href="#" onclick="javascript:setData('${list.USS_ID}', '${list.USS_NM }');">${list.USS_ID}</a>
										</td>
										<td>${list.USS_NM}</td>
										<td>${list.USS_AUTH_NM}</td>
										<td>${list.USS_EMAIL}</td>
										<td>${list.USS_TEL}</td>
									</tr>
								</c:forEach>
							</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			<div class="table_foot2">
				<!-- pase nav-->
				<p class="page_nav" style="text-align: center;">
					<strong>${pageNavigator }</strong>
					<button class="fnClose full-right btn btn_info" >닫기</button>
				</p>
			</div>
		</form>
	</section>
</div>
<script type="text/javascript">

$(document).ready(function(){
	$(".fnClose").click(function(){
		window.close();
	});

	$(".fnSearch").click(function(){
		goPage('1');
	})
});

function goPage(cPage){
	$("#cPage").val(cPage);
	$("#frm1").attr("action", "${pageContext.request.contextPath}/search/uss00Popup.do");
	$("#frm1").submit();
}


function setData(id, nm){
	$(opener.location).attr("href", "javascript:setUssForm('"+id+"', '"+nm+"')");
	window.close();
}
</script>
</body>
</html>