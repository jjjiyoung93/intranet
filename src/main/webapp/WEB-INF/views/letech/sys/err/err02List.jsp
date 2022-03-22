<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
<html>
<head>
   <jsp:include page="/resources/com/inc/meta.jsp" />
   <title>Letech Intranet</title>
   <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
   <link href="<%=request.getContextPath()%>/resources/css/dataTables.bootstrap.min.css" rel="stylesheet">
   <link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.css' rel='stylesheet' />
   <link href='${pageContext.request.contextPath}/resources/js/fullcalendar/fullcalendar.print.css' rel='stylesheet' media='print' />

   <script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-code-snippet.js"></script>
   <script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-dom.js"></script>
   <script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-time-picker.js"></script>
   <script src="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-date-picker.js"></script>
   <link href="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-time-picker.css" rel="stylesheet" >
   <link href="${pageContext.request.contextPath}/resources/js/tui-date-picker/tui-date-picker.css" rel="stylesheet" >

</head>
<body>
   <div id="warpper">
      <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
         <jsp:include page="/resources/com/inc/header.jsp" />
         <%@ include file="/WEB-INF/views/letech/com/layout/menu.jsp" %>
      </nav>
      <div id="page-wrapper">
         <section class="row">
            <form name="form1" id="form1" method="post" action="<%=request.getContextPath()%>/sys/err/err00List.do" >
               <input type="hidden" id="mode" name="mode" />
               <input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}"/>
               <input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}"/>
               <input type="hidden" id="menu_id3" name="menu_id3" value="${params.menu_id3}"/>
               <input type="hidden" name="cPage" id="cPage" value="" />
               <input type="hidden" name="error_seq" id="error_seq" value="" />
               <input type="hidden" name="process_state" id="process_state" value="" />
               <div class="col-lg-10">
                  <!-- 타이틀 및 페이지 네비 -->      
                  <h2 class="page-title clearfix">
                     ${titleNaviMap.MN_NM }
                     <span class="pull-right site-map">
                        HOME > ${titleNaviMap.NAVI_NM }
                     </span>
                  </h2>
                     
                  <%-- <c:if test="${mnList3 ne null}">
                     <article>
                        <ul class="tab_gnb">
                              <c:forEach var="list3" items="${mnList3}" varStatus="status">
                                 <c:if test="${params.menu_id2 eq list3.UP_MN}">
                                    <li class="<c:if test="${params.menu_id3 eq list3.MN}">on </c:if>col_md_3">
                                       <a href="javascript:fnTabMove('${list3.MN_HREF}','${list3.MN}')">${list3.MN_NM}</a>
                                    </li>
                                 </c:if>
                           </c:forEach>
                        </ul>
                        </article>
                  </c:if> --%>
                  <div class="form-container">
                     <div class="clearfix search-box form-inline">
                     	<input type="hidden" name="uss_id" id="uss_id" value=""/>
                     
						<div class="row">
							<div class ="col-md-6 un-style form-inline mt10">
								<span class="inline-element col-md-8 col-md-offset-2">
								<label >에러위치</label>&nbsp;
								<select name="searchGubun6" id="searchGubun6" class="form-control" title="search" style="width : 265px;" >
									<option value="" >전체</option>
	//								<c:forEach var="proj" items="${projList}" varStatus="status">
//									<option value="에러위치">에러위치</option>
	//								</c:forEach>
								</select>
								</span>
							</div>
							<div class ="col-md-6 un-style form-inline mt10">
								<span class="inline-element col-md-8 col-md-offset-2">
								<label >에러유형</label>&nbsp;
								<select name="searchGubun6" id="searchGubun6" class="form-control" title="search" style="width : 265px;" >
								<option value="" >전체</option>
								//								<c:forEach var="proj" items="${projList}" varStatus="status">
	//									<option value="에러유형">에러유형</option>
								//								</c:forEach>
								</select>
								</span>
							</div>
						</div>
               
						<!-- 보고일자  -->
						<div class="row">
							<div class="col-md-6 un-style form-inline mt10">
								<div class="inline-element col-md-8 col-md-offset-2">
									<label>보고일자</label>&nbsp;
									<div class="search-select-wrap" style="display:inline-block; vertical-align: middle;">
										<div style="width: 125px;" class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
											<input id="st_dt"  name="stDtSrch" type="text" aria-label="Date" autocomplete="off"> <span class="tui-ico-date"></span>
											<div id="startpicker-container" style="margin-left: -1px;"></div>
										</div>
											 ~
										<div style="width: 125px;" class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
											<input id="ed_dt"name="edDtSrch" type="text" aria-label="Date" autocomplete="off"> <span class="tui-ico-date"></span>
											<div id="endpicker-container" style="margin-left: -1px;"></div>
										</div>
										<div style="display: inline-block;" class="ml10"><button type="button" id="delDate" class="btn btn-md btn-default" onclick="fn_delDate()">지우기</button></div>
									</div>
								</div>
							</div>
							
							<div class ="col-md-6 un-style mt10">
								<div class="col-md-12">
									<div class ="un-style col-md-12 form-inline" style="float:right;">
										<span class="inline-element" style="float:right;">
											<button type="button" class="fnSearch btn-info btn" id="clear">
												<span class="hidden-xs hidden-sm"> 초기화</span>
											</button>
											<button type="button" class="fnSearch btn-info btn"  >
												<i class="glyphicon glyphicon-search"></i><span class="hidden-xs hidden-sm"> 검색</span>
											</button>
										</span>
									</div>
								</div>
							</div>
						</div><!-- 보고일자 끝 -->
                  </div><!-- 검색 div 끝 -->

                  <!-- page -->
                  <p class="clearfix board-top">
                     <select id="listCnt" name="listCnt" class="form-control" style="width: 100px; display: inline-block;" onchange="goPage('1');">
                        <option value="10">10</option>
                        <option value="20">20</option>
                        <option value="30">30</option>
                        <option value="50">50</option>
                        <option value="100">100</option>
                     </select>
                  </p>
                  
                  <div class="table-responsive">
                        <!-- 테이블 -->
                        <table class="table table-bordered">
                           <caption>에러관리</caption>
                           <colgroup>
                              <col width="5%"  />
                              <col width="*"  />
                              <col width="20%"  />
                              <col width="15%"  />
                           </colgroup>
                           <thead>
                              <tr>
                                 <th>번호</th>
                                 <th>에러유형</th>
                                 <th>에러위치</th>
                                 <th>발생일자</th>
                              </tr>                        
                           </thead>
                           <tbody>
                              <c:choose>
                                 <c:when test="${pageInfo eq null }">
                                    <tr>
                                       <th colspan="7">
                                          등록된 에러가 없습니다.
                                       </th>
                                    </tr>
                                 </c:when>
                                 <c:otherwise>
                                    <c:forEach var="highList" items="${pageInfo.highList }" varStatus="status">
                                       <tr>
                                          <th style="vertical-align: middle;"  class="visible-md visible-lg text-center">${totalCnt - status.index - ((cPage-1) * (intListCnt))}</th>
                                          <td style="vertical-align: middle;">
                                             <a href="#" onclick="fnView('${highList.ERROR_SEQ}', '${highList.PROCESS_STATE}');">${highList.ERROR_LOGGER }</a> 
                                          </td>
                                          <td style="vertical-align: middle;" align="center">${highList.ERROR_LEVEL }</td>
                                          <td style="vertical-align: middle;" align="center">${highList.ERROR_DATE }</td>
                                       </tr>
                                    </c:forEach>               
                                 </c:otherwise>
                              </c:choose>
                           </tbody>
                        </table>
                        
                     </div>
                     <div class="text-center">
                     <br/>
                        <!-- page nav -->
                           <ul class="pagination pagination-sm">
                              ${pageNavigator }
                           </ul>
                     </div>
                  </div>
               </div>
            </form>
            <jsp:include page="/resources/com/inc/aside.jsp" />
         </section>
      </div>
      <jsp:include page="/resources/com/inc/footer.jsp" />
   </div>

<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">

var picker = tui.DatePicker.createRangePicker({
	language: 'ko',
	startpicker: {
		input: '#st_dt',
		container: '#startpicker-container'
	},
	endpicker: {
		input: '#ed_dt',
		container: '#endpicker-container'
	},
	type: 'date',
	format: 'yyyy-MM-dd'
});
   
var stDt = "<c:out value='${params.stDtSrch}'/>";
var edDt = "<c:out value='${params.edDtSrch}'/>";
if(stDt != null && stDt != ''){
   	var stDtStr = stDt.split("-");
	var stYear = stDtStr[0];
	var stMon = stDtStr[1] - 1;
	var stDay = stDtStr[2];
	var stDate = new Date(stYear ,stMon ,stDay);
	picker.setStartDate(stDate);
   	
}

   if(edDt != null && edDt != ''){
	   	var edDtStr = edDt.split("-");
	   	var edYear = edDtStr[0];
	   	var edMon = edDtStr[1] - 1;
	   	var edDay = edDtStr[2];
	   	var edDate = new Date(edYear, edMon, edDay);
	   	picker.setEndDate(edDate);	
   }

   function fn_delDate(){
	   	picker.setStartDate(null);
	   	picker.setEndDate(null);
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
  * function명   : fnView
  * function기능 : 에러 상세조회
  **********************************************************************************/
  function fnView(error_seq, process_state){
     $("#error_seq").val(error_seq);
	 $("#process_state").val(process_state);
	 $("#form1").attr("action", "${pageContext.request.contextPath}/sys/err/err00View.do");
	 $("#form1").submit();
  }
  
  /*********************************************************************************
  * function명   : goPage
  * function기능 : 페이지이동
  **********************************************************************************/
  function goPage(cPage){
     $("#cPage").val(cPage);
	 $("#form1").attr("action", "${pageContext.request.contextPath}/sys/err/err00List.do");
	 $("#form1").submit();
  }
</script>
</body>
</html>