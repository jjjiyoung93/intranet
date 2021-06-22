<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
	<jsp:include page="/resources/com/inc/meta.jsp" />
	<title>Letech Intranet</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
</head>


<body class="pop">
	<div class="container">
 	 <form class="pp_form" id="form2" name="form2" method="post" action="std00tran.do" onsubmit="return false;">
 	 <h1 class="">여비정보 추가/ 수정</h1>
 	 	<div class="pop-contents">
 	 <fieldset>
 	 		<input type="hidden" id="mode" name="mode" />
			<input type="hidden" id="flag" name="flag" value="${params.flag }" />
			<input type="hidden" id="group_cd" name="group_cd" value="${params.group_cd }" />
		     
		     <ul>
				<li class="form-group">
					<div>
						<label   class=" col_md_3" for="grp_nm" >* 여비그룹</label>					
					</div>
					<input class="form-control" style="display:inline-block; width: 100%;" type="text" name="grp_nm" id="grp_nm" value="${getView.GROUP_NM}" oninput="fn_setGrp1(this.value)">
					<%-- <select class="form-control" id="grp_cd" name="grp_cd" onchange="fn_setGrp1(this.value)">
						<c:forEach var="groupCode" items="${groupCodeList}">
							<option value="${groupCode.CD}" <c:if test="${getView.GROUP_CD eq groupCode.CD}" >selected="selected"</c:if> >${groupCode.CD_NM}(${groupCode.CD})</option>
						</c:forEach>
					</select> --%>
				</li>
					
				<li>
					<div>
						<label  class=" " for="trvct" >* 여비기준금액</label>					
					</div>
	     			 <input class="form-control" style="display:inline-block; width: 95%;" type="text" name="trvct" id="trvct" value="${getView.TRVCT}" placeholder="숫자만 입력해주세요" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');"> 원
				</li>
		     </ul>
				<p class="clearfix">
					<span class="pull-right">
			           <a href="#submit" class="btn btn-info btn-sm" onclick="fnSubmit('${params.flag}');"><span>저장</span></a>
			           <a href="#cancel" class="btn btn-default btn-sm" onclick="window.self.close();"><span>닫기</span></a>
      		</span>
      	</p>
			
		    </fieldset>
			</div>
		  </form>
			</div>
       
       
       
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">

function fnSubmit(flag){
	var grp1 = $("#grp_nm").val();
	var target = "${params.target}";
	var result = false;
	if(flag == '3'){
		document.form2.mode.value = '<%=VarConsts.MODE_U%>';
	}else{
		document.form2.mode.value = '<%=VarConsts.MODE_I%>';
		var ovlap = fn_ovlapChk(grp1);
	
		if(ovlap){
			alert("이미 등록된 그룹입니다. \r\n 중복되지 않는 그룹을 입력해주세요.");
			return
		}
	}

	result = fn_validate();
	if(result){
		$.ajax({
			url: "<%=request.getContextPath()%>/sys/std/std00Tran.do",
			type: "post",
			dataType : "json",
			async : false, 
			data : $("#form2").serialize(),
			success: function(result){
				//parent.jQuery( ".pop_bg" ).fadeOut('slow');
				
				if(flag == '3') {
					alert("수정 완료되었습니다.");
				}

				if(flag == "1") {
					alert("등록되었습니다.");
				}
				
				$(opener.location).attr("href","javascript:fnList();");
				//parent.fnList();
				window.self.close();
			},error: function (request, status, error) {
				alert(request.responseText);
			} 
		});
	}
}

var flagParam = '${params.flag}';
if(flagParam == '3'){
	$("#grp_nm").prop("disabled", true);	
}

function fn_ovlapChk(param){
	var result = false;
	$.ajax({
		url : "${pageContext.request.contextPath}/sys/std/std00ovlap.do",
		type : "post",
		async : false,
		dataType : "json",
		data : {"nm" : param },
		success : function(data){
			var cnt = parseInt(data.result.CNT);
			//console.log(cnt);
			if(cnt > 0 ){
				result = true;
			}
		}

	})
	return result;
	
}


function fn_setGrp1(grpNm){

	var ovlap = fn_ovlapChk(grpNm);

	if(ovlap){
		alert("이미 등록된 그룹입니다. \r\n 중복되지 않는 그룹을 입력해주세요.");
		return
	}	
}


function fn_validate(){
	var grpNm = $("#grp_nm").val();
	var trvct = $("#trvct").val();

	if(grpNm == null  || grpNm == ""){
		alert("여비그룹 값이 누락되었습니다. 여비그룹값을 입력해주세요.");
		return false;
	}

	if(trvct == null || trvct == "" || trvct == "0"){
		alert("여비 기준 금액 값이 누락되었습니다. 여비 기준 금액 값을 입력해주세요.");
		return false;
	}

	return true;
}

</script>

</body>
</html>