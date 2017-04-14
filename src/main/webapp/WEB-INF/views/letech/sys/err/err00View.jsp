<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
<jsp:include page="/resources/com/inc/meta.jsp" />
<title>Letech Intranet</title>
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.print.css' rel='stylesheet' media='print' />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
</head>

<body>
	<div id="warpper">
		<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
			<jsp:include page="/resources/com/inc/header.jsp" />
			<%@ include file="/WEB-INF/views/letech/com/layout/menu.jsp" %>
		</nav>
		<div id="page-wrapper">
			<section class="row">
			<form name="frm1" id="frm1" method="post" action="<%=request.getContextPath()%>/sys/err/err00List.do" >
				<input type="hidden" id="mode" name="mode" value="${params.mode }"/>
				<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}"/>
				<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}"/>
				<input type="hidden" id="menu_id3" name="menu_id3" value="${params.menu_id3}"/>
				<input type="hidden" name="cPage" id="cPage" value="" />
				<input type="hidden" name="error_seq" id="error_seq" value="${resultView.ERROR_SEQ }" />
				<div class="col-lg-10">
				<!-- 타이틀 및 페이지 네비 -->		
				<h4 class="title">${titleNaviMap.MN_NM }<span class="pull-right text-muted small">HOME > ${titleNaviMap.NAVI_NM }</span></h4>
					
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
					          	<th>레벨</th>
					          	<td>
					          		${resultView.ERROR_LEVEL }
					            </td>
					          	<th>발생일</th>
					          	<td>
					          		${resultView.ERROR_DATE }
					            </td>
					            <th>처리상태</th>
					          	<td>
					          		${resultView.PROCESS_STATE_NM }
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
					            <c:choose>
					            	<c:when test="${params.mode eq 'edit'}">
					            		<td colspan="5">
													<textarea rows="3" cols="50" id="process_content" class="form-control" name="process_content">${resultView.PROCESS_CONTENT }</textarea>
							            </td>
					            	</c:when>
					            	<c:otherwise>
					            		<td colspan="5">
					            			<pre>${resultView.PROCESS_CONTENT }</pre>
					            		</td>
					            	</c:otherwise>
					            </c:choose>
				            </tr>
				      	</tbody>
				    </table>
		    
		    					
				</article>
			
				<p class="clearfix">
					<span class="pull-right">
					<c:choose>
		            	<c:when test="${params.mode eq 'edit'}">
		            		<input class="btn btn-warning btn-completion" type="button" value="완료" />
							<input class="btn btn-warning btn-save" type="button" value="저장" />
		            	</c:when>
		            	<c:otherwise>
		            		<input class="btn btn-warning btn-process" type="button" value="처리" />
		            	</c:otherwise>
		            </c:choose>
					</span>
				    <input class="btn btn-default btn-list"  type="button" value="목록" />
				</p>
				</div>
			</form>
			<jsp:include page="/resources/com/inc/aside.jsp" />
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
		
		/* 완료 */
		$( ".btn-completion" ).click(function() {
			fnProcess("INSERT");
		});
		
		/* 저장 */
		$( ".btn-save" ).click(function() {
			fnProcess("UPDATE");
		});
		
		/* 처리 */
		$( ".btn-process" ).click(function() {
			fnEdit();
		});
	});
	
	/* 목록이동 */
	function goList(){
		$("#frm1").attr("action", "${pageContext.request.contextPath}/sys/err/err00List.do");
		$("#frm1").submit();
	}
	
	/* 조회화면 */
	function fnView(){
		$("#mode").val("view");
		$("#frm1").attr("action", "${pageContext.request.contextPath}/sys/err/err00View.do");
		$("#frm1").submit();
	}
	
	/* 작성화면 */
	function fnEdit(){
		$("#mode").val("edit");
		$("#frm1").attr("action", "${pageContext.request.contextPath}/sys/err/err00View.do");
		$("#frm1").submit();
	}
	
	/* 처리화면 */
	function fnProcess(mode){
		$("#mode").val(mode);
		var content = $("#process_content").val();
		var check_val = content.trim();
		
		if(check_val == null || check_val == ""){
			$("#process_content").focus();
			alert("내용을 입력해주세요.");
			return false;
		}
		
		$("#frm1").attr("action", "${pageContext.request.contextPath}/sys/err/err00Tran.do");
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