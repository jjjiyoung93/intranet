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
		<%-- <jsp:include page="/WEB-INF/views/letech/com/layout/menu.jsp" /> --%>
		<%@ include file="/WEB-INF/views/letech/com/layout/menu.jsp" %>
	    <div class="container">
	   	 	<jsp:include page="/resources/com/inc/aside.jsp" />
			<section class="contents">
			<form name="form1" id="form1" method="post" action="<%=request.getContextPath()%>/sys/rol/rol00List.do" >
				<input type="hidden" id="mode" name="mode" />
				<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}"/>
				<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}"/>
				<input type="hidden" id="menu_id3" name="menu_id3" value="${params.menu_id3}"/>
				<input type="hidden" id="role_code" name="role_code" value=""  /> 
				<input type="hidden" id="author_code" name="author_code" value=""  /> 
				<input type="hidden" id="flag" name="flag" value="" /> 
			<h2 class="sub_title">
				${titleNaviMap.MN_NM }
				<span class="page_navi full-right">HOME > ${titleNaviMap.NAVI_NM }</span>
			</h2>
<%-- 
				<c:if test="${mnList3 ne null}">
					<article>
						<ul class="tab_gnb">
							<c:forEach var="list3" items="${mnList3}" varStatus="status">
								<c:if test="${params.menu_id2 eq list3.UP_MN}">
									<li class="<c:if test="${params.menu_id3 eq list3.MN}">on </c:if>">
										<a href="javascript:fnTabMove('${list3.MN_HREF}','${list3.MN}')">${list3.MN_NM}</a>
									</li>
								</c:if>
							</c:forEach>
						</ul>
			   		</article>
				</c:if>
 --%>
		<!-- page -->
		<article>
			
			<p class="full-right">
				<a href="#" class="btn btn_info" onclick="fnInsert();">패턴추가</a>
			</p>
			<!-- 테이블 -->
			<table cellpadding="0" cellspacing="0" class="">
				<caption>메뉴관리</caption>
				<colgroup>
					<col width="10%"  />
					<col width="10%"  />
					<col width="20%"  />
					<col width="30%"  />
					<col width="5%"  />
					<col width="5%"  />
					<col width="10%"  />
					<col width="10%"  />
				</colgroup>
				<thead>
					<tr>
						<th>메뉴권한코드</th>
						<th>메뉴권한명</th>
						<th>접속패턴</th>
						<th>메뉴권한설명</th>
						<th>타입</th>
						<th>접근<br />순서</th>
						<th>생성일</th>
						<th>수정</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${highList eq null }">
							<tr>
								<th colspan="8">
									등록된 롤이 없습니다.
								</th>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="highList" items="${highList }">
								<tr>
									<td>
										${highList.ROLE_CODE }
									</td>								
									<td>
										<a href="#" onclick="goTwoList('${highList.ROLE_CODE }');">${highList.ROLE_NM }</a>
									</td>								
									<td>
										${highList.ROLE_PTTRN }
									</td>								
									<td>
										${highList.ROLE_DC }
									</td>								
									<td>
										${highList.ROLE_TY }
									</td>								
									<td>
										${highList.ROLE_SORT }
									</td>								
									<td>
										${highList.ROLE_CREAT_DE }
									</td>								
									<td>
<%-- 											<a href="#" class="btn_s btn_basic" onclick="fnRoleInsert('${highList.ROLE_CODE}');">접근롤추가</a> --%>
											<a href="#" class="btn_s btn_basic" onclick="fnModify('${highList.ROLE_CODE}');">수정</a>
											<a href="#" class="btn_s btn_basic" onclick="fnDelete('<%=VarConsts.MODE_DA%>','${highList.ROLE_CODE}','1','');">삭제</a>
									</td>
								</tr>
							</c:forEach>					
						</c:otherwise>
					</c:choose>
					
					
				</tbody>
			</table>
			<!-- page nav -->
		</article>
		<article>
			
			<p class="full-left">
				권한 정보
			</p>
<c:if test="${not empty resultList }">
			<p class="full-right">
				<a href="#" class="btn btn_info" onclick="fnRoleInsert('${params.role_code }');">권한추가</a>
			</p>
</c:if>
			<!-- 테이블 -->
			<table cellpadding="0" cellspacing="0" class="">
				<caption>메뉴관리</caption>
				<colgroup>
					<col width="15%"  />
					<col width="20%"  />
					<col width="55%"  />
					<col width="10%"  />
				</colgroup>
				<thead>
					<tr>
						<th>메뉴권한코드</th>
						<th>부모권한코드</th>
						<th>자식권한코드</th>
						<th>비고</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${resultList eq null }">
							<tr>
								<th colspan="4">
									등록된 롤이 없습니다.
								</th>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="result" items="${resultList }">
								<tr>
									<th>
										${params.role_code }
									</th>								
									<th>
										${result.UP_CD }
									</th>								
									<th>
										${result.CHLDRN_ROLE }
									</th>								
									<td >
										<a href="#" class="btn_s btn_basic" onclick="fnDelete('<%=VarConsts.MODE_D%>','${params.role_code }','2','${result.UP_CD }');">권한삭제</a>
									</td>
								</tr>
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
	document.form1.submit();
}


/*********************************************************************************
* function명   : fnList
* function기능 : 페이지 새로 고침
**********************************************************************************/
function fnList(){
	document.form1.submit();
}

function goTwoList(role_code){
	$("#role_code").val(role_code);
	$("#form1").submit();
}

/*********************************************************************************
* function명   : fnTabMove
* function기능 : 탭이동
**********************************************************************************/
function fnTabMove(href,pm1){
	document.form1.action = "<%=request.getContextPath() %>/"+href;
	document.form1.menu_id3.value = pm1;
	document.form1.submit();
}

/*********************************************************************************
* function명   : fnInsert(코드)
* function기능 : 코드 추가
**********************************************************************************/
function fnInsert(){
	//jQuery( ".pop_bg" ).fadeIn('slow');
	//jQuery( "#iframe" ).attr("src","<%=request.getContextPath() %>/sys/cdm/form.do?flag=1&cd=");
	
	window.open('rol00Form.do?flag=1','target_name','scrollbars=yes,toolbar=yes,resizable=yes,width=500,height=400,left=0,top=0');
	
}


/*********************************************************************************
* function명   : fnLowInsert(코드)
* function기능 : 하위코드 추가
**********************************************************************************/
function fnRoleInsert(cd){
	window.open('rol00Form2.do?flag=2&role_code='+cd,'target_name','scrollbars=yes,toolbar=yes,resizable=yes,width=500,height=300,left=0,top=0');
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
	window.open('rol00Form.do?flag=3&role_code='+cd,'target_name','scrollbars=yes,toolbar=yes,resizable=yes,width=500,height=400,left=0,top=0');
}

/*********************************************************************************
* function명   : fnDelete(코드)
* function기능 : 코드 삭제 
**********************************************************************************/
function fnDelete(mode,cd,flag,author_code){
	document.form1.role_code.value = cd;
	document.form1.author_code.value = author_code;
	document.form1.mode.value = mode;
	document.form1.flag.value = flag;
	if(flag == '1'){
		if(confirm('하위롤도 모두 삭제됩니다. 삭제하시겠습니까?')){
			document.form1.action = "<%=request.getContextPath() %>/sys/rol/rol00Tran.do";
			document.form1.submit();
		}
	}else{		
		if(confirm('권한 삭제는 신중히 확인 후 하세요. \r\n 삭제하시겠습니까?')){
			document.form1.action = "<%=request.getContextPath() %>/sys/rol/rol00Tran.do";
			document.form1.submit();
		}
	}
}

</script>
</body>
</html>