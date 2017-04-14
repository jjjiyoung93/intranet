<%@ page contentType="text/html; charset=utf-8" language=	"java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
<jsp:include page="/resources/com/inc/meta.jsp" />
<title>Letech Intranet</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">

</head>
<body>
	<div id="warpper">
		<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
			<jsp:include page="/resources/com/inc/header.jsp" />
			<%@ include file="/WEB-INF/views/letech/com/layout/menu.jsp" %>
		</nav>
	  <div class="" id="page-wrapper">
			<section class="row">
				<div class="col-lg-10">
					<form name="form1" id="form1" method="post" action="<%=request.getContextPath()%>/sys/cdm/list.do" >
						<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}"/>
						<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}"/>
						<input type="hidden" id="mode" name="mode" />
						<input type="hidden" name="cd" id="cd" value=""  /> 
						<input type="hidden" name="flag" id="flag" value="" /> 
						<input type="hidden" name="up_cd" id="up_cd" value="${params.up_cd }" /> 
						<input type="hidden" name="m_cd" id="m_cd" value=""  /> 
						<input type="hidden" name="up_cd2" id="up_cd2" value=""  /> 
						<input type="hidden" name="up_cd3" id="up_cd3" value=""  /> 
						<!-- 타이틀 및 페이지 네비 -->
						<h4 class="title">${titleNaviMap.MN_NM }<span class="pull-right text-muted small">HOME > ${titleNaviMap.NAVI_NM }</span></h4>
						<!-- page -->
						<p class="clearfix">
							<span class="pull-right">
								<input type="button" class="button-a btn btn-warning" onclick="fnInsert();" value="코드추가">
							</span>
						</p>
						<!-- 테이블 -->
						<div class="table-responsive">
							<table class="table table-bordered">
								<caption>코드관리</caption>
								<colgroup>
									<col width="30%"  />
									<col width="30%"  />
									<col width="*"  />
								</colgroup>
								<thead class="ag_left">				
									<tr>
										<th>코드</th>
										<th>코드명(코드값)</th>
										<th>코드수정</th>
									</tr>
								</thead>
								<tbody class="ag_left">
									<c:choose>
										<c:when test="${highList eq null }">
											<tr>
												<th>
													등록된 코드가 없습니다.
												</th>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach var="highList" items="${highList }">
												<tr>
													<td onclick="selectCode('${highList.CD}')" >
												<c:choose>
													<c:when test="${highList.CD eq fn:substring(params.up_cd, 0, 6) }" >
														<font class="glyphicon glyphicon-minus-sign"> ${highList.CD }</font>
													</c:when>
													<c:otherwise>
														<font class="glyphicon glyphicon-plus-sign"> ${highList.CD }</font>
													</c:otherwise>
												</c:choose>
													</td>								
													<td onclick="selectCode('${highList.CD}')">
														<font>${highList.CD_NM}(${highList.CD_VAL})</font>
													</td>								
													<td>
														<span class="form-inline">
															<input type="button" class="button-a btn btn-xs btn-primary" onclick="fnModify('${highList.CD}');" value="코드수정"/>
															<input type="button" class="button-a btn btn-xs btn-primary" onclick="fnDelete('<%=VarConsts.MODE_DA%>','${highList.CD}','1');" value="코드삭제"/>
															<input type="button" class="button-a btn btn-xs btn-primary" onclick="fnLowInsert('${highList.CD}');" value="하위코드추가"/>
														</span>
													</td>
												</tr>
												<c:if test="${lowList ne null }">
													<c:forEach var="lowList" items="${lowList }">
														<c:if test="${highList.CD eq lowList.UP_CD }">
															<tr>
																<td class="list_tow" onclick="selectCode2('${lowList.UP_CD}','${lowList.CD}')" >	
															<c:choose>
																<c:when test="${lowList.CD eq fn:substring(params.up_cd, 0, 9) }" >
																	<img src="<%=request.getContextPath()%>/resources/images/layout/tree_tow.png" alt="검색"  ><span class="re_re"></span> <label class="glyphicon glyphicon-minus-sign"></label> ${lowList.CD }
																</c:when>
																<c:otherwise>
																	<span class="re_re"></span> <label class="glyphicon glyphicon-plus-sign"></label> ${lowList.CD }
																</c:otherwise>
															</c:choose>
																</td>
																<td class="list_tow" onclick="selectCode2('${lowList.UP_CD}','${lowList.CD}')"  >
																	<font>${lowList.CD_NM }(${lowList.CD_VAL })</font>
																</td>
																<td  class="list_tow">
																	<font>
																		<a href="#" class="btn-xs btn btn-info" onclick="fnModify('${lowList.CD}')">코드수정</a>
																		<a href="#" class="btn-xs btn btn-info" onclick="fnDelete('<%=VarConsts.MODE_D%>','${lowList.CD}','2');">코드삭제</a>
																		<a href="#" class="btn-xs btn btn-info" onclick="fnLowInsert('${lowList.CD}');">하위코드추가</a>
																	</font>
																</td>
															</tr>
															<c:if test="${lowList2 ne null }">
																<c:forEach var="lowList2" items="${lowList2 }">
																	<c:if test="${lowList.CD eq lowList2.UP_CD }">
																		<tr>
																			<td class="list_three" onclick="selectCode3('${lowList.CD}','${lowList2.CD}','${highList.CD }')" >
																		<c:choose>
																			<c:when test="${lowList2.CD eq fn:substring(params.up_cd, 0, 12) }" >
																				<span class="re_re"></span> <label class="glyphicon glyphicon-minus-sign"></label> ${lowList2.CD }
																			</c:when>
																			<c:otherwise>
																				<span class="re_re"></span> <label class="glyphicon glyphicon-plus-sign"></label> ${lowList2.CD }
																			</c:otherwise>
																		</c:choose>
																			</td>
																			<td class="list_three"  onclick="selectCode3('${lowList.CD}','${lowList2.CD}','${highList.CD }')" >
																				<font>${lowList2.CD_NM }(${lowList2.CD_VAL })</font>
																			</td>
																			<td class="list_three" > 
																				<font>
																					<a href="#" class="btn btn-xs btn-default" onclick="fnModify('${lowList2.CD}')">코드수정</a>
																					<a href="#" class="btn btn-xs btn-default" onclick="fnDelete('<%=VarConsts.MODE_D%>','${lowList2.CD}','2');">코드삭제</a>
																					<a href="#" class="btn btn-xs btn-default" onclick="fnLowInsert('${lowList2.CD}');">하위코드추가</a>
																				</font>
																			</td>
																		</tr>
																		<c:if test="${lowList3 ne null }">
																			<c:forEach var="lowList3" items="${lowList3 }">
																				<c:if test="${lowList2.CD eq lowList3.UP_CD }">
																					<tr>
																						<td class="list_four"> 
																					<c:choose>
																						<c:when test="${lowList3.CD eq fn:substring(params.up_cd, 0, 15) }" >
																							<font ><span><img src="<%=request.getContextPath()%>/resources/images/layout/tree_tow.png" alt="검색"  > </span><i class="glyphicon glyphicon-plus-sign"></i> ${lowList3.CD }</font>
																						</c:when>
																						<c:otherwise>
																							<font ><span><img src="<%=request.getContextPath()%>/resources/images/layout/tree_tow.png" alt="검색"  > </span><i class="glyphicon glyphicon-minus-sign"></i> ${lowList3.CD }</font>
																						</c:otherwise>
																					</c:choose>
																						</td>
																						<td class="list_four">
																							<font>${lowList3.CD_NM }(${lowList3.CD_VAL })</font>
																						</td>
																						<td class="list_four"> 
																							<font>
																								<a href="#" class="btn btn-xs btn-default" onclick="fnModify('${lowList3.CD}')">코드수정</a>
																								<a href="#" class="btn btn-xs btn-default" onclick="fnDelete('<%=VarConsts.MODE_D%>','${lowList3.CD}','2');">코드삭제</a>
																							</font>
																						</td>
																					</tr>
																				</c:if>
																			</c:forEach>
																		</c:if>
																	</c:if>
																</c:forEach>
															</c:if>
														</c:if>
													</c:forEach>
												</c:if>
											</c:forEach>					
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
			<!-- page nav -->
							
						<div class="pop_bg">
							<div class="popup">
								<a href="#" class="close" title="창닫기"></a>
						 		<iframe id="iframe" name="iframe" src="" frameborder="0" scrolling="no"></iframe>
							</div>
						</div>
					</form>
				</div>
				<jsp:include page="/resources/com/inc/aside.jsp" />
			</section>
		</div>
	 <jsp:include page="/resources/com/inc/footer.jsp" />
	</div>

<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">


//코드폼 레이어 닫기(x)버튼 클릭시
jQuery(function() {	
	jQuery( ".close" ).click(
			function() {
			jQuery( ".pop_bg" ).fadeOut('slow');
			jQuery( "#iframe" ).attr("src","");
			}
	);
});

//코드폼 레이어 취소버튼 클릭시
function closeModal(){
	fnList();
	jQuery( ".pop_bg" ).fadeOut('slow');		
};


function fnGoJoin(){
	alert("이동");
	document.form1.submit();
}

/*********************************************************************************
* function명   : fnList
* function기능 : 공통코드목록페이지로 이동
**********************************************************************************/
function fnList(){
	document.form1.action = "<%=request.getContextPath() %>/sys/cdm/list.do";
	document.form1.submit();
}

/*********************************************************************************
* function명   : fnSelectCode(코드)
* function기능 : 2depth 코드검색
**********************************************************************************/
function selectCode(cd){
	document.form1.up_cd.value = cd;
	document.form1.submit();
}

/*********************************************************************************
* function명   : fnSelectCode2(코드)
* function기능 : 3depth 코드검색
**********************************************************************************/
function selectCode2(up_cd,cd){
	document.form1.up_cd.value = up_cd;
	document.form1.up_cd2.value = cd;
	document.form1.m_cd.value = '3dep';
	document.form1.submit();
}

/*********************************************************************************
* function명   : selectCode3(코드)
* function기능 : 4depth 코드검색
**********************************************************************************/
function selectCode3(up_cd,cd,high_cd){
	
	document.form1.up_cd.value = up_cd;
	document.form1.up_cd2.value = high_cd;
	document.form1.up_cd3.value = cd;
	document.form1.m_cd.value = '4dep';
	document.form1.submit();
}


/*********************************************************************************
* function명   : fnInsert(코드)
* function기능 : 코드 추가
**********************************************************************************/
function fnInsert(){
	//jQuery( ".pop_bg" ).fadeIn('slow');
	//jQuery( "#iframe" ).attr("src","<%=request.getContextPath() %>/sys/cdm/form.do?flag=1&cd=");
	
	window.open('form.do?flag=1&cd=','target_name','scrollbars=yes,toolbar=yes,resizable=yes,width=500,height=300,left=0,top=0');
	
}


/*********************************************************************************
* function명   : fnLowInsert(코드)
* function기능 : 하위코드 추가
**********************************************************************************/
function fnLowInsert(cd){
	//jQuery( ".pop_bg" ).fadeIn('slow');
	//jQuery( "#iframe" ).attr("src","<%=request.getContextPath() %>/mng/sysMng/cmmCdMng/cmmCdMng00U.do?flag=2&cd="+cd);
	window.open('form.do?flag=2&cd='+cd,'target_name','scrollbars=yes,toolbar=yes,resizable=yes,width=500,height=300,left=0,top=0');
}

/*********************************************************************************
* function명   : fnModify(코드)
* function기능 : 코드 수정 
**********************************************************************************/
function fnModify(cd){
	
	/* $(document).ready(function() {
		self.scrollTo(0,0);
	}); */
	//jQuery( ".pop_bg" ).fadeIn('slow');
	//jQuery( "#iframe" ).attr("src","<%=request.getContextPath() %>/mng/sysMng/cmmCdMng/cmmCdMng00U.do?flag=3&cd="+cd);
	window.open('form.do?flag=3&cd='+cd,'target_name','scrollbars=yes,toolbar=yes,resizable=yes,width=500,height=300,left=0,top=0');
}

/*********************************************************************************
* function명   : fnDelete(코드)
* function기능 : 코드 삭제 
**********************************************************************************/
function fnDelete(mode,cd,flag){
	document.form1.cd.value = cd;
	document.form1.mode.value = mode;
	document.form1.flag.value = flag;
	if(flag == '1'){
		if(confirm('하위코드도 모두 삭제됩니다. 삭제하시겠습니까?')){
			document.form1.action = "<%=request.getContextPath() %>/sys/cdm/tran.do";
			document.form1.submit();
		}
	}else{		
		if(confirm('삭제하시겠습니까?')){
			document.form1.action = "<%=request.getContextPath() %>/sys/cdm/tran.do";
			document.form1.submit();
		}
	}
}
</script>
</body>
</html>