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
 	 <form class="pp_form" id="form2" name="form2" method="post" action="bbs00tran.do" onsubmit="return false;">
 	 <h1 class="">게시판 추가/ 수정</h1>
 	 	<div class="pop-contents">
 	 <fieldset>
 	 		<input type="hidden" id="mode" name="mode" />
			<input type="hidden" id="flag" name="flag" value="${params.flag }" />
			<input type="hidden" id="bbs_id" name="bbs_id" value="${params.bbs_id }" />
		     
		     <ul>
		     	<li class="form-group">
		     		<label for="bbs_nm"  class="">게시판명</label>
		   			<input type="text" name="bbs_nm" id="bbs_nm" value="${getView.BBS_NM}" class="input input-small form-control" >
		     	</li>
					<li class="form-group">
						<label   class=" col_md_3" for="bbs_ty" >게시판타입</label>
						<select class="form-control" id="bbs_ty" name="bbs_ty">
							<c:forEach var="bbsTyList" items="${bbsTyCodeList}">
								<option value="${bbsTyList.CD}" <c:if test="${getView.BBS_TY eq bbsTyList.CD}" >selected="selected"</c:if> >${bbsTyList.CD_NM}(${bbsTyList.CD})</option>
							</c:forEach>
						</select>
					</li>
					<li class="form-group">
						<label  class="" for="layout_ty" >레이아웃타입</label>
				    <select  class="form-control" id="layout_ty" name="layout_ty">
				    	<c:forEach var="bbsLayoutTyCode" items="${bbsLayoutTyCodeList}">
				    		<option value="${bbsLayoutTyCode.CD_VAL}" <c:if test="${getView.LAYOUT_TY eq bbsLayoutTyCode.CD_VAL}" >selected="selected"</c:if> >${bbsLayoutTyCode.CD_NM}(${bbsLayoutTyCode.CD_VAL})</option>
							</c:forEach>
						</select>
					</li>
					<li class="form-group row">
						<span class=" col-xs-6">
							<label class="" for="sec_yn">비밀글여부</label>
				      <select  class="form-control " id="sec_yn" name="sec_yn">
								<option value="Y" <c:if test="${getView.SEC_YN eq 'Y'}" >selected="selected"</c:if> >Y</option>
								<option value="N" <c:if test="${getView.SEC_YN eq 'N'}" >selected="selected"</c:if> >N</option>
						  </select>
					  </span>
					  <span class=" col-xs-6">
					  <label class="" for="rep_yn" >답글여부</label>
				      <select  class="form-control"  id="rep_yn" name="rep_yn">
								<option value="Y" <c:if test="${getView.REP_YN eq 'Y'}" >selected="selected"</c:if> >Y</option>
								<option value="N" <c:if test="${getView.REP_YN eq 'N'}" >selected="selected"</c:if> >N</option>
					 		</select>
					  </span>
					</li>
					<li class="form-group row">
						<span class="col-xs-6">
					 		<label  class="" for="coment_yn" >댓글여부</label>
							<select  class="form-control" id="coment_yn" name="coment_yn">
								<option value="Y" <c:if test="${getView.COMENT_YN eq 'Y'}" >selected="selected"</c:if> >Y</option>
								<option value="N" <c:if test="${getView.COMENT_YN eq 'N'}" >selected="selected"</c:if> >N</option>
							</select>
						</span>
						<span class="col-xs-6">
							<label  class="" for="notice_yn" >공지여부</label>
					      <select  class="form-control" id="notice_yn" name="notice_yn">
								<option value="Y" <c:if test="${getView.NOTICE_YN eq 'Y'}" >selected="selected"</c:if> >Y</option>
								<option value="N" <c:if test="${getView.NOTICE_YN eq 'N'}" >selected="selected"</c:if> >N</option>
						  </select>
						</span>
					</li>
						
					<li>
						<label  class=" " for="bbs_ord" >게시판순번</label>
		      <input  class="form-control" type="text" name="bbs_ord" id="bbs_ord" value="${getView.BBS_ORD}" >
					</li>
		     </ul>
				<p class="clearfix">
					<span class="pull-right">
           <a href="#cancel" class="btn btn-default" onclick="window.self.close();"><span>닫기</span></a>
           <a href="#submit" class="btn btn-info" onclick="fnSubmit('${params.flag}');"><span>저장</span></a>
      		</span>
      	</p>
			
		    </fieldset>
			</div>
		  </form>
			</div>
       
       
       
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