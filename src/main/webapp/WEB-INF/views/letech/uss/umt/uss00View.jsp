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
</head>

<body>
	<div id="wrap">
		<jsp:include page="/resources/com/inc/header.jsp" />
	    <%-- <jsp:include page="/resources/com/inc/menu.jsp" /> --%>
	    <jsp:include page="/WEB-INF/views/letech/com/layout/menu.jsp" />
		<%-- <%@ include file="../com/layout/menu.jsp" %> --%>
	    <div class="container">
	   	 	<jsp:include page="/resources/com/inc/aside.jsp" />
			<section class="contents">
				<!-- 타이틀 및 페이지 네비 -->
				<article>
					<h2 class="sub_title">
						${titleNaviMap.MN_NM }
						<span class="page_navi full-right">HOME > ${titleNaviMap.NAVI_NM }</span>
					</h2>
					
				</article>
				<br/>
				<!-- page -->
				<article>
			
			
<form name="frm1" id="frm1" method="post" action="${pageContext.request.contextPath}/uss/umt/uss01Form.do" >
	<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}"/>
	<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}"/>
	<input type="hidden" name="uss_id" id="uss_id" value="${params.uss_id }" />
	<input type="hidden" id="mode" name="mode" value="" />
					<table cellpadding="0" cellspacing="0" class="table_info">
						<colgroup>
							<col width="20%"/>
							<col width="*"/>
						</colgroup>
				     	<tbody>
				      		<tr>
					          	<th>사용자 ID</th>
					          	<td style="text-align: left;height: 20px;">${resultView.USS_ID }</td>
				            </tr>
				            <tr>
					          	<th>부서</th>
					          	<td style="text-align: left;height: 20px;">
									${resultView.DP_NM }
					            </td>
				            </tr>				            
				            <tr>
					          	<th>성명</th>
					          	<td style="text-align: left;height: 20px;">
									${resultView.USS_NM }
					            </td>
				            </tr>
				            <tr>
					          	<th>생년월일</th>
					          	<td style="text-align: left;height: 20px;">
									${resultView.USS_BIRTH }
					            </td>
				            </tr>
				            <tr>
					          	<th>성별</th>
					          	<td style="text-align: left;height: 20px;">
									${resultView.USS_SEX_VAL }
					            </td>
				            </tr>
				            <tr>
					          	<th>전화번호</th>
					          	<td style="text-align: left;height: 20px;">
									${resultView.USS_TEL }
					            </td>
				            </tr>
				            <tr>
					          	<th>이메일</th>
					          	<td style="text-align: left;height: 20px;">
									${resultView.USS_EMAIL }
					            </td>
				            </tr>
				            <tr>
					          	<th>권한</th>
					          	<td style="text-align: left;height: 20px;">
									${resultView.USS_AUTH_NM }
					            </td>
				            </tr>
				      	</tbody>
			   		</table>
				</form>
				<p class="view_btn" >
				    <a href="#submit" class="btn-upd btn btn_info" ><span>수정</span></a>
				    <a href="#submit" class="btn-del btn btn_info" ><span>삭제</span></a>
				    <a href="#cancel" class="full-right btn-list btn btn_info" ><span>목록</span></a>
				</p>
			</article>
		</section>
	</div>
	<jsp:include page="/resources/com/inc/footer.jsp" />
</div>


<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	/* 수정폼 */	
	$( ".btn-upd" ).click(function() {
		$("#mode").val("<%=VarConsts.MODE_U%>");
		$("#frm1").attr("action", "${pageContext.request.contextPath}/uss/umt/uss00Form.do");
		$("#frm1").submit();
	});
	/* 삭제 */
	$( ".btn-del" ).click(function() {
		if(confirm("삭제하시겠습니까?")){
			$("#mode").val("<%=VarConsts.MODE_D%>");			
			$.ajax({
				url: "${pageContext.request.contextPath}/uss/umt/uss00Tran.do",
				type: "post",
				dataType : "json", 
				data : $("#frm1").serialize(),
				success: function(result){
					alert("삭제되었습니다.");
					goList();
				},error: function (request, status, error) {
					alert("삭제에 실패 했습니다.");
// 					alert(request.responseText);
				} 
			});
		}
	});
	/* 목록 */
	$( ".btn-list" ).click(function() {
		goList();
	});
	
});

function goList(){
	$("#frm1").attr("action", "${pageContext.request.contextPath}/uss/umt/uss00List.do");
	$("#frm1").submit();
}

/*문서전체 키다운 onKeyDown*/
$(document).keydown(function(e){
	keyDown();
});
	
/* 키를 눌렀을 시 동작.*/
function keyDown(){
	if(event != null) {
		//엔터키
		if (event.keyCode==13){
			fnSearch();
			
		}
	}
}

</script>
</body>
</html>