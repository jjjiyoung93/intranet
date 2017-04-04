<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<div id="wrap">
	<jsp:include page="/resources/com/inc/header.jsp" />
    <%-- <jsp:include page="/resources/com/inc/menu.jsp" /> --%>
<%-- 	    <jsp:include page="/WEB-INF/views/letech/com/layout/menu.jsp" /> --%>
	<%@ include file="/WEB-INF/views/letech/com/layout/menu.jsp" %>
	    <div class="container">
	   	 	<jsp:include page="/resources/com/inc/aside.jsp" />
			<section class="contents">
				
				<!-- page -->
				<form name="frm1" id="frm1" method="post" action="${pageContext.request.contextPath}/aprv/aprv00List.do" >
					<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}" />
					<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}" />
					<input type="hidden" name="aprv_no" id="aprv_no" value="" />
					<input type="hidden" name="mode" id="mode" value="" />
					<input type="hidden" name="line_chk" id="line_chk" value="" />
					<input type="hidden" name="cPage" id="cPage" value="${cPage }" />
					<input type="hidden" name="conf_yn" id="conf_yn" value="" />
					<input type="hidden" name="conf_y_cnt" id="conf_y_cnt" value="" />
					
					<!-- 타이틀 및 페이지 네비 -->
					<h2 class="sub_title">
						${titleNaviMap.MN_NM }
						<span class="page_navi full-right">HOME > ${titleNaviMap.NAVI_NM }</span>
					</h2>
 
					<fieldset>
						<div class="col_md_12">
							<div class="col_md_7">
							결제구분코드:
							<select id="searchCdList1" name="searchCdList1" class="select_size100">
									<option value="" >--전체--</option>
								<c:forEach var="codeList" items="${codeList}">
									<option value="${codeList.CD}" <c:if test="${codeList.CD eq params.searchCdList1 }">selected="selected"</c:if> >${codeList.CD_NM}</option>
								</c:forEach>
							</select>
							확인여부:
							<select id="searchCdList2" name="searchCdList2" class="select_size100">
									<option value="" >--전쳬--</option>
									<option value="Y" <c:if test="${params.searchCdList2 eq 'Y' }">selected="selected"</c:if>>확인</option>
									<option value="N" <c:if test="${params.searchCdList2 eq 'N' }">selected="selected"</c:if> >미확인</option>
							</select>
<%-- 
							결재상태:
							<select id="searchCdList3" name="searchCdList3" class="select_size100">
									<option value="" >--전쳬--</option>
									<option value="1" <c:if test="${params.searchCdList3 eq '1' }">selected="selected"</c:if>>대기</option>
									<option value="9" <c:if test="${params.searchCdList3 eq '9' }">selected="selected"</c:if>>진행중</option>
									<option value="2" <c:if test="${params.searchCdList3 eq '2' }">selected="selected"</c:if>>완료</option>
									<option value="3" <c:if test="${params.searchCdList3 eq '3' }">selected="selected"</c:if>>보류</option>
									<option value="4" <c:if test="${params.searchCdList3 eq '4' }">selected="selected"</c:if>>반려</option>
							</select>
 --%>
							</div>
							<div class="full-right">
								<select name="searchGubun" id="searchGubun" class="" title="search" >
									<option value="01" <c:if test="${params.searchGubun == '01'}">selected = "selected"</c:if>>
									제목
									</option>
									<option value="02" <c:if test="${params.searchGubun == '02'}">selected = "selected"</c:if>>
									내용
									</option>
								</select>
								<input class="" type="text" name="searchField" id="searchField" value="${params.searchField}" title="검색어 입력" />
								<input class="fnSearch btn btn_default m_tow" type="button" onclick="goPage('1');" value="검색" title="검색" >
							</div>
						</div>
					</fieldset>
					<table  width="100%" cellspacing="0" cellpadding="0"  summary="결재관리 목록">
						<caption></caption>
						<colgroup>
							<col width="5%" />
							<col width="8%" />
							<col width="9%" />
							<col width="8%" />
							<col width="*" />
							<col width="22%" />
							<col width="12%" />
							<col width="10%" />
						</colgroup>
				        <thead>
				        	<tr>
								<th>번호</th>
								<th>보고자</th>
								<th>결재구분</th>
								<th>확인여부</th>
								<th>제목</th>
								<th>기간</th>
								<th>보고일자</th>
								<th>결재상태</th>
				            </tr>
				        </thead>
				        <tbody>
				        	<c:choose>
								<c:when test="${totalCnt < 1 }">
									<tr>
										<td colspan="8">
											검색된 내용이 없습니다.
										</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="list" items="${resultList}" varStatus="status">
										<tr>
											<td>
												${totalCnt - status.index - ((cPage-1) * (intListCnt))}
											</td>
											<td>
												${list.REPT_APRV_NM}
											</td>
											<td>
												${list.APRV_TYPE_NM}
											</td>
											<td>
										<c:choose>
											<c:when test="${list.CONF_YN eq 'Y' }">
												확인
											</c:when>
											<c:otherwise>
												미확인
											</c:otherwise>
										</c:choose>
											</td>
											<td>
												<a href="javascript:fnView('${list.APRV_NO}', '${list.LINE_CHK }', '${list.CONF_YN }', '${list.CONF_Y_CNT }');">
												${list.TITLE}
												</a>
											</td>
											<td>
												${list.TERM_ST_YM} - ${list.TERM_ED_YM}
											</td>
											<td>
												${list.CRTN_DT}
											</td>
											<td>
										<c:choose>
											<c:when test="${list.LINE_CHK eq 'N' && list.APRV_YN_TP eq '1' && list.CONF_Y_CNT > 0 && list.CONF_Y_CNT > list.CONF_REFE_CNT }">
												진행중
											</c:when>
											<c:otherwise>
												${list.APRV_YN_NM}
											</c:otherwise>
										</c:choose>
										<c:if test="${list.LINE_CHK eq 'Y' }">
											<c:choose>
												<c:when test="${list.REFE_YN eq 'Y' }">
												(참조)
												</c:when>
												<c:otherwise>
												<c:if test="${list.LINE_CHK eq 'Y' }">
													<c:choose>
														<c:when test="${list.APRV_ID eq params.uss_id }">
															<span style="color:red;">(결재)</span>
														</c:when>
														<c:otherwise>
															(결재)
														</c:otherwise>
													</c:choose>
												</c:if>
												</c:otherwise>
											</c:choose>
										</c:if>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
				        </tbody>
			        </table>
				<div class="table_foot2">
					<!-- pase nav-->
					<p class="page_nav" style="text-align: center;">
						<strong>${pageNavigator}</strong>
						<input type="button" value="등록" class="fnJoin btn btn_info full-right" />
					</p>
				</div>
			</form>
			</article>
		</section>
	</div>
	
	<jsp:include page="/resources/com/inc/footer.jsp" />
</div>
<!-- js파일 및 공통스크립트사용 -->
<jsp:include page="/resources/com/inc/javascript.jsp" />
<script type="text/javascript">

$(document).ready(function(){
// 	var optVal = $("#cdList1").val();
// 	if(optVal != ""){
// 		optionCreate(optVal);
// 	}

	/* 등록 */
	$(".fnJoin").click(function(){
		$("#frm1").attr("action", "${pageContext.request.contextPath}/aprv/aprv00Form.do");
		$("#frm1").submit();
	});

	//select box 선택 기능
// 	$("#cdList1").change(function(){
// 		optionCreate($(this).val());
// 	});
});

// select option 생성
function optionCreate(val){
	$("#cdList2").find('option').each(function(){
		$(this).remove();	
	});
	
	$("#cdList2").append("<option value=''>--선택--</option>");
	
	var selectVal = val; //$(this).val();
	
	if(selectVal != ""){
		$.ajax({
				type:'get',
				url:'/option/getCodeList.do?cd='+selectVal,
				dataType:'json',
				success: function(json){
					var data = json.codeList;
					if(data==null){
						data=0;
					}
					for(var i=0; i<data.length; i++){
						$("#cdList2").append("<option value='"+ data[i]['CD'] + "'>" + data[i]['CD_NM'] + "</option>");
					}
					$("#cdList2").val("${param.cdList2}").attr("selected", "selected");
				}
		});
	}
}

/* 글보기 */
function fnView(aprv_no, line_chk, conf_yn, conf_y_cnt){
	
	$("#aprv_no").val(aprv_no);
	$("#line_chk").val(line_chk);		// 결재 인지 아닌지 구분 (Y:결재, N:결재신청)
	$("#conf_yn").val(conf_yn);
	$("#conf_y_cnt").val(conf_y_cnt);
	$("#mode").val("<%=VarConsts.MODE_U%>");
	$("#frm1").attr("action", "${pageContext.request.contextPath}/aprv/aprv00View.do");
	$("#frm1").submit();	
}

function goPage(cPage){
	$("#cPage").val(cPage);
	$("#frm1").attr("action", "${pageContext.request.contextPath}/aprv/aprv00List.do");
	$("#frm1").submit();;
	
}

</script>
</body>
</html>