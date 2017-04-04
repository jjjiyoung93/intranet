<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
	<title>Letech Intranet</title>
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
<form name="form1" id="form1" method="post" action="<%=request.getContextPath()%>/sys/mnm/mnm00List.do" >
	<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}"/>
	<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}"/>
	<input type="hidden" id="mode" name="mode" />
	<input type="hidden" name="mn" id="mn" value=""  /> 
	<input type="hidden" name="flag" id="flag" value="" /> 
	<input type="hidden" name="up_mn" id="up_mn" value="${params.up_mn }" /> 
	<input type="hidden" name="m_mn" id="m_mn" value=""  /> 
	<input type="hidden" name="up_mn2" id="up_mn2" value=""  /> 
	<input type="hidden" name="up_mn3" id="up_mn3" value=""  /> 

		<!-- 타이틀 및 페이지 네비 -->
		<article>
			<h2 class="sub_title">메뉴관리
				<span class="page_navi full-right"><span></span> > 사이트 > <strong>메뉴관리</strong></span>				
			</h2>
		</article>
		<!-- page -->
		<article>
				<a href="#" class="btn btn_info full-right"  onclick="fnInsert();">메뉴추가</a>
			<!-- 테이블 -->
			<table cellpadding="0" cellspacing="0" class="">
				<caption>메뉴관리</caption>
				<colgroup>
					<col width="7%"  />
					<col width="15%"  />
					<col width="7%"  />
					<col width="5%"  />
					<col width="7%"  />
					<col width="10%"  />
					<col width="*"  />
					<col width="5%"  />
					<col width="20%"  />
				</colgroup>
				<thead>
					<tr>
						<th>메뉴코드</th>
						<th>메뉴명</th>
						<th>메뉴타입</th>
						<th>레벨</th>
						<th>사용여부</th>
						<th>메뉴선택값</th>
						<th>메뉴URL</th>
						<th>메뉴순서</th>
						<th>메뉴수정</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${highList eq null }">
							<tr>
								<th colspan="8">
									등록된 메뉴가 없습니다.
								</th>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="highList" items="${highList }">
								<tr>
									<th onclick="selectCode('${highList.MN}')" style="cursor: pointer; text-align: center;">
										${highList.MN }
									</th>								
									<th onclick="selectCode('${highList.MN}')" style="cursor: pointer; text-align: center;">
										${highList.MN_NM }
									</th>								
									<th onclick="selectCode('${highList.MN}')" style="cursor: pointer; text-align: center;">
										${highList.MN_TYPE }
									</th>								
									<th onclick="selectCode('${highList.MN}')" style="cursor: pointer; text-align: center;">
										${highList.LEVL }
									</th>								
									<th onclick="selectCode('${highList.MN}')" style="cursor: pointer; text-align: center;">
										${highList.USE_YN }
									</th>								
									<th onclick="selectCode('${highList.MN}')" style="cursor: pointer; text-align: center;">
										${highList.MN_VAL }
									</th>								
									<th onclick="selectCode('${highList.MN}')" style="cursor: pointer; text-align: center;">
										${highList.MN_HREF }
									</th>								
									<th onclick="selectCode('${highList.MN}')" style="cursor: pointer; text-align: center;">
										${highList.MN_ORD }
									</th>								
									<td style="text-align: left;">
											<a href="#" class="btn_s btn_info" onclick="fnModify('${highList.MN}');">수정</a>
											<a href="#" class="btn_s btn_info" onclick="fnDelete('<%=VarConsts.MODE_DA%>','${highList.MN}','1');">삭제</a>
											<a href="#" class="btn_s btn_info" onclick="fnLowInsert('${highList.MN}');">하위추가</a>
									</td>
								</tr>
								<c:if test="${lowList ne null }">
									<c:forEach var="lowList" items="${lowList }">
										<c:if test="${highList.MN eq lowList.UP_MN }">
											<tr>
												<td onclick="selectCode2('${lowList.UP_MN}','${lowList.MN}')" style="cursor: pointer;text-align: left;" >
													<font style="margin-left: 40px;">${lowList.MN }</font>
												</td>
												<td onclick="selectCode2('${lowList.UP_MN}','${lowList.MN}')" style="cursor: pointer;text-align: left;" >
													<font style="margin-left: 40px;">${lowList.MN_NM }</font>
												</td>
												<td onclick="selectCode2('${lowList.UP_MN}','${lowList.MN}')" style="cursor: pointer;text-align: left;" >
													<font style="margin-left: 40px;">${lowList.MN_TYPE }</font>
												</td>
												<td onclick="selectCode2('${lowList.UP_MN}','${lowList.MN}')" style="cursor: pointer;text-align: left;" >
													<font style="margin-left: 40px;">${lowList.LEVL }</font>
												</td>
												<td onclick="selectCode2('${lowList.UP_MN}','${lowList.MN}')" style="cursor: pointer;text-align: left;" >
													<font style="margin-left: 40px;">${lowList.USE_YN }</font>
												</td>
												<td onclick="selectCode2('${lowList.UP_MN}','${lowList.MN}')" style="cursor: pointer;text-align: left;" >
													<font style="margin-left: 40px;">${lowList.MN_VAL }</font>
												</td>
												<td onclick="selectCode2('${lowList.UP_MN}','${lowList.MN}')" style="cursor: pointer;text-align: left;" >
													<font style="margin-left: 40px;">${lowList.MN_HREF }</font>
												</td>
												<td onclick="selectCode2('${lowList.UP_MN}','${lowList.MN}')" style="cursor: pointer;text-align: left;" >
													<font style="margin-left: 40px;">${lowList.MN_ORD }</font>
												</td>
												<td style="text-align: left;">
													<font style="margin-left: 20px;">
														<a href="#" class="btn_s btn_basic" onclick="fnModify('${lowList.MN}')">수정</a>
														<a href="#" class="btn_s btn_basic" onclick="fnDelete('<%=VarConsts.MODE_D%>','${lowList.MN}','2');">삭제</a>
														<a href="#" class="btn_s btn_basic" onclick="fnLowInsert('${lowList.MN}');">하위추가</a>
													</font>
												</td>
											</tr>
											<c:if test="${lowList2 ne null }">
												<c:forEach var="lowList2" items="${lowList2 }">
													<c:if test="${lowList.MN eq lowList2.UP_MN }">
														<tr>
															<td onclick="selectCode3('${lowList.MN}','${lowList2.MN}','${highList.MN }')" style="cursor: pointer;text-align: left;" >
																<font style="margin-left: 60px;">${lowList2.MN }</font>
															</td>
															<td onclick="selectCode3('${lowList.MN}','${lowList2.MN}','${highList.MN }')" style="cursor: pointer;text-align: left;" >
																<font style="margin-left: 60px;">${lowList2.MN_NM }</font>
															</td>
															<td onclick="selectCode3('${lowList.MN}','${lowList2.MN}','${highList.MN }')" style="cursor: pointer;text-align: left;" >
																<font style="margin-left: 60px;">${lowList2.MN_TYPE }</font>
															</td>
															<td onclick="selectCode3('${lowList.MN}','${lowList2.MN}','${highList.MN }')" style="cursor: pointer;text-align: left;" >
																<font style="margin-left: 60px;">${lowList2.LEVL }</font>
															</td>
															<td onclick="selectCode3('${lowList.MN}','${lowList2.MN}','${highList.MN }')" style="cursor: pointer;text-align: left;" >
																<font style="margin-left: 60px;">${lowList2.USE_YN }</font>
															</td>
															<td onclick="selectCode3('${lowList.MN}','${lowList2.MN}','${highList.MN }')" style="cursor: pointer;text-align: left;" >
																<font style="margin-left: 60px;">${lowList2.MN_VAL }</font>
															</td>
															<td onclick="selectCode3('${lowList.MN}','${lowList2.MN}','${highList.MN }')" style="cursor: pointer;text-align: left;" >
																<font style="margin-left: 60px;">${lowList2.MN_HREF }</font>
															</td>
															<td onclick="selectCode3('${lowList.MN}','${lowList2.MN}','${highList.MN }')" style="cursor: pointer;text-align: left;" >
																<font style="margin-left: 60px;">${lowList2.MN_ORD }</font>
															</td>
															<td style="text-align: left;"> 
																<font style="margin-left: 20px;">
																	<a href="#" class="btn_s btn_basic" onclick="fnModify('${lowList2.MN}')">수정</a>
																	<a href="#" class="btn_s btn_basic" onclick="fnDelete('<%=VarConsts.MODE_D%>','${lowList2.MN}','2');">삭제</a>
																	<a href="#" class="btn_s btn_basic" onclick="fnLowInsert('${lowList2.MN}');">하위추가</a>
																</font>
															</td>
														</tr>
														<c:if test="${lowList3 ne null }">
															<c:forEach var="lowList3" items="${lowList3 }">
																<c:if test="${lowList2.MN eq lowList3.UP_MN }">
																	<tr>
																		<td style="text-align: left;"> 
																			<font style="margin-left: 80px;">${lowList3.MN }</font>
																		</td>
																		<td style="text-align: left;">
																			<font style="margin-left: 80px;">${lowList3.MN_NM }</font>
																		</td>
																		<td style="text-align: left;">
																			<font style="margin-left: 80px;">${lowList3.MN_TYPE }</font>
																		</td>
																		<td style="text-align: left;">
																			<font style="margin-left: 80px;">${lowList3.LEVL }</font>
																		</td>
																		<td style="text-align: left;">
																			<font style="margin-left: 80px;">${lowList3.USE_YN }</font>
																		</td>
																		<td style="text-align: left;">
																			<font style="margin-left: 80px;">${lowList3.MN_VAL }</font>
																		</td>
																		<td style="text-align: left;">
																			<font style="margin-left: 80px;">${lowList3.MN_HREF }</font>
																		</td>
																		<td style="text-align: left;">
																			<font style="margin-left: 80px;">${lowList3.MN_ORD }</font>
																		</td>
																		<td style="text-align: left;"> 
																			<font style="margin-left: 20px;">
																				<a href="#" class="button-a" onclick="fnModify('${lowList3.MN}')">메뉴수정</a>
																				<a href="#" class="button-a" onclick="fnDelete('<%=VarConsts.MODE_D%>','${lowList3.MN}','2');">메뉴삭제</a>
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
			<!-- page nav -->
		</article>

	
	<div class="pop_bg">
		<div class="popup">
			<a href="#" class="close" title="창닫기"></a>
	 		<iframe id="iframe" name="iframe" src="" frameborder="0" scrolling="no"></iframe>
		</div>
	</div>
</form>
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
	document.form1.action = "<%=request.getContextPath() %>/sys/mnm/mnm00List.do";
	document.form1.submit();
}

/*********************************************************************************
* function명   : fnSelectCode(코드)
* function기능 : 2depth 코드검색
**********************************************************************************/
function selectCode(cd){
	document.form1.up_mn.value = cd;
	document.form1.submit();
}

/*********************************************************************************
* function명   : fnSelectCode2(코드)
* function기능 : 3depth 코드검색
**********************************************************************************/
function selectCode2(up_mn,cd){
	document.form1.up_mn.value = up_mn;
	document.form1.up_mn2.value = cd;
	document.form1.m_mn.value = '3dep';
	document.form1.submit();
}

/*********************************************************************************
* function명   : selectCode3(코드)
* function기능 : 4depth 코드검색
**********************************************************************************/
function selectCode3(up_mn,cd,high_mn){
	
	document.form1.up_mn.value = up_mn;
	document.form1.up_mn2.value = high_mn;
	document.form1.up_mn3.value = cd;
	document.form1.m_mn.value = '4dep';
	document.form1.submit();
}


/*********************************************************************************
* function명   : fnInsert(코드)
* function기능 : 코드 추가
**********************************************************************************/
function fnInsert(){
	//jQuery( ".pop_bg" ).fadeIn('slow');
	//jQuery( "#iframe" ).attr("src","<%=request.getContextPath() %>/sys/cdm/form.do?flag=1&cd=");
	
	window.open('mnm00Form.do?flag=1&mn=','target_name','scrollbars=yes,toolbar=yes,resizable=yes,width=500,height=300,left=0,top=0');
	
}


/*********************************************************************************
* function명   : fnLowInsert(코드)
* function기능 : 하위코드 추가
**********************************************************************************/
function fnLowInsert(cd){
	//jQuery( ".pop_bg" ).fadeIn('slow');
	//jQuery( "#iframe" ).attr("src","<%=request.getContextPath() %>/mng/sysMng/cmmCdMng/cmmCdMng00U.do?flag=2&cd="+cd);
	window.open('mnm00Form.do?flag=2&mn='+cd,'target_name','scrollbars=yes,toolbar=yes,resizable=yes,width=500,height=300,left=0,top=0');
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
	window.open('mnm00Form.do?flag=3&mn='+cd,'target_name','scrollbars=yes,toolbar=yes,resizable=yes,width=500,height=300,left=0,top=0');
}

/*********************************************************************************
* function명   : fnDelete(코드)
* function기능 : 코드 삭제 
**********************************************************************************/
function fnDelete(mode,cd,flag){
	document.form1.mn.value = cd;
	document.form1.mode.value = mode;
	document.form1.flag.value = flag;
	if(flag == '1'){
		if(confirm('하위코드도 모두 삭제됩니다. 삭제하시겠습니까?')){
			document.form1.action = "<%=request.getContextPath() %>/sys/mnm/mnm00Tran.do";
			document.form1.submit();
		}
	}else{		
		if(confirm('삭제하시겠습니까?')){
			document.form1.action = "<%=request.getContextPath() %>/sys/mnm/mnm00Tran.do";
			document.form1.submit();
		}
	}
}

</script>
</body>
</html>