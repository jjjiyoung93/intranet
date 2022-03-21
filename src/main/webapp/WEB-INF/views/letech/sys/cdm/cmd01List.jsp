<%@ page contentType="text/html; charset=utf-8" language=   "java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
<jsp:include page="/resources/com/inc/meta.jsp" />
<title>Letech Intranet</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
</head>
<body>
<div id="warpper">
   <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
      <jsp:include page="/resources/com/inc/header.jsp" />
      <%@ include file="/WEB-INF/views/letech/com/layout/menu.jsp" %>
   </nav>
   <div class="" id="page-wrapper">
      <section class="row">
      <div class="col-lg-10">
         <form name="form1" id="form1" method="post" action="<%=request.getContextPath()%>/sys/cdm/list.do" >
            <input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}"/>
            <input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}"/>
            <input type="hidden" id="mode" name="mode" />
            <input type="hidden" name="cd" id="cd" value=""  /> 
            <input type="hidden" name="flag" id="flag" value="" /> 
            <input type="hidden" name="up_cd" id="up_cd" value="${params.up_cd }" /> 
            <input type="hidden" name="m_cd" id="m_cd" value=""  /> 
            <input type="hidden" name="up_cd2" id="up_cd2" value=""  /> 
            <input type="hidden" name="up_cd3" id="up_cd3" value=""  /> 
            <!-- 타이틀 및 페이지 네비 -->
            <h2 class="page-title clearfix">
               ${titleNaviMap.MN_NM }
               <span class="pull-right site-map">HOME > ${titleNaviMap.NAVI_NM }</span>
            </h2>
            <div class="form-container">
            <!-- page -->
               <div class="clearfix search-box form-inline">
                  <input type="hidden" name="uss_id" id="uss_id" value=""/>
                  <div class="row">
                     <div class ="col-md-6 un-style form-inline mt10">
                        <span class="inline-element col-md-8 col-md-offset-2"  >
                           <label>코&nbsp;&nbsp;&nbsp;드</label>&nbsp;
                           <input type="text" name="searchField" id="searchField"  value="${params.searchField}" class="form-control" style="inline-block;" title="검색어 입력" />
                        </span>
                     </div>
                  </div>
                  <div class="row">
                     <div class ="col-md-6 un-style form-inline mt10">
                        <span class="inline-element col-md-8 col-md-offset-2">
                           <label >코드명</label>&nbsp;
                           <input type="text" name="searchField" id="searchField"  value="${params.searchField}" class="form-control" style="inline-block;" title="검색어 입력" />
                        </span>
                     </div>
                  </div>
                  <div class="row">
                     <div class ="col-md-6 un-style form-inline mt10">
                        <span class="inline-element col-md-8 col-md-offset-2">
                           <label>코드값</label>&nbsp;
                           <input type="text" name="searchField" id="searchField"  value="${params.searchField}" class="form-control" style="inline-block;" title="검색어 입력" />
                        </span>
                     </div>
                     <div class ="col-md-6 un-style mt10">
                        <div class="col-md-12">
                           <div class ="un-style col-md-12 form-inline" style="float:right;">
                              <span class="inline-element" style="float:right;">
                                 <button type="button" class="fnSearch btn-info btn"  >
                                    <span class="hidden-xs hidden-sm"> 초기화</span>
                                 </button>
                                 <button type="button" class="fnSearch btn-info btn"  >
                                    <span class="hidden-xs hidden-sm"> 검색</span>
                                 </button>
                              </span>
                           </div>
                        </div>
                     </div>
                  </div>
               </div><!-- 검색 div 끝 -->
               <p class="clearfix">
                  <span class="pull-right">
                     <input type="button" class="button-a btn btn-sm btn-info" onclick="codeInsert();" value="등록">
                  </span>
               </p>
               <div class="row">
                  <div class="col-md-5">
                     <div class=" panel panel-default">
                        <h3 class="panel-title panel-heading clearfix">메뉴구조</h3>
                        <div class="panel-body" id="tree">
                        </div><!-- pannel body 끝 -->
                     </div>
                  </div><!-- 코드구조 끝 -->
                  
                  <div class="col-md-7 tree_menu_box">
                  <!-- 테이블 -->
                     <table class="table table-bordered">
                        <colgroup>
                           <col width="30%"  />
                           <col width="30%"  />
                           <col width="*"  />
                        </colgroup>
                        <thead class="table-light ag_left">            
                           <tr>
                              <th>코드</th>
                              <th>코드명</th>
                              <th>코드값</th>
                           </tr>
                        </thead>
                        <tbody class="ag_left">
<%--                               <c:choose> --%>
<%--                               <c:when test="${highList eq null }"> --%>
<!--                               <tr> -->
<!--                                  <th> -->
<!--                                     등록된 코드가 없습니다. -->
<!--                                  </th> -->
<!--                               </tr> -->
<%--                               </c:when> --%>
<%--                                  <c:otherwise> --%>
<%--                                  <c:forEach var="highList" items="${highList }"> --%>
                              <tr >
                                 <td align="center">
                                 	<a href="javascript:codeView('CD0001')">CD0001</a>
                                 </td><!-- 코드 -->
                                 <td align="center">결재구분코드</td><!-- 코드명 -->
                                 <td align="center">100</td><!-- 코드값 -->
                              </tr>
<%--                                  </c:forEach>                --%>
<%--                                  </c:otherwise> --%>
<%--                                  </c:choose> --%>
                        </tbody>
                     </table>
                  </div>   <!-- 하위메뉴 끝 -->
            </div><!-- container 끝 -->
            <p class="clearfix">
               <span class="pull-right">
                  <input type="button" class="button-a btn btn-sm btn-info" onclick="codeInsert();" value="등록">
               </span>
            </p>
            <!-- page nav -->
   
      </div>
   </form>
</div>
<jsp:include page="/resources/com/inc/aside.jsp" />
   </section>
</div>
<jsp:include page="/resources/com/inc/footer.jsp" />
</div>

<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script type="text/javascript">

$(function(){
	getTree();
})

function getTree() {
	$.ajax({
		type	 : 'get',
		url  	 : '<%=request.getContextPath() %>/sys/cdm/jstreeList.do',
		dataType : 'json',
		success  : function(json){
			var list = new Array();
			//데이터 받아옴
			var data = json.codeList;
			$.each(data, function(i, v){
				list[i] = {id : v.CD, parent : v.UP_CD, text : v.CD_NM}
			});
			console.log('list',list);
			//트리 생성
			$('#tree').jstree({
				core : {
					//데이터 연결
					data : list
				}
			}) //트리 생성 끝
		} //success 끝
	}); //ajax 끝
}

/* 상세조회 */
function codeView(cd) {
	window.open('getCodeForm.do?flag=2&cd='+cd,'target_name','scrollbars=yes,toolbar=yes,resizable=yes,width=500,height=400,left=750,top=250');
}

/* 등록조회 */
function codeInsert() {
	window.open('getCodeForm.do?flag=1&cd=','target_name','scrollbars=yes,toolbar=yes,resizable=yes,width=500,height=400,left=750,top=250');
}

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
* function명   : fnInsert(코드)
* function기능 : 코드 추가
**********************************************************************************/
//function fnInsert(){
//   //jQuery( ".pop_bg" ).fadeIn('slow');
//   //jQuery( "#iframe" ).attr("src","<%=request.getContextPath() %>/sys/cdm/form.do?flag=1&cd=");
//   
//   window.open('form.do?flag=1&cd=','target_name','scrollbars=yes,toolbar=yes,resizable=yes,width=500,height=300,left=0,top=0');
//   
//}


/*********************************************************************************
* function명   : fnLowInsert(코드)
* function기능 : 하위코드 추가
**********************************************************************************/
function fnLowInsert(cd){
   //jQuery( ".pop_bg" ).fadeIn('slow');
   //jQuery( "#iframe" ).attr("src","<%=request.getContextPath() %>/mng/sysMng/cmmCdMng/cmmCdMng00U.do?flag=2&cd="+cd);
   window.open('form.do?flag=2&cd='+cd,'target_name','scrollbars=yes,toolbar=yes,resizable=yes,width=500,height=300,left=0,top=0');
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
   window.open('form.do?flag=3&cd='+cd,'target_name','scrollbars=yes,toolbar=yes,resizable=yes,width=500,height=300,left=0,top=0');
}

/*********************************************************************************
* function명   : fnDelete(코드)
* function기능 : 코드 삭제 
**********************************************************************************/
function fnDelete(mode,cd,flag){
   document.form1.cd.value = cd;
   document.form1.mode.value = mode;
   document.form1.flag.value = flag;
   if(flag == '1'){
      if(confirm('하위코드도 모두 삭제됩니다. 삭제하시겠습니까?')){
         document.form1.action = "<%=request.getContextPath() %>/sys/cdm/tran.do";
         document.form1.submit();
      }
   }else{      
      if(confirm('삭제하시겠습니까?')){
         document.form1.action = "<%=request.getContextPath() %>/sys/cdm/tran.do";
         document.form1.submit();
      }
   }
}
</script>
</body>
</html>