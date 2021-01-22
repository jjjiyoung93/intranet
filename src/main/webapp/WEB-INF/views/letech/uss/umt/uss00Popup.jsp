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
<link href="${pageContext.request.contextPath}/resources/js/css/ui-lightness/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" >

<jsp:include page="/resources/com/inc/javascript.jsp" />
</head>
<body class="pop">
<div id="wrap" class="container">
	<section class="col_md_12" >
		<form class="pp_form2" name="frm1" id="frm1" method="post" action="${pageContext.request.contextPath}/search/uss00Popup.do" >
			<input type="hidden" name="cPage" id="cPage" value="${cPage }" />
			<fieldset>
				<h1 class="">사용자 검색</h1>
				<div class="clearfix pop-contents">
					<span class="pull-right">
						<span class="form-inline">
							<select name="searchGubun" id="searchGubun" class="form-control table-cell" title="search">
								<option value="01" <c:if test="${params.searchGubun eq '01'}">selected = "selected"</c:if>>ID</option>
								<option value="02" <c:if test="${params.searchGubun eq '02'}">selected = "selected"</c:if>>성명</option>
							</select>
							<input class="form-control table-cell" type="text" name="searchField" id="searchField"  value="${params.searchField}" class="col_md_5" title="검색어 입력" />
							<input type="button" class="fnSearch btn-info btn table-cell" value="검색" title="검색" />
						</span>							
					</span>
				</div>
				
				<div class="table-responsive">
					<table class="table table-bordered" summary="사용자검색 목록">
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
								<th class="visible-md visible-lg">번호</th>
								<th>ID</th>
								<th>성명</th>
								<th>권한</th>
								<th class="visible-md visible-lg">이메일</th>
								<th class="visible-md visible-lg">전화번호</th>
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
											<th class="visible-md visible-lg">${totalCnt - status.index - ((cPage-1) * (intListCnt))}</th>
											<td style="text-align: left;">&nbsp;
												<a href="#" onclick="javascript:setData('${list.USS_ID}', '${list.USS_NM }', '${list.USS_AUTH_NM }', '${list.DP_NM }');">${list.USS_ID}</a>
											</td>
											<td>${list.USS_NM}</td>
											<td>${list.USS_AUTH_NM}</td>
											<td class="visible-md visible-lg">${list.USS_EMAIL}</td>
											<td class="visible-md visible-lg">${list.USS_TEL}</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<p class="clearfix pop-btn">
					<ul class="pagination pagination-sm">
						${pageNavigator }
					</ul>
					<!--<a href="#cancel" class="btn-cancel" onclick="window.parent.closeModal();"><span>닫기</span></a> -->
					<span class="pull-right">
						<a href="#cancel" class="btn btn-default btn-sm" onclick="window.self.close();">닫기</a>
					</span>
				</p>
			</fieldset>
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


function setData(id, nm, auth_nm, dept_nm){
	$(opener.location).attr("href", "javascript:setUssForm('"+id+"', '"+nm+"', '"+auth_nm+"', '"+dept_nm+"')");
	window.close();
}
</script>
</body>
</html>