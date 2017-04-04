<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
	<title>Letech Intranet</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
</head>


<body class="pop">
 	 <form class="pp_form" id="form2" name="form2" method="post" action="bbs00tran.do" onsubmit="return false;">
 	 <h2 class="sub_title">게시판 추가/ 수정</h2>
 	 <fieldset>
 	 	<div class="col_md_12">
 	 		<input type="hidden" id="mode" name="mode" />
			<input type="hidden" id="flag" name="flag" value="${params.flag }" />
			<input type="hidden" id="bbs_id" name="bbs_id" value="${params.bbs_id }" />
		     
		     
		    <label for="bbs_nm"  class=" col_md_3">게시판명</label>
		    <input class="col_md_9" type="text" name="bbs_nm" id="bbs_nm" value="${getView.BBS_NM}" class="input input-small" >
		    <label   class=" col_md_3" for="bbs_ty" >게시판타입</label>
			<select class="col_md_9" id="bbs_ty" name="bbs_ty">
				<c:forEach var="bbsTyList" items="${bbsTyCodeList}">
					<option value="${bbsTyList.CD}" <c:if test="${getView.BBS_TY eq bbsTyList.CD}" >selected="selected"</c:if> >${bbsTyList.CD_NM}(${bbsTyList.CD})</option>
				</c:forEach>
			</select>
		    <label  class=" col_md_3" for="layout_ty" >레이아웃타입</label>
		    <select  class=" col_md_9" id="layout_ty" name="layout_ty">
		    	<c:forEach var="bbsLayoutTyCode" items="${bbsLayoutTyCodeList}">
		    		<option value="${bbsLayoutTyCode.CD_VAL}" <c:if test="${getView.LAYOUT_TY eq bbsLayoutTyCode.CD_VAL}" >selected="selected"</c:if> >${bbsLayoutTyCode.CD_NM}(${bbsLayoutTyCode.CD_VAL})</option>
				</c:forEach>
			</select>
		      
		      <label class=" col_md_3" for="sec_yn">비밀글여부</label>
		      <select  class=" col_md_3" id="sec_yn" name="sec_yn">
					<option value="Y" <c:if test="${getView.SEC_YN eq 'Y'}" >selected="selected"</c:if> >Y</option>
					<option value="N" <c:if test="${getView.SEC_YN eq 'N'}" >selected="selected"</c:if> >N</option>
			  </select>
		      <label  class=" col_md_3" for="rep_yn" >답글여부</label>
		      <select  class=" col_md_3"  id="rep_yn" name="rep_yn">
					<option value="Y" <c:if test="${getView.REP_YN eq 'Y'}" >selected="selected"</c:if> >Y</option>
					<option value="N" <c:if test="${getView.REP_YN eq 'N'}" >selected="selected"</c:if> >N</option>
			  </select>
		      <label  class=" col_md_3" for="coment_yn" >댓글여부</label>
		      <select  class=" col_md_3" id="coment_yn" name="coment_yn">
					<option value="Y" <c:if test="${getView.COMENT_YN eq 'Y'}" >selected="selected"</c:if> >Y</option>
					<option value="N" <c:if test="${getView.COMENT_YN eq 'N'}" >selected="selected"</c:if> >N</option>
			  </select>
		      <label  class=" col_md_3" for="notice_yn" >공지여부</label>
		      <select  class=" col_md_3" id="notice_yn" name="notice_yn">
					<option value="Y" <c:if test="${getView.NOTICE_YN eq 'Y'}" >selected="selected"</c:if> >Y</option>
					<option value="N" <c:if test="${getView.NOTICE_YN eq 'N'}" >selected="selected"</c:if> >N</option>
			  </select>
			 <label  class=" col_md_3" for="bbs_ord" >게시판순번</label>
		      <input  class=" col_md_3" type="text" name="bbs_ord" id="bbs_ord" value="${getView.BBS_ORD}" >
 	 	</div>
 	 	<div class="full-right" >
 	 	<br>
           <a href="#submit" class="btn btn_info" onclick="fnSubmit('${params.flag}');"><span>저장</span></a>
           <a href="#cancel" class="btn btn_default" onclick="window.self.close();"><span>닫기</span></a>
       </div>
			
		    </fieldset>
		  </form>

       
       
       
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">

function fnSubmit(flag){
	if(flag == '3'){
		document.form2.mode.value = '<%=VarConsts.MODE_U%>';
	}else{
		document.form2.mode.value = '<%=VarConsts.MODE_I%>';
	}
	$.ajax({
		url: "<%=request.getContextPath()%>/sys/bbs/bbs00Tran.do",
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


</script>

</body>
</html>