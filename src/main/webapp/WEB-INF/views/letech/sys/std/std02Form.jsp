<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
	<jsp:include page="/resources/com/inc/meta.jsp" />
	<title>Letech Intranet</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
</head>


<body class="pop">
	<div class="container">
 	 <form class="pp_form" id="form2" name="form2" method="post" action="std02tran.do" onsubmit="return false;">
 	 <h1 class="">교통비 추가/ 수정</h1>
 	 	<div class="pop-contents">
 	 <fieldset>
 	 		<input type="hidden" id="mode" name="mode" />
 	 		<input type="hidden" id="cd_val" name="cd_val" />
			<input type="hidden" id="flag" name="flag" value="${params.flag }" />
			<input type="hidden" id="regn_cd1" name="regn_cd1" value="${params.regn_cd1}" />
			<input type="hidden" id="regn_cd2" name="regn_cd2" value="${params.regn_cd2}" />
			<!-- 입력모드  -->
			<c:if test="${params.flag == '1'}">
				<ul>
					<li>
	     			 <input class="form-control" style="display:inline-block; width: 80%;" type="hidden" name="cd_ord" id="cd_ord" value="${regnCodeList[fn:length(regnCodeList) - 1].CD_ORD+1}">
	     			 <input class="form-control" style="display:inline-block; width: 80%;" type="hidden" name="levl" id="levl" value="${regnCodeList[0].LEVL}">
	     			 <input class="form-control" style="display:inline-block; width: 80%;" type="hidden" name="up_cd" id="up_cd" value="<%=VarConsts.PLC_CODE%>">
						<div>
							<label  class=" " for="cd_nm" >*지역명</label>					
						</div>	
		     			 <input  class="form-control regn-name" style="display:inline-block; width: 100%;" type="text" name="cd_nm" id="cd_nm" value="${params.code_nm}" onchange="fn_setRegn1(this.value);">
					</li>
<!-- 					<li> -->
<!-- 						<div> -->
<!-- 							<label  class=" " for="cd_val" >값(코드값)</label>					 -->
<!-- 						</div>	 -->
<!-- 		     			 <input  class="form-control" style="display:inline-block; width: 80%;" type="text" name="cd_val" id="cd_val"> -->
<!-- 					</li> -->
				</ul>
				<div class="mt20">
				<label>경로별 거리/금액</label>
				<p class="clearfix">
					<span class="pull-right">
			           <a class="btn btn-info btn-sm" onclick="fn_delOthers()"><span>삭제</span></a>
      				</span>
					<span class="pull-right" style="margin-right : 10px;">
			           <a class="btn btn-info btn-sm" onclick="fn_addOthers()"><span>추가</span></a>
      				</span>
      			</p>
				<table class="table table-bordered">
					<colgroup>
						<col width="25%">
						<col width="25%">
						<col width="25%">
						<col width="25%">
					</colgroup>
					<thead>
						<tr>
							<th>출발</th>
							<th>도착</th>
							<th>*거리</th>
							<th>*금액</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="text-align: center; vertical-align: middle;">
								<span class="regn1"></span>
							</td>
							<td style="text-align: center; vertical-align: middle">
								<input class="form-control" type="hidden" name='trcsList[0].regnCd2' value="CD0009002">
								<c:out value="대전"/>														
							</td>
							<td class="text-right">
								<input  class="form-control dstnc text-right" style="display:inline-block; width: 70%; font-size: 10px;" type="text" name='trcsList[0].dstnc' value="0" placeholder="숫자 입력" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"> km
							</td>
							<td class="text-right">
								<input  class="form-control trcs text-right" style="display:inline-block; width: 70%; font-size: 10px;" type="text" name='trcsList[0].trcs' value="0" placeholder="숫자 입력" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');"> 원
							</td>
						</tr>
						<c:forEach var="regnList" items="${regnCodeList}" varStatus="status">
							<c:if test="${regnList.CD != 'CD0009002'}">
								<tr class="other-regn" style="display: none;">
									<td style="text-align: center; vertical-align: middle;">
										<span class="regn1"></span>
									</td>
									<td style="text-align: center; vertical-align: middle">
										<input class="form-control" type="hidden" name='trcsList[${status.index+1}].regnCd2' value="${regnList.CD}" disabled>
										<c:out value="${regnList.CD_NM}"/>														
									</td>
									<td class="text-right">
										<input  class="form-control dstnc text-right" style="display:inline-block; width: 70%; font-size: 10px;" type="text" name='trcsList[${status.index+1}].dstnc' value="0" placeholder="숫자 입력" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" disabled> km
									</td>
									<td class="text-right">
										<input  class="form-control trcs text-right" style="display:inline-block; width: 70%; font-size: 10px;" type="text" name='trcsList[${status.index+1}].trcs' value="0" placeholder="숫자 입력" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');" disabled> 원
									</td>
								</tr>							
							</c:if>
						</c:forEach>
					</tbody>
				</table>
				</div>
			</c:if>
			
			<!-- 수정모드  -->
			<c:if test="${params.flag == '3'}">
				<c:choose>
					<c:when test="${empty highList}">
					<ul>
					<li class="form-group">
						<label  class=" col_md_3" for="regn_code1" >출발지</label>
						<input  class="form-control" style="display:inline-block; width: 80%;" type="hidden" name="trcsList[0].regnCd1" id="dstnc" value="${getView.REGN_CD1}">
						 <input  class="form-control" style="display:block; width: 94%;" type="text" id="cd_nm1" value="${getView.REGN_NM1}" readonly>						
						
						<%-- <span><c:out value="${getView.REGN_NM1}"/></span> --%>
<!-- 						<select class="form-control" id="regn_code1" name="regn_code1">		 -->
<%-- 							<c:forEach var="regnCode" items="${regnCodeList}"> --%>
<%-- 								<option value="${regnCode.CD}" <c:if test="${getView.REGN_CD1 eq regnrCode.CD}" >selected="selected"</c:if> >${regnCode.CD_NM}(${regnCode.CD})</option> --%>
<%-- 							</c:forEach> --%>
<!-- 						</select> -->
					</li>
					<li class="form-group">
						<label  class=" col_md_3" for="regn_code2" >도착지</label>
						<input  class="form-control" style="display:inline-block; width: 80%;" type="hidden" name="trcsList[0].regnCd2" id="dstnc" value="${getView.REGN_CD2}">
							<input  class="form-control" style="display:block; width: 94%;" type="text" id="cd_nm2" value="${getView.REGN_NM2}" readonly>						
						<%-- <span><c:out value="${getView.REGN_NM2}"/></span> --%>
<!-- 						<select class="form-control" id="regn_code2" name="regn_code2">		 -->
<%-- 							<c:forEach var="regnCode2" items="${regnCodeList}"> --%>
<%-- 								<option value="${regnCode2.CD}" <c:if test="${getView.REGN_CD2 eq regnrCode2.CD}" >selected="selected"</c:if> >${regnCode2.CD_NM}(${regnCode2.CD})</option> --%>
<%-- 							</c:forEach> --%>
<!-- 						</select> -->
					</li>
					<li>
						<div>
							<label  class=" " for="dstnc" >*거리</label>					
						</div>	
		     			 <input  class="form-control text-right" style="display:inline-block; width: 94%;" type="text" name="trcsList[0].dstnc" id="dstnc" value="${getView.DSTNC}" placeholder="숫자 입력" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"> km
					</li>
					<li>
						<div>
							<label  class=" " for="trcs" >*금액</label>					
						</div>
		     			 <input  class="form-control text-right" style="display:inline-block; width: 94%;" type="text" name="trcsList[0].trcs" id="trcs" value="${getView.TRCS}" placeholder="숫자 입력" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');"> 원
					</li>					
			     </ul>
				</c:when>
				<c:otherwise>
					<ul>
						<li>
							<div>
								<label  class=" " for="cd_nm" >지역명</label>					
							</div>	
			     			 <input  class="form-control regn-name" style="display:inline-block; width: 100%;" type="text" name="cd_nm" id="cd_nm" value="${codeView.CD_NM}" readonly>
						</li>
<!-- 						<li> -->
<!-- 							<div> -->
<!-- 								<label  class=" " for="cd_val" >값(코드값)</label>					 -->
<!-- 							</div>	 -->
<%-- 			     			 <input  class="form-control" style="display:inline-block; width: 80%;" type="text" name="cd_val" id="cd_val" value="${codeView.CD_VAL}"> --%>
<!-- 						</li> -->
					</ul>
					<div class="mt20">
					<label>경로별 거리/금액</label>
					<p class="clearfix">
						<span class="pull-right">
				           <a class="btn btn-info btn-sm btn-option" onclick="fn_delOthers()"><span>삭제</span></a>
	      				</span>
						<span class="pull-right" style="margin-right: 10px;">
				           <a class="btn btn-info btn-sm btn-option" onclick="fn_addOthers()"><span>추가</span></a>
	      				</span>
      				</p>

					<table class="table table-bordered">
						<colgroup>
							<col width="25%">
							<col width="25%">
							<col width="25%">
							<col width="25%">
						</colgroup>
						<thead>
							<tr>
								<th>출발</th>
								<th>도착</th>
								<th>*거리</th>
								<th>*금액</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="highList" items="${highList}" varStatus="status">
								<tr>
									<td style="text-align: center; vertical-align: middle;">
										<input class="form-control" type="hidden" name='trcsList[${status.index}].regnCd1' value="${highList.REGN_CD1}">
										<c:out value="${highList.REGN_NM1}"/>
									</td>
									<td style="text-align: center; vertical-align: middle;">
										<input class="form-control" type="hidden" name='trcsList[${status.index}].regnCd2' value="${highList.REGN_CD2}">
										<c:out value="${highList.REGN_NM2}"/>																
									</td>
									<td class="text-right">
										<input  class="form-control dstnc text-right" style="display:inline-block; width: 70%; font-size: 10px;" type="text" name='trcsList[${status.index}].dstnc' value="${highList.DSTNC}" placeholder="숫자 입력" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"> km
									</td>
									<td class="text-right">
										<input  class="form-control trcs text-right" style="display:inline-block; width: 70%; font-size: 10px;" type="text" name='trcsList[${status.index}].trcs' value="${highList.TRCS}" placeholder="숫자 입력" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');"> 원
									</td>
								</tr>
							</c:forEach>
							
							<%-- <c:forEach var="regnList" items="${regnCodeList}" varStatus="status">
								<c:set var="cd" value="${regnList.CD}"/>
								
								
								
		
								<tr class="other-regn" style="display: none;">
									<td style="text-align: center; vertical-align: middle;">
										<input class="form-control" type="hidden" name='trcsList[${status.index+1}].regnCd1' value="${highList[0].REGN_CD1}" disabled>
										<c:out value="${highList[0].REGN_NM1}"/>
									</td>
									<td style="text-align: center; vertical-align: middle">
										<input class="form-control" type="hidden" name='trcsList[${status.index+1}].regnCd2' value="${regnList.CD}" disabled>
										<c:out value="${regnList.CD_NM}"/>														
									</td>
									<td class="text-right">
										<input  class="form-control dstnc text-right" style="display:inline-block; width: 70%; font-size: 10px;" type="text" name='trcsList[${status.index+1}].dstnc' placeholder="숫자만 입력해주세요" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" disabled> km
									</td>
									<td class="text-right">
										<input  class="form-control trcs text-right" style="display:inline-block; width: 70%; font-size: 10px;" type="text" name='trcsList[${status.index+1}].trcs' placeholder="숫자만 입력해주세요" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');" disabled> 원
									</td>
				
							</c:forEach> --%>
							
							<c:forEach var="addList" items="${addList}" varStatus="status">
								<tr class="other-regn" style="display: none;">
									<td style="text-align: center; vertical-align: middle;">
										<input class="form-control" type="hidden" name='trcsList[${fn:length(highList) + status.index}].regnCd1' value="${highList[0].REGN_CD1}">
										<c:out value="${highList[0].REGN_NM1}"/>
									</td>
									<td style="text-align: center; vertical-align: middle">
										<input class="form-control" type="hidden" name='trcsList[${fn:length(highList) + status.index}].regnCd2' value="${addList.CD}" disabled>
										<c:out value="${addList.CD_NM}"/>														
									</td>
									<td class="text-right">
										<input  class="form-control dstnc text-right" style="display:inline-block; width: 70%; font-size: 10px;" type="text" name='trcsList[${fn:length(highList) + status.index}].dstnc' value="0" placeholder="숫자 입력" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" disabled> km
									</td>
									<td class="text-right">
										<input  class="form-control trcs text-right" style="display:inline-block; width: 70%; font-size: 10px;" type="text" name='trcsList[${fn:length(highList) + status.index}].trcs' value="0" placeholder="숫자 입력" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');" disabled> 원
									</td>
								</tr>							
						</c:forEach>
							
						</tbody>
					</table>
					</div>
				</c:otherwise>
				</c:choose>
				</c:if>
			
			
			
			
			
			
			
		     
<!-- 		     <ul> -->
<!-- 				<li class="form-group"> -->
<!-- 					<label  class=" col_md_3" for="regn_code1" >지역1[출발지]</label> -->
<!-- 					<select class="form-control" id="regn_code1" name="regn_code1">		 -->
<%-- 						<c:forEach var="regnCode" items="${regnCodeList}"> --%>
<%-- 							<option value="${regnCode.CD}" <c:if test="${getView.REGN_CD1 eq regnrCode.CD}" >selected="selected"</c:if> >${regnCode.CD_NM}(${regnCode.CD})</option> --%>
<%-- 						</c:forEach> --%>
<!-- 					</select> -->
<!-- 				</li> -->
<!-- 				<li class="form-group"> -->
<!-- 					<label  class=" col_md_3" for="regn_code2" >지역2[도착지]</label> -->
<!-- 					<select class="form-control" id="regn_code2" name="regn_code2">		 -->
<%-- 						<c:forEach var="regnCode2" items="${regnCodeList}"> --%>
<%-- 							<option value="${regnCode2.CD}" <c:if test="${getView.REGN_CD2 eq regnrCode2.CD}" >selected="selected"</c:if> >${regnCode2.CD_NM}(${regnCode2.CD})</option> --%>
<%-- 						</c:forEach> --%>
<!-- 					</select> -->
<!-- 				</li> -->
<!-- 				<li> -->
<!-- 					<div> -->
<!-- 						<label  class=" " for="dstnc" >지역명</label>					 -->
<!-- 					</div>	 -->
<%-- 	     			 <input  class="form-control" style="display:inline-block; width: 80%;" type="text" name="dstnc" id="dstnc" value="${getView.DSTNC}" placeholder="숫자만 입력해주세요" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"> km --%>
<!-- 				</li> -->
<!-- 				<li> -->
<!-- 					<div> -->
<!-- 						<label  class=" " for="dstnc" >거리</label>					 -->
<!-- 					</div>	 -->
<%-- 	     			 <input  class="form-control" style="display:inline-block; width: 80%;" type="text" name="dstnc" id="dstnc" value="${getView.DSTNC}" placeholder="숫자만 입력해주세요" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"> km --%>
<!-- 				</li> -->
<!-- 				<li> -->
<!-- 					<div> -->
<!-- 						<label  class=" " for="dstnc" >거리</label>					 -->
<!-- 					</div>	 -->
<%-- 	     			 <input  class="form-control" style="display:inline-block; width: 80%;" type="text" name="dstnc" id="dstnc" value="${getView.DSTNC}" placeholder="숫자만 입력해주세요" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"> km --%>
<!-- 				</li> -->
<!-- 				<li> -->
<!-- 					<div> -->
<!-- 						<label  class=" " for="trcs" >금액</label>					 -->
<!-- 					</div> -->
<%-- 	     			 <input  class="form-control" style="display:inline-block; width: 80%;" type="text" name="trcs" id="trcs" value="${getView.TRCS}" placeholder="숫자만 입력해주세요" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"> 원 --%>
<!-- 				</li>					 -->
<!-- 		     </ul> -->
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
	var cdNm = $("#form2").find("#cd_nm");
	var cdNmVal = $(cdNm).val();
	//console.log(cdNm);
	var valid = true;
	
	if(valid){
		//console.log("validation!!");
		valid = fn_validation($("#form2"));
		//console.log(valid);
	}

	if(!valid){
		return false;
	}

	if(flag == '1'){
		if(fn_ovlapChk(cdNmVal)){
			alert("이미 등록된 지역명입니다. \r\n 중복되지 않는 지역명을 입력해주세요.");
			$(cdNm).focus();
			valid = false;
			return
		}else {
			valid = true;
		}
	}

	
	if(valid){
		//console.log("submit!!");
		if(flag == '3'){
			document.form2.mode.value = '<%=VarConsts.MODE_U%>';
		}else{
			document.form2.mode.value = '<%=VarConsts.MODE_I%>';
		}
		$.ajax({
			url: "<%=request.getContextPath()%>/sys/std/std02Tran.do",
			type: "post",
			dataType : "json", 
			data : $("#form2").serialize(),
			success: function(result){
				//parent.jQuery( ".pop_bg" ).fadeOut('slow');
				alert("등록되었습니다.");
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
//console.log(flagParam);
if(flagParam == '3'){
	$("#regn_code1").prop("disabled", true);	
	$("#regn_code2").prop("disabled", true);	
}


var codeNm = '${params.code_nm}';
if(codeNm != null && '' != codeNm){
	var regn1List = $(document).find(".regn1");
	for(var i=0; i< regn1List.length; i++){
		var regnSpan = regn1List[i];
		$(regnSpan).text(codeNm);
	}
	
}
// 추가할 리스트가 없으면 추가/삭제 버튼 비활성화, 숨김
var addListCnt = "${fn:length(addList)}";

if(addListCnt == 0){
	$(".btn-option").hide();
	$(".btn-option").prop("disabled", true);
}


function fn_ovlapChk(param){
	//console.log(param);
	var result = false;
	$.ajax({
		url : "${pageContext.request.contextPath}/sys/std/std02ovlap.do",
		type : "post",
		async : false,
		dataType : "json",
		data : {"cd_nm" : param },
		success : function(data){
			var cnt = parseInt(data.result.REGN_CNT);
			//console.log(cnt);
			if(cnt > 0 ){
				result = true;
			}
		}

	})
	return result;
	
}


function fn_setRegn1(regn1){
	
	var regn1List = $(document).find(".regn1");
	for(var i=0; i< regn1List.length; i++){
		var regnSpan = regn1List[i];
		$(regnSpan).text("");
	}
	
	var ovlap = fn_ovlapChk(regn1);

	if(ovlap){
		alert("이미 등록된 지역명입니다. \r\n 중복되지 않는 지역명을 입력해주세요.");
		return
	}

	//console.log(regn1List);
	for(var i=0; i< regn1List.length; i++){
		var regnSpan = regn1List[i];
		$(regnSpan).text(regn1);
	}

	//console.log($("#form2").serialize());
	
}


function fn_validation(target){
	//console.log(target);
	var result = true;
	var formCtrlList = $(target).find(".form-control:enabled");
	//console.log(formCtrlList);
	for( var i = 0; i< formCtrlList.length; i++){
		var formCtrl = formCtrlList[i];
		//console.log(formCtrl);
		var value = $(formCtrl).val();
		//console.log(value);
		if(value == null || value == ""){
			result = false;
			alert("필수값을 입력해주세요.");
			$(formCtrl).focus();
			return result;
		}
	}
	
	return result;	
}

function initData(){
	var regnList = $(".other-regn");
	
	for(var i=0; i< regnLisg.length; i++){
		var dstnc = $(document).find(".dstnc")[i];
		var trcs = $(document).find(".trcs")[i];
		$(dstnc).val("100.24");
		$(trcs).val("20000");
	}
}

function fn_addOthers() {
	//console.log($("#form2").serialize());
	$(".other-regn").show();
	$(".other-regn input").prop("disabled", false);
}

function fn_delOthers() {
	//console.log($("#form2").serialize());
	$(".other-regn").hide();
	$(".other-regn input").prop("disabled", true);
}

</script>

</body>
</html>