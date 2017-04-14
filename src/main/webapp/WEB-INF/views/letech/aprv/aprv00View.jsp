<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
<jsp:include page="/resources/com/inc/meta.jsp" />
<title>Letech Intranet</title>
<link href="<%=request.getContextPath()%>/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/dataTables.bootstrap.min.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/dataTables.responsive.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.print.css' rel='stylesheet' media='print' />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/bootstrap.min.js"></script>
</head>
<body>




		<div id="wrapper">
		 	<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
				<jsp:include page="/resources/com/inc/header.jsp" />
				<jsp:include page="/WEB-INF/views/letech/com/layout/menu.jsp" />
			</nav>
			<div id="page-wrapper">
				<div class="row">
				<div class="col-lg-10">
					<h4 class="title">${titleNaviMap.MN_NM }<span class="pull-right text-muted small">HOME > ${titleNaviMap.NAVI_NM }</span></h4>
					<form name="frm1" id="frm1" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/aprv/aprv00List.do" >
						<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}" />
						<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}" />
						<input type="hidden" id="mode" name="mode" value="${params.mode }" />
						<input type="hidden" id="aprv_no" name="aprv_no" value="${viewMap.APRV_NO }" />
						<input type="hidden" id="line_chk" name="line_chk" value="${params.line_chk }" />
						<!-- 검색 정보 Start -->
						<input type="hidden" name="cPage" id="cPage" value="${param.cPage }" />
						<input type="hidden" id="searchCdList1" name="searchCdList1" value="${param.searchCdList1}" />
						<input type="hidden" id="searchCdList2" name="searchCdList2" value="${param.searchCdList2}" />
						<input type="hidden" id="searchCdList3" name="searchCdList3" value="${param.searchCdList3}" />
						<input type="hidden" id="searchGubun" name="searchGubun" value="${param.searchGubun}" />
						<input type="hidden" id="searchField" name="searchField" value="${param.searchField}" />
						<!-- 검색 정보 End -->

					<div class="board-view">
						<ul>
							<li>
								<dl class="row first-line ">
									<dt class="col-md-2 col-xs-3">보고자</dt>
									<dd class="col-md-10 col-xs-9">${viewMap.REPT_APRV_NM }</dd>
								</dl>
							</li>
							<li>
								<dl class="row">
									<dt class="col-md-2 col-xs-3">소속</dt>
									<dd class="col-md-10 col-xs-9">${viewMap.DPNM }</dd>
								</dl>
							</li>
							<li>
								<dl class="row">
									<dt class="col-md-2 col-xs-3">프로젝트</dt>
									<dd class="col-md-10 col-xs-9">
										<c:forEach var="proj" items="${projList }" varStatus="status">
											<c:if test="${proj.CD eq viewMap.PROJ_CD }">
																		${proj.CD_NM }
											</c:if>
										</c:forEach>
									</dd>
								</dl>
							</li>
							<li>
								<dl class="row">
									<dt class="col-md-2 col-xs-3">결제구분</dt>
									<dd class="col-md-10 col-xs-9">
										결제구분:
										<c:forEach var="code" items="${codeList}">
											<c:if test="${viewMap.APRV_TYPE_CD eq code.CD }">
																		<font style="color:red">${code.CD_NM}</font>
											</c:if>
										</c:forEach>
																		&nbsp;&nbsp;&nbsp;
																		상세구분:
										<c:forEach var="code2" items="${codeList2}">
											<c:if test="${viewMap.APRV_TYPE_DTIL_CD eq code2.CD }">
																		<font style="color:red">${code2.CD_NM}</font>
											</c:if>
										</c:forEach>
									</dd>
								</dl>
							</li>
							<li>
								<dl class="row">
									<dt class="col-md-2 col-xs-3">제목</dt>
									<dd class="col-md-10 col-xs-9">${viewMap.TITLE }</dd>
								</dl>
							</li>
							<li>
								<dl class="row">
									<dt class="col-md-2 col-xs-3">기간</dt>
									<dd class="col-md-10 col-xs-9">${viewMap.TERM_ST_YM } ~ ${viewMap.TERM_ED_YM }</dd>
								</dl>
							</li>
							<li>
								<dl class="row">
									<dt class="col-md-2 col-xs-3">행선지</dt>
									<dd class="col-md-10 col-xs-9">${viewMap.PLACE }</dd>
								</dl>
							</li>
							<li>
								<dl class="row">
									<dt class="col-md-2 col-xs-3">보고내용</dt>
									<dd class="col-md-10 col-xs-9">${viewMap.REPT_CONT }</dd>
								</dl>
							</li>
							<li>
								<dl class="row">
									<dt class="col-md-2 col-xs-3">첨부파일</dt>
									<dd class="col-md-10 col-xs-9">
										<c:forEach var="file" items="${fileList }" varStatus="status">
											<div id="file_${file.FILE_NO }"><a href="#" onclick="fn_downFile('${file.FILE_PATH}', '${file.FILE_STRE_NM }', '${file.FILE_NM }')">${file.FILE_NM }</a></div>
										</c:forEach>
									</dd>
								</dl>
							</li>
						</ul>
						<div class="row">
							<dl class="panel panel-default">
								<dt class="panel-heading">결제라인</dt>
								<dd class="panel-body">
									<table class="table table-striped table-bordered table-hover dataTable no-footer dtr-inline" id="dataTables-example" role="grid" aria-describedby="dataTables-example_info" style="width: 100%;">
									<colgroup>
										<col width="10%"/>
				    					<c:if test="${params.line_chk eq 'N' }">
					    					<col width="15%"/>
				    					</c:if>
										<col width="10%"/>
										<col width="10%"/>
										<col width="10%"/>
										<col width="*"/>
										<c:if test="${params.line_chk eq 'Y' }">
											<col width="15%"/>
										</c:if>
									</colgroup>
									<thead>
										<tr role="row">
											<th class="sorting_asc" tabindex="0" aria-controls="dataTables-example"  aria-sort="ascending">결재담당</th>
					    					<c:if test="${params.line_chk eq 'N' }">
					    						<th class="sorting" tabindex="0" aria-controls="dataTables-example" >메일수신</th>
					    					</c:if>
											<th class="sorting" tabindex="0" aria-controls="dataTables-example" >확인여부</th>
											<th class="sorting" tabindex="0" aria-controls="dataTables-example" >결재순서</th>
											<th class="sorting" tabindex="0" aria-controls="dataTables-example" >결재상태</th>
											<th class="sorting" tabindex="0" aria-controls="dataTables-example">내용</th>
											<c:if test="${params.line_chk eq 'Y' }">
												<th class="sorting" tabindex="0" aria-controls="dataTables-example">비고</th>
											</c:if>
										</tr>
									</thead>
									<tbody>
										<c:choose>
											<c:when test="${params.line_chk eq 'N' }">
												<!-- 결재 권한이 없는 경우 -->
												<!-- 결재 신청한 경우 -->
												<c:forEach var="line" items="${lineList }" varStatus="status">
													<tr class="gradeA odd" role="row">
														<td class="sorting_1">
								    						${line.USS_NM }
									    					<c:if test="${line.REFE_YN eq 'Y' }">
									    						(참조인)
									    					</c:if>
														</td>
														<td>
									    					<c:choose>
									    						<c:when test="${ line.RECE_YN eq '1' }">
									    							확인
									    						</c:when>
									    						<c:otherwise>
									    							미확인
									    						</c:otherwise>
									    					</c:choose>
														</td>

														<td>
											    			<c:if test="${line.CONF_YN eq 'Y' }" >
									    						확인
											    			</c:if>
											    			<c:if test="${line.CONF_YN eq 'N' }" >
									    						미확인
											    			</c:if>
														</td>
														<td>${line.APRV_ORDR }</td>
														<td class="center">
									    					<c:if test="${line.REFE_YN ne 'Y' }">
										    						${line.APRV_YN_NM }
										    				</c:if>
														</td>
														<td class="center">${line.APRV_CONT }</td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<!-- 결재 권한이 있는 경우 -->
												<!-- 결재 일경우 -->
												<!-- 수정 폼일경우 -->
												<c:set var="old_aprv" value="1" /> <!-- 진행관련 정보 이전 결재자가 결재를 했는지에 대한 구분정보 -->
												<c:forEach var="line" items="${lineList }" varStatus="status">
													<c:choose>
														<c:when test="${line.APRV_EMP_NO eq loginVO.id && (line.APRV_YN_CD eq '0' || line.APRV_YN_CD eq '2') && old_aprv eq '1' && line.REFE_YN ne 'Y'}">
															<tr class="gradeA odd" role="row">
																<td class="sorting_1">
										    						${line.USS_NM }
											    					<c:if test="${line.REFE_YN eq 'Y' }">
											    						(참조인)
											    					</c:if>
																</td>
																<td>
											    					<c:choose>
											    						<c:when test="${ line.RECE_YN eq '1' }">
											    							확인
											    						</c:when>
											    						<c:otherwise>
											    							미확인
											    						</c:otherwise>
											    					</c:choose>
																</td>
																<td>
													    			<c:if test="${line.CONF_YN eq 'Y' }" >
											    						확인
													    			</c:if>
													    			<c:if test="${line.CONF_YN eq 'N' }" >
											    						미확인
													    			</c:if>
																</td>
																<td>
											    					<c:if test="${line.REFE_YN ne 'Y' }">
												    						${line.APRV_YN_NM }
												    				</c:if>
																</td>
																<td class="center">${line.APRV_CONT }</td>
															</tr>	
														</c:when>
														<c:otherwise>
															<tr class="gradeA odd" role="row">
																<td class="sorting_1">
											    					${line.USS_NM }
											    					<c:if test="${line.REFE_YN eq 'Y' }">
											    						(참조인)
											    					</c:if>
																</td>
																<td>
													    			<c:if test="${line.CONF_YN eq 'Y' }" >
												    						확인
													    			</c:if>
													    			<c:if test="${line.CONF_YN eq 'N' }" >
												    						미확인
													    			</c:if>
																</td>
																<td>${line.APRV_ORDR }</td>
																<td>
												    				<c:if test="${line.REFE_YN ne 'Y' }">
												    						${line.APRV_YN_NM }
												    				</c:if>
																</td>
																<td class="center">${line.APRV_CONT }</td>
																<td class="center"></td>
															</tr>
														</c:otherwise>
													</c:choose>
													<c:set var="old_aprv" value="${line.APRV_YN_CD }" />
												</c:forEach>
											</c:otherwise>
										</c:choose>								
									</tbody>
								</table>
							</dd>
						</dl>
					</div>
					<p class="row">
					<span class="pull-right">
						<c:if test="${viewMap.REPT_APRV_NO eq loginVO.id && viewMap.APRV_LINE_CD eq '0' && viewMap.CONF_TYPE eq 'N' }">
							<input type="button" id="btn-ok" class="btn btn-warning" value="수정"/>
							<input type="button" id="btn-delete" class="btn btn-default " value="삭제" onclick="javascript:self.location='index.html'"/>
						</c:if>
						<c:if test="${viewMap.REPT_APRV_NO eq loginVO.id && viewMap.APRV_LINE_CD eq '3' }">
							<input type="button" id="btn-ok" class="btn btn-warning" value="재결제"/>
						</c:if>
							<input type="button" id="btn-cancel" class="btn btn-default" value="목록" />
					</span>
				</p>
				</div>
				</form>
			</div>
			<jsp:include page="/resources/com/inc/aside.jsp" />
			</div>
		</div>
		<jsp:include page="/resources/com/inc/footer.jsp" />
<form id="ussFrm" name="ussFrm" method="post" action="${pageContext.request.contextPath}/uss/umt/uss00Popup.do" >
</form>
<!-- 파일 다운로드 form Start -->
<form id="downFrm" name="downFrm" method="post" action="${pageContext.request.contextPath}/cmm/FileDown.do">
	<input type="hidden" name="file_path" id="file_path" value="" /><!-- 파일위치 -->
	<input type="hidden" name="file_stre_nm" id="file_stre_nm" value="" /><!-- 저장된파일명 -->
	<input type="hidden" name="file_nm" id="file_nm" value="" /><!-- 원문파일명 -->
</form>
<!-- 파일 다운로드 form End -->

<!-- js파일 및 공통스크립트사용 -->
<jsp:include page="/resources/com/inc/javascript.jsp" />

<script type="text/javascript">
$(document).ready(function() {
	/* 수정 */	
	$( "#btn-ok" ).click(function() {
		$("#frm1").attr("action", "${pageContext.request.contextPath}/aprv/aprv00Form.do");
		$("#frm1").submit();
	});
	/* 삭제 */
	$( "#btn-delete" ).click(function() {
		if (confirm("삭제하시겠습니까?")) {
			
			$("#mode").val("<%=VarConsts.MODE_D%>");
			var aprv_no = $("#aprv_no").val();
			
			$.ajax({
				url: "${pageContext.request.contextPath}/aprv/aprv01Tran.do",
				type: "post",
				dataType : "json", 
				data : {"aprv_no":aprv_no},
				success: function(result){
					var url_val = "";
					if($("#mode").val() == "<%=VarConsts.MODE_D%>"){
						alert("결재정보가 삭제되었습니다.");
						url_val = "${pageContext.request.contextPath}/aprv/aprv00List.do";
					}
					$("#frm1").attr("action", url_val);
					$("#frm1").submit();
				},error: function (request, status, error) {
					alert(request.responseText);
				} 
			});
		}
	});
	/* 취소 */
	$( "#btn-cancel" ).click(function() {
		$("#frm1").attr("action", "${pageContext.request.contextPath}/aprv/aprv00List.do");
		$("#frm1").submit();
	});
});

/* 파일 다운로드 */
function fn_downFile(file_path, file_stre_nm, file_nm){
	$("#file_path").val(file_path);
	$("#file_stre_nm").val(file_stre_nm);
	$("#file_nm").val(file_nm);
	$("#downFrm").submit();
}

function aprvOk(){
	var aprv_no = $("#aprv_no").val();
	var varText = $("#aprv_yn_cd option:selected").text();
	var aprv_yn_cd = $("#aprv_yn_cd option:selected").val();
	if(aprv_yn_cd == '2' || aprv_yn_cd == '3'){
		if($("#aprv_cont").val() == ""){
			alert(varText+" 일경우 내용을 입력해 주세요");
			$("#aprv_cont").focus();
			return false;
		}
	}
	$.ajax({
		url: "${pageContext.request.contextPath}/aprv/aprv02Tran.do",
		type: "post",
		dataType : "json", 
		data : $("#frm1").serialize(),
		success: function(result){
			var url_val = "";
			alert("결재 "+varText+" 되었습니다.");
			$("#frm1").attr("action", "${pageContext.request.contextPath}/aprv/aprv00View.do");
			$("#frm1").submit();
		},error: function (request, status, error) {
			alert(request.responseText);
		} 
	});
}

</script>
</body>
</html>