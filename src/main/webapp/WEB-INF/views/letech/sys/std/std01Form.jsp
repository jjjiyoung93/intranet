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
 	 <form class="pp_form" id="form2" name="form2" method="post" action="std01tran.do" onsubmit="return false;">
 	 <h1 class="">그룹별 급수 추가/ 수정</h1>
 	 	<div class="pop-contents">
 	 <fieldset>
 	 		<input type="hidden" id="mode" name="mode" />
			<input type="hidden" id="flag" name="flag" value="${params.flag }" />
			<input type="hidden" id="aut_cd" name="aut_cd" value="${params.aut_cd }" />
		     
		     <ul>
				<li class="form-group">
					<div>
						<label   class=" col_md_3" for="author_nm" >*직급</label>					
					</div>
						<input class="form-control" style="display:inline-block; width: 100%;" type="text" name="author_nm" id="author_nm" value="${getView.AUTHOR_NM}" >					
					<%-- <select class="form-control" id="author_cd" name="author_cd" onchange="fn_setGrp1(this.value)">		
						<c:forEach var="authorCode" items="${authorCodeList}">
							<option value="${authorCode.CD}" <c:if test="${getView.AUTHOR_CODE eq authorCode.CD}" >selected="selected"</c:if> >${authorCode.CD_NM}(${authorCode.CD})</option>
						</c:forEach>
					</select> --%>
				</li>
				<li class="form-group">
					<div>
						<label   class=" col_md_3" for="author_rsrch_nm" >연구직급</label>					
					</div>
					
					<input class="form-control" style="display:inline-block; width: 100%;" type="text" name="author_rsrch_nm" id="author_rsrch_nm" value="${getView.AUTHOR_RSRCH_NM}" >
					
					
					<%-- <select class="form-control" id="author_cd" name="author_cd" onchange="fn_setGrp1(this.value)">		
						<c:forEach var="authorCode" items="${authorCodeList}">
							<option value="${authorCode.CD}" <c:if test="${getView.AUTHOR_CODE eq authorCode.CD}" >selected="selected"</c:if> >${authorCode.CD_NM}(${authorCode.CD})</option>
						</c:forEach>
					</select> --%>
				</li>
				<li class="form-group">
					<div>
						<label   class=" col_md_3" for="group_nm" >*급수</label>					
					</div>
					<c:choose>
						<c:when test="${params.flag == '1'}">
							<input class="form-control" style="display:inline-block; width: 100%;" type="text" name="grp_nm" id="group_nm" value="${getView.GROUP_NM}" >						
						</c:when>
						
						<c:when test="${params.flag == '3'}">
							<select class="form-control" id="group_nm" name="group_cd">
								<c:forEach var="groupCode" items="${groupCodeList}">
									<option value="${groupCode.GROUP_CD}" <c:if test="${getView.GROUP_CD eq groupCode.GROUP_CD}" >selected="selected"</c:if> >${groupCode.GROUP_NM}(${groupCode.GROUP_CD})</option>
								</c:forEach>
							</select>						
						</c:when>
					</c:choose>
					
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
	var grp1 = $("#author_nm").val();
	var grp2 = $("#group_nm").val();
	var valResult = false;
	if(flag == '3'){
		document.form2.mode.value = '<%=VarConsts.MODE_U%>';

		valResult = fn_validate();
		
	}else{
		document.form2.mode.value = '<%=VarConsts.MODE_I%>';

		valResult = fn_validate();

		if(!valResult){
			return false;
		} 

		var ovlap = fn_ovlapChk(grp1, grp2);
	
		if(ovlap){
			alert("이미 등록된 직급입니다. \r\n 중복되지 않는 값을 입력해주세요.");
			return false;
		}

	}

	if(valResult){
		$.ajax({
			url: "<%=request.getContextPath()%>/sys/std/std01Tran.do",
			type: "post",
			dataType : "json",
			async : false, 
			data : $("#form2").serialize(),
			success: function(result){
				//parent.jQuery( ".pop_bg" ).fadeOut('slow');
				//급수 추가된 부분을 
				var vResult = false;
				if(flag == '3') {
					alert("수정 완료되었습니다.");
				}
	
				if(flag == '1') {
					if(result.params.insGrpYn == "Y"){
						vResult = confirm("등록되었습니다.\n 새로운 여비 정보가 추가되었습니다. \n 여비 정보를 입력하시겠습니까?");
						if(vResult){
							$(opener.location).attr("href", "std00List.do?target=1&group_cd="+result.params.CD);
							//window.open('std00Form.do?flag=3&target=1&group_cd='+result.params.CD,'target_trvct','scrollbars=yes,toolbar=yes,resizable=yes,width=500,height=300,left=0,top=0');
						}
					}else {
						alert("등록되었습니다.");
					}
				}
				if(!vResult){
					$(opener.location).attr("href","javascript:fnList();");
				}
				//parent.fnList();
				window.self.close();
			},error: function (request, status, error) {
				alert(request.responseText);
			} 
		});
	}
	
}

var flagParam = '${params.flag}';
//console.log(flagParam);
if(flagParam == '3'){
	$("#author_nm").prop("disabled", true);	
}

function fn_ovlapChk(param, param2){
	//console.log(param);
	var result = false;
	$.ajax({
		url : "${pageContext.request.contextPath}/sys/std/std01ovlap.do",
		type : "post",
		async : false,
		dataType : "json",
		data : {"authorNm" : param,
			     "groupNm" : param2 },
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


function fn_validate(){
	var grp1 = $("#author_nm").val();
	var grp2 = $("#group_nm").val();


	if(grp1 == null || grp1 == ""){
		alert("직급이 누락되었습니다. 직급을 입력해주세요.");
		return false;
	}

	if(grp2 == null || grp2 == ""){
		alert("급수가 누락되었습니다. 급수를 입력해주세요");
		return false;
	}

	return true;
}

</script>
</body>
</html>