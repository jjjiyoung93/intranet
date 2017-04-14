<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
				<form name="frm1" id="frm1" method="post" action="${pageContext.request.contextPath}/aprv/aprv00List.do" >
					<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}" />
					<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}" />
					<input type="hidden" name="aprv_no" id="aprv_no" value="" />
					<input type="hidden" name="mode" id="mode" value="" />
					<input type="hidden" name="line_chk" id="line_chk" value="" />
					<input type="hidden" name="cPage" id="cPage" value="${cPage }" />
					<input type="hidden" name="conf_yn" id="conf_yn" value="" />
					<input type="hidden" name="conf_y_cnt" id="conf_y_cnt" value="" />
			
					<h4 class="title">
						${titleNaviMap.MN_NM }
						<span class="pull-right text-muted small">HOME > ${titleNaviMap.NAVI_NM }</span>
					</h4>
					<div class="row">
						<div class="col-lg-6">
							<div class="form-inline">
								<div class="form-group">
									<div class="input-group">
										<div class="input-group-addon">결제구분코드</div>
										<select id="searchCdList1" name="searchCdList1" class="form-control">
												<option value="" >--전체--</option>
											<c:forEach var="codeList" items="${codeList}">
												<option value="${codeList.CD}" <c:if test="${codeList.CD eq params.searchCdList1 }">selected="selected"</c:if> >${codeList.CD_NM}</option>
											</c:forEach>
										</select>
									</div>
								</div>
								<div class="form-group">
									<div class="input-group">
										<div class="input-group-addon">학인여부</div>
										<select id="searchCdList2" name="searchCdList2" class="form-control">
												<option value="" >--전쳬--</option>
												<option value="Y" <c:if test="${params.searchCdList2 eq 'Y' }">selected="selected"</c:if>>확인</option>
												<option value="N" <c:if test="${params.searchCdList2 eq 'N' }">selected="selected"</c:if> >미확인</option>
										</select>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-6">
							<div class="form-inline pull-right">
										<select name="searchGubun" id="searchGubun" class="form-control" title="search" >
											<option value="01" <c:if test="${params.searchGubun == '01'}">selected = "selected"</c:if>>
											제목
											</option>
											<option value="02" <c:if test="${params.searchGubun == '02'}">selected = "selected"</c:if>>
											내용
											</option>
										</select>

									<div class="input-group">
										<input class="form-control" type="text" name="searchField" id="searchField" value="${params.searchField}" title="검색어 입력" />
										<span class="input-group-btn">
											<button class="btn btn-default" type="button" onclick="goPage('1');"><i class="glyphicon glyphicon-search"></i>
											</button>
										</span>
									</div>
								</div>
								
						</div>
					</div>
					<table class="table table-striped table-bordered table-hover dataTable no-footer dtr-inline" id="dataTables-example" role="grid" aria-describedby="dataTables-example_info" style="width: 100%;">
						<colgroup>
							<col width="5%"/>
							<col width="10%"/>
							<col width="10%"/>
							<col width="10%"/>
							<col width="20%"/>
							<col width="*"/>
							<col width="15%"/>
							<col width="10%"/>
						</colgroup>
						<thead>
							<tr role="row">
								<th class="sorting_asc" tabindex="0" aria-controls="dataTables-example"  aria-sort="ascending">NO</th>
								<th class="sorting" tabindex="0" aria-controls="dataTables-example" >보고자</th>
								<th class="sorting" tabindex="0" aria-controls="dataTables-example" >결제구분</th>
								<th class="sorting" tabindex="0" aria-controls="dataTables-example" >확인여부</th>
								<th class="sorting" tabindex="0" aria-controls="dataTables-example">제 목</th>
								<th class="sorting" tabindex="0" aria-controls="dataTables-example">기간</th>
								<th class="sorting" tabindex="0" aria-controls="dataTables-example">보고일자</th>
								<th class="sorting" tabindex="0" aria-controls="dataTables-example">결제형태</th>
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
										<tr class="gradeA odd" role="row">
											<td class="sorting_1">
												${totalCnt - status.index - ((cPage-1) * (intListCnt))}
											</td>
											<td>
												${list.REPT_APRV_NM}
											</td>
											<td>
												${list.APRV_TYPE_NM}
											</td>
											<td class="center">
										<c:choose>
											<c:when test="${list.CONF_YN eq 'Y' }">
												확인
											</c:when>
											<c:otherwise>
												미확인
											</c:otherwise>
										</c:choose>
											</td>
											<td class="center">
												<a href="javascript:fnView('${list.APRV_NO}', '${list.LINE_CHK }', '${list.CONF_YN }', '${list.CONF_Y_CNT }');">
												${list.TITLE}
												</a>
											</td>
											<td class="center">
												${list.TERM_ST_YM} - ${list.TERM_ED_YM}
											</td>
											<td class="center">
												${list.CRTN_DT}
											</td>
											<td class="center">
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
					<p><span class="pull-right"><input type="button" id="fnJoin" name="fnJoin" class="btn btn-warning" value="글쓰기"/></span></p>
				</form>
			</div>
			<jsp:include page="/resources/com/inc/aside.jsp" />
			<div class="table_foot2">
				<!-- pase nav-->
				<p class="page_nav" style="text-align: center;">
					<strong>${pageNavigator}</strong>
				</p>
			</div>
		</div>
	</div>
</div>
<footer>
	<div class="container">
		<p>COPYRIGHT(C)2015 LE Tech CO.,LTD.ALL RIGHTS RESERVED.</p>
	</div>
</footer>
<script type="text/javascript">

$(document).ready(function(){
// 	var optVal = $("#cdList1").val();
// 	if(optVal != ""){
// 		optionCreate(optVal);
// 	}

	/* 등록 */
	$("#fnJoin").click(function(){
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