<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Letech Intranet</title>
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.print.css' rel='stylesheet' media='print' />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
</head>

<body>
<div id="wrap">
	<jsp:include page="/resources/com/inc/header.jsp" />
    <%-- <jsp:include page="/resources/com/inc/menu.jsp" /> --%>
	<%--<jsp:include page="/WEB-INF/views/letech/com/layout/menu.jsp" /> --%>
	<%@ include file="/WEB-INF/views/letech/com/layout/menu.jsp" %>
    <div class="container">
   	 	<jsp:include page="/resources/com/inc/aside.jsp" />
		<section class="contents">
			<form name="frm1" id="frm1" method="post" action="<%=request.getContextPath()%>/sys/err/err01List.do" >
				<input type="hidden" id="mode" name="mode" value="${params.mode }"/>
				<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}"/>
				<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}"/>
				<input type="hidden" id="menu_id3" name="menu_id3" value="${params.menu_id3}"/>
				<input type="hidden" name="cPage" id="cPage" value="" />
				<input type="hidden" name="error_seq" id="error_seq" value="${resultView.ERROR_SEQ }" />
				
				<!-- 타이틀 및 페이지 네비 -->		
				<h2 class="sub_title">
					${titleNaviMap.MN_NM }
					<span class="page_navi full-right">HOME > ${titleNaviMap.NAVI_NM }</span>
				</h2>
					
				<c:if test="${mnList3 ne null}">
					<article>
						<ul class="tab_gnb">
								<c:forEach var="list3" items="${mnList3}" varStatus="status">
									<c:if test="${params.menu_id2 eq list3.UP_MN}">
										<li class="<c:if test="${params.menu_id3 eq list3.MN}">on </c:if>col_md_3">
											<a href="javascript:fnTabMove('${list3.MN_HREF}','${list3.MN}')">${list3.MN_NM}</a>
										</li>
									</c:if>
							</c:forEach>
						</ul>
			   		</article>
				</c:if>
				
				<!-- page -->
				<article>
					<table width="100%" cellpadding="0" cellspacing="0" class="table_info">
						<colgroup>
							<col width="10%" />
							<col width="*" />
							<col width="10%" />
							<col width="25%" />
							<col width="10%" />
							<col width="10%" />
						</colgroup>
				     	<tbody>
				            <tr>
					          	<th>로거</th>
					          	<td colspan="3">
									${resultView.ERROR_LOGGER }
					            </td>
					            <th>메소드</th>
					            <td>
					            	${resultView.ERROR_METHOD }
					            </td>
				            </tr>
				            <tr>
				            	<th>스레드</th>
					          	<td>
					          		${resultView.ERROR_THREAD }
					            </td>
					          	<th>발생일</th>
					          	<td colspan="3">
					          		${resultView.ERROR_DATE }
					            </td>
				            </tr>
				             <tr>
					          	<th>레벨</th>
					          	<td>
					          		${resultView.ERROR_LEVEL }
					            </td>
					          	<th>처리일</th>
					          	<td>
					          		${resultView.PROCESS_DATE }
					            </td>
					            <th>처리자</th>
					            <td>
					            	${resultView.PROCESS_REG_NM }
					            </td>
				            </tr>
				            <tr>
					          	<th>발생위치</th>
					          	<td colspan="5">
					          		${resultView.ERROR_LOCATION }
					            </td>
				            </tr>
				            <tr>
					          	<th>메세지</th>
					          	<td colspan="5">
					          		${resultView.ERROR_MESSAGE }
					            </td>
				            </tr>
				            <tr>
				            	<th>내용</th>
			            		<td colspan="5">
			            			<pre>${resultView.PROCESS_CONTENT }</pre>
			            		</td>
				            </tr>
				      	</tbody>
				    </table>
				</article>
			
				<div class="full-right">
				    <input class="btn btn_default btn-list"  type="button" value="목록" />
				</div>
			</form>
		</section>
	</div>
	
	<jsp:include page="/resources/com/inc/footer.jsp" />
</div>

<!-- js파일 및 공통스크립트사용 -->
<jsp:include page="/resources/com/inc/javascript.jsp" />

<script type="text/javascript">
	$(document).ready(function() {
		/* 목록 */
		$( ".btn-list" ).click(function() {
			goList();
		});
	});
	
	/* 목록이동 */
	function goList(){
		$("#frm1").attr("action", "${pageContext.request.contextPath}/sys/err/err01List.do");
		$("#frm1").submit();
	}
	/*********************************************************************************
	* function명   : fnTabMove
	* function기능 : 탭이동
	**********************************************************************************/
	function fnTabMove(href,pm1){
		document.frm1.action = "<%=request.getContextPath() %>/"+href;
		document.frm1.menu_id3.value = pm1;
		document.frm1.submit();
		
	}

</script>
</body>
</html>