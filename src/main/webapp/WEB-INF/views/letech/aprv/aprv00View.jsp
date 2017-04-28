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
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.print.css' rel='stylesheet' media='print' />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
</head>

<body>
<div id="wrapper">
 	<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
		<jsp:include page="/resources/com/inc/header.jsp" />
		<jsp:include page="/WEB-INF/views/letech/com/layout/menu.jsp" />
	</nav>

	<div id="page-wrapper">
		<div class="row">
			<section class="row">
			
				<!-- 타이틀 및 페이지 네비 -->
				<!-- page -->
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
					<div class="col-lg-10">
						<h2 class="page-title clearfix">
							${titleNaviMap.MN_NM }
							<span class="pull-right site-map">
								HOME > ${titleNaviMap.NAVI_NM }
							</span>
						</h2>
						<div class="form-container">
						<div class="board-view">		 
						<ul class="payment-form">
					      	<li>
					      		<dl class="clearfix">
						          	<dt class="col-md-2 col-sm-3">보고자</dt>
						          	<dd class="col-md-10 col-sm-9">
										${viewMap.REPT_APRV_NM }
									</dd>
					      		</dl>
					            </li>
					      		<li>
					            <dl class="clearfix">
						          	<dt class="col-md-2 col-sm-3">소속</dt>
						          	<dd class="col-md-10 col-sm-9">
										${viewMap.DPNM }
									</dd>
					            </dl>
					            </li>
					            <li>
					            <dl class="clearfix">
						          	<dt class="col-md-2 col-sm-3">프로젝트</dt>
						          	<dd class="col-md-10 col-sm-9">
										<c:forEach var="proj" items="${projList }" varStatus="status">
											<c:if test="${proj.CD eq viewMap.PROJ_CD }">
																		${proj.CD_NM }
											</c:if>
										</c:forEach>
						            </dd>
					            </dl>
					            </li>
					      		<li>
					      		<dl class="clearfix">
						          	<dt class="col-md-2 col-sm-3">결제구분</dt>
						          	<dd class="col-md-10 col-sm-9">
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
					            <dl class="clearfix">
						          	<dt class="col-md-2 col-sm-3">제목</dt>
						          	<dd class="col-md-10 col-sm-9">
										${viewMap.TITLE }
						            </dd>
					            </dl>
					            </li>
					            <li>
					            	<dl class="clearfix">
						          	<dt class="col-md-2 col-sm-3">기간</dt>
						          	<dd class="col-md-10 col-sm-9">
									    ${viewMap.TERM_ST_YM } ~ ${viewMap.TERM_ED_YM }
						            </dd>
					            	</dl>
					            </li>
					            <li>
					            	<dl class="clearfix">
						          	<dt class="col-md-2 col-sm-3">행선지</dt>
						          	<dd class="col-md-10 col-sm-9">
										${viewMap.PLACE }
						            </dd>
					            	</dl>
					            </li>
					            <li>
					            	<dl class="clearfix">
						          	<dt class="col-md-2 col-sm-3">보고내용</dt>
						          	<td>
						          		${viewMap.REPT_CONT }
						            </dd>
					            	</dl>
					            </li>
					            <li>
					            	<dl class="clearfix">
						          	<dt class="col-md-2 col-sm-3">첨부파일</dt>
						          	<dd class="col-md-10 col-sm-9">
										<c:forEach var="file" items="${fileList }" varStatus="status">
																		<div id="file_${file.FILE_NO }"><a href="#" onclick="fn_downFile('${file.FILE_PATH}', '${file.FILE_STRE_NM }', '${file.FILE_NM }')">${file.FILE_NM }</a></div>
										</c:forEach>
						            </dd>
					            	</dl>
					            </li>
					            <li>
					            	<div class="clearfix">
					            	<dl class="panel panel-default" style="padding:0;">
						          	<dt class="panel-heading" >결재라인</dt>
						          	<dd class="panel-body">
						          		<c:set var="lineVar" value="1" />
						          		<c:if test="${fn:length(lineList) > 0 }">
						          			<c:set var="lineVar" value="${fn:length(lineList) }" />
						          		</c:if>
						    			<input type="hidden" name="aprv_line_cnt" id="aprv_line_cnt" value="${lineVar }">
						    			<div class="table-responsive">
						    			<table id="aprv_line" name="aprv_line" class="table table-bordered">
						    				<colgroup>
						    					<col width="18%" />
						    					<c:if test="${params.line_chk eq 'N' }">
						    						<col width="10%" />
						    					</c:if>
						    					<col width="10%" />
						    					<col width="10%" />
						    					<col width="15%" />
						    					<col width="*" />
												<c:if test="${params.line_chk eq 'Y' }">
						    						<col width="15%" />
												</c:if>
						    				</colgroup>
						    				
						    				<thead class="table_s" >
							    				<tr>
							    					<th>결재담당</th>
							    					<c:if test="${params.line_chk eq 'N' }">
							    						<th>메일수신</th>
							    					</c:if>
							    					<th>확인</th>
							    					<th>순서</th>
							    					<th>상태</th>
							    					<th>내용</th>
													<c:if test="${params.line_chk eq 'Y' }">
														<th>비고</th>
													</c:if>
							    				</tr>
						    				</thead>
						    				<tbody class="table_s">
											<c:choose>
												<c:when test="${params.line_chk eq 'N' }">
													<!-- 결재 권한이 없는 경우 -->
													<!-- 결재 신청한 경우 -->
													<c:forEach var="line" items="${lineList }" varStatus="status">
										    				<tr class="table_s" onMouseOver="aprv_line.clickedRowIndex=this.rowIndex">
										    					<td>
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
										    					<td>
									    					<c:if test="${line.REFE_YN ne 'Y' }">
										    						${line.APRV_YN_NM }
										    				</c:if>
										    					</td>
										    					<td>${line.APRV_CONT }</td>
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
																<!-- 결재자 일경우 이면서 대기, 보류일경우 -->
											    				<tr onMouseOver="aprv_line.clickedRowIndex=this.rowIndex">
											    					<td>
											    						${line.USS_NM }
											    						<input name="aprv_emp_no" id="aprv_emp_no" type="hidden" value="${line.APRV_EMP_NO }"/>
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
											    						<select id="aprv_yn_cd" name="aprv_yn_cd" class="form-control">
											    							<option value="0" <c:if test="${line.APRV_YN_CD eq '0' }">selected="selected"</c:if> >대기</option>
											    							<option value="1" <c:if test="${line.APRV_YN_CD eq '1' }">selected="selected"</c:if> >승인</option>
											    							<option value="2" <c:if test="${line.APRV_YN_CD eq '2' }">selected="selected"</c:if> >보류</option>
											    							<option value="3" <c:if test="${line.APRV_YN_CD eq '3' }">selected="selected"</c:if> >반려</option>
											    						</select>
											    					</td>
											    					<td class="fontLeft">
											    						<input type="text" id="aprv_cont" class="form-control" name="aprv_cont" value="${line.APRV_CONT }" />
											    					</td>
											    					<td>
								    									<input class="btn btn-default btn-sm"  type="button" value="결재" onClick="aprvOk()" />
											    					</td>
											    				</tr>
															</c:when>
															<c:otherwise>
															<!-- 결재자가 아닐경우 -->
											    				<tr class="table_s"  onMouseOver="aprv_line.clickedRowIndex=this.rowIndex">
											    					<td>${line.USS_NM }
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
											    					<td>${line.APRV_CONT }</td>
											    					<td></td>
											    				</tr>
														</c:otherwise>
													</c:choose>
													<c:set var="old_aprv" value="${line.APRV_YN_CD }" />
												</c:forEach>
											</c:otherwise>
										</c:choose>
											</tbody>
											</div>
							    			</table>
							            </dd>
						            </dl>
							    	</div>
				            	</li>
							</ul>
							<p class="clearfix">
								<span class="pull-right">
								<c:if test="${viewMap.REPT_APRV_NO eq loginVO.id && viewMap.APRV_LINE_CD eq '0' && viewMap.CONF_TYPE eq 'N' }">
					   	 			<input class="btn btn-sm btn-warning" type="button" id="btn-ok" value="수정" />
					   			 <input class="btn btn-sm btn-warning"  type="button" id="btn-delete" value="삭제" />
								</c:if>
								<c:if test="${viewMap.REPT_APRV_NO eq loginVO.id && viewMap.APRV_LINE_CD eq '3' }">
									<input class="btn btn-sm btn-warning" type="button" id="btn-ok" value="재결재" />
								</c:if>
								</span>
						   		 <input class="btn btn-sm btn-default"  type="button" id="btn-cancel" value="목록" />
							</p>
						</div>
					</div>
				</form>
					
				</div>
				<div >
				<jsp:include page="/resources/com/inc/aside.jsp" />
			</section>
	
		</div>
	</div>
			<jsp:include page="/resources/com/inc/footer.jsp" />
</div>

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