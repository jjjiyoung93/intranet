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
			<form name="form1" id="form1" method="post" action="<%=request.getContextPath()%>/sys/std/std02List.do" >
				<input type="hidden" id="mode" name="mode" />
				<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}"/>
				<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}"/>
				<input type="hidden" id="menu_id3" name="menu_id3" value="${params.menu_id3}"/>
				<input type="hidden" id="std_id" name="std_id" value="" /> 
				<input type="hidden" id="std_id2" name="std_id2" value="" /> 
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
						<a href="#" class="btn btn-sm btn-info" onclick="fnInsert();">추가</a>
					</span>
				</p>
				
			<div class="table-responsive">
			<!-- 테이블 -->
			<table class="table table-bordered">
				<caption>교통비 정보관리</caption>
				<colgroup>
					<col width="20%"  />
					<col width="20%"  />
					<col width="20%"  />
					<col width="20%"  />
					<col width="20%"  />
				</colgroup>
				<thead>
					<tr>
						<th>출발지(코드)</th>
						<th>도착지(코드)</th>
						<th>거리</th>
						<th>금액</th>
						<th>수정</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty codeList}">
							<tr>
								<th colspan="5">
									등록된 지역정보가 없습니다.
								</th>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="code" items="${codeList }" varStatus="status">
								<tr id="code-${status.index}" data-cnt="${code.CNT}">
									<td onclick="fn_addHighList(this, '${code.CD}')">
										<font class="glyphicon glyphicon-plus-sign plus">
											<span class = "code_nm"><c:out value="${code.CD_NM }"/></span>[<c:out value="${code.CD}"/>]
										</font>
									</td>								
									<td>
										
									</td>
									<td>
										<%-- <c:out value="${code.UP_CD}"/> --%>
										<%-- <fmt:formatNumber value="${highList.DSTNC}" pattern="# km"/> --%>
									</td>									
									<td>
										<%-- <c:out value="${code.CD_VAL}"/> --%>
										<%-- <fmt:formatNumber value="${highList.TRCS}" pattern="#,### 원"/> --%>
									</td>									
									<td class="text-center">
											<a class="btn btn-xs btn-default modifyBtn" onclick="fnModify('${code.CD}', '', this);">수정</a>
											<a class="btn btn-xs btn-default delBtn" onclick="fnDelete('<%=VarConsts.MODE_D%>','${code.CD}', '', this);">삭제</a>
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
						<a href="#" class="btn btn-sm btn-info" onclick="fnInsert();">추가</a>
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
	
	window.open('std02Form.do?flag=1','target_name','scrollbars=yes,toolbar=yes,resizable=yes,width=500,height=450,left=0,top=0');
	
}


/*********************************************************************************
* function명   : fnModify(코드)
* function기능 : 코드 수정 
**********************************************************************************/
function fnModify(cd, cd2, src){
	
	/* $(document).ready(function() {
		self.scrollTo(0,0);
	}); */
	//jQuery( ".pop_bg" ).fadeIn('slow');
	//jQuery( "#iframe" ).attr("src","<%=request.getContextPath() %>/mng/sysMng/cmmCdMng/cmmCdMng00U.do?flag=3&cd="+cd);
	var tr = $(src).parents("tr");
	var cnt = $(tr).data("cnt") * 1;	
	//alert(parents.length);
	
	if($(src).hasClass("modifyBtn")){
		if(cnt > 0){
			window.open('std02Form.do?flag=3&regn_cd1='+cd+'&regn_cd2='+cd2,'target_name','scrollbars=yes,toolbar=yes,resizable=yes,width=500,height=300,left=0,top=0');
		}else{
			alert("해당 지역코드에 등록된 교통비 정보가 없습니다. 교통비 정보를 먼저 등록해주세요");
		}
	}else {
		window.open('std02Form.do?flag=3&regn_cd1='+cd+'&regn_cd2='+cd2,'target_name','scrollbars=yes,toolbar=yes,resizable=yes,width=500,height=300,left=0,top=0');
	}

	
}

/*********************************************************************************
* function명   : fnDelete(코드)
* function기능 : 코드 삭제 
**********************************************************************************/
function fnDelete(mode,cd, cd2, src){
	document.form1.std_id.value = cd;
	document.form1.std_id2.value = cd2;
	document.form1.mode.value = mode;
	//alert(trcsList.length);
	var tr = $(src).parents("tr");
	var cnt = $(tr).data("cnt") * 1;

	if($(src).hasClass("delBtn")){
		if(cnt > 0){
			if(confirm('연관된 자료가 모두 삭제됩니다. \r\n 삭제는 신중히 확인 후 하세요. \r\n 삭제하시겠습니까?')){
				document.form1.action = "<%=request.getContextPath() %>/sys/std/std02Tran.do";
				document.form1.submit();
			}
		}else{
			alert("해당 지역코드에 등록된 교통비 정보가 없습니다. 교통비 정보를 먼저 등록해주세요");
		}
	}else {
		if(confirm('연관된 자료가 모두 삭제됩니다. \r\n 삭제는 신중히 확인 후 하세요. \r\n 삭제하시겠습니까?')){
			document.form1.action = "<%=request.getContextPath() %>/sys/std/std02Tran.do";
			document.form1.submit();
		}
	}
}

//하위리스트 추가
function fn_addHighList(src, upCd){
	var codeNm = $(src).find(".code_nm");
	var codeNmStr = $(codeNm).text();
	var dest = $(src).parent(); // tr
	var cnt = $(dest).data("cnt") * 1;
	var tbody = $(src).parents("tbody"); 
	var icon = $(dest).find(".glyphicon");
	//console.log($(icon));
	var trcsList = $(document).find(".trcsList");
	//console.log($(trcsList));
	$(trcsList).remove();
	
	if($(icon).hasClass("minus") == true){
		$(icon).removeClass("glyphicon-minus-sign").removeClass("minus");
		$(icon).addClass("glyphicon-plus-sign").addClass("plus");
	} else if($(icon).hasClass("plus") == true){
		$(icon).removeClass("glyphicon-plus-sign").removeClass("plus");
		$(icon).addClass("glyphicon-minus-sign").addClass("minus");
		//console.log(dest);
		$.ajax({
			url : "${pageContext.request.contextPath}/sys/std/std02List.do?regnCd="+upCd,
			method : "GET",
			async : false,
			success : function(data){
				var highList = data.highList;
				var html = "";

				if(highList.length == 0){
					var	cResult = false;
					cResult = confirm("해당 지역코드에 등록된 교통비 정보가 없습니다. 추가하시겠습니까?");
					if(cResult){
						window.open('std02Form.do?flag=1&code_nm='+codeNmStr,'target_name','scrollbars=yes,toolbar=yes,resizable=yes,width=500,height=450,left=0,top=0');
					}
					
				}else{
					for(var i = 0; i< highList.length; i++){
						var regn = highList[i];
						//console.log(regn);
						
						html +=	'<tr class="trcsList">'
						html +=	'<td style="padding-left: 50px;">'
						html +=			regn.REGN_NM1+'['+regn.REGN_CD1+']'
						html +=	'</td>'								
						html +=	'<td style="padding-left: 20px;">'
						html += regn.REGN_NM2+'['+regn.REGN_CD2+']'		
						html +=	'</td>'
						html +=	'<td style="text-align: right; vertical-align: middle; padding-right: 20px;">'
						html += regn.DSTNC_FORM+'km';		
						html +=	'</td>'
						html +=	'<td style="text-align: right; vertical-align: middle; padding-right: 20px;">'
						html += regn.TRCS_FORM+'원';		
						html +=	'</td>'
						html +=	'<td class="text-center">'
						html += '<a href="#" class="btn btn-xs btn-default" onclick="fnModify(\''+regn.REGN_CD1+'\', \''+regn.REGN_CD2+'\', this);">수정</a>'		
						html +=	'</td>'
						html += '</tr>'
					}		
					$(dest).after(html);

				}
				
			}
		})
	}

}

</script>
</body>
</html>
				