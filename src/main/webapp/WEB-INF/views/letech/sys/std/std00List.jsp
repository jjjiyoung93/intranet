<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
		<div id="page-wrapper">
			<section class="row">
				<div class="col-lg-10">
			<form name="form1" id="form1" method="post" action="<%=request.getContextPath()%>/sys/std/std00List.do" >
				<input type="hidden" id="mode" name="mode" />
				<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}"/>
				<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}"/>
				<input type="hidden" id="std_id" name="std_id" value=""  /> 
				<input type="hidden" id="flag" name="flag" value="" /> 

				<!-- 타이틀 및 페이지 네비 -->
					<h2 class="page-title clearfix">
						${titleNaviMap.MN_NM }
						<span class="pull-right site-map">
							HOME > ${titleNaviMap.NAVI_NM }
						</span>
					</h2>
		<!-- page -->
				<div class="form-container">
				<p class="clearfix">
					<span class="pull-right">
						<a href="#" class="btn btn-sm btn-info" onclick="fnInsert();">여비정보추가</a>
					</span>
				</p>
				
			<div class="table-responsive">
			<!-- 테이블 -->
			<table class="table table-bordered">
				<caption>여비정보관리</caption>
				<colgroup>
					<col width="25%"  />
					<col width="25%"  />
					<col width="25%"  />
					<col width="25%"  />
				</colgroup>
				<thead>
					<tr>
						<th>그룹명</th>
						<th>그룹코드</th>
						<th>금액</th>
						<th>수정</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty highList}">
							<tr>
								<th colspan="3">
									등록된 여비정보가 없습니다.
								</th>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="highList" items="${highList }">
								<tr id="${highList.GROUP_CD}">
									<td align="left">
										${highList.GROUP_NM }
									</td>								
									<td align="center">
										${highList.GROUP_CD }
									</td>								
									<td align="right">
										<fmt:formatNumber value="${highList.TRVCT}" pattern="#,###원"/>
									</td>	
									<td align="center" >
											<a href="#" class="btn btn-xs btn-default btn-modify" onclick="fnModify('${highList.GROUP_CD}');">수정</a>
											<a href="#" class="btn btn-xs btn-default btn-delete" onclick="fnDelete('<%=VarConsts.MODE_D%>','${highList.GROUP_CD}');">삭제</a>
									</td>
								</tr>
							</c:forEach>					
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			<!-- page nav -->
		</div>
			<p class="clearfix">
					<span class="pull-right">
						<a href="#" class="btn btn-sm btn-info" onclick="fnInsert();">여비정보추가</a>
					</span>
				</p>
			<div class="pop_bg">
				<div class="popup" style="height:1px;">
					<a href="#" class="close" title="창닫기"></a>
			 		<iframe id="iframe" name="iframe" src="" frameborder="0" scrolling="no"></iframe>
				</div>
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

	var target = "${params.target}";
	var groupCd = "${params.group_cd}";

	
	
	if(target == '1'){
		if(groupCd != null && '' != groupCd) {
			$("#"+groupCd).find(".btn-modify").click();
		}
	}

	
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
	
	window.open('std00Form.do?flag=1','target_name','scrollbars=yes,toolbar=yes,resizable=yes,width=500,height=450,left=0,top=0');
	
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
	window.open('std00Form.do?flag=3&group_cd='+cd,'target_name','scrollbars=yes,toolbar=yes,resizable=yes,width=500,height=300,left=0,top=0');
}

/*********************************************************************************
* function명   : fnDelete(코드)
* function기능 : 코드 삭제 
**********************************************************************************/
function fnDelete(mode,cd){
	document.form1.std_id.value = cd;
	document.form1.mode.value = mode;
	if(confirm('연결된 데이터도 모두 삭제됩니다. \r\n삭제하시겠습니까?')){
		document.form1.action = "<%=request.getContextPath() %>/sys/std/std00Tran.do";
		document.form1.submit();
	}
}

</script>
</body>
</html>
				