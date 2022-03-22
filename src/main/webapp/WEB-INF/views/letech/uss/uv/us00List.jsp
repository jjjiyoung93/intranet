<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
   <jsp:include page="/resources/com/inc/meta.jsp" />
   <title>Letech Intranet</title>
   <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/common.css">
</head>

<body>
   <div id="wrapper">
      <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
         <jsp:include page="/resources/com/inc/header.jsp" />
         <%@ include file="/WEB-INF/views/letech/com/layout/menu.jsp" %>
      </nav>
      <div id="page-wrapper">
         <section class="row">
            <div class="col-lg-10">
            <!-- page -->
               <form name="frm1" id="frm1" method="post" action="${pageContext.request.contextPath}/uss/umt/uss00List.do" >
                  <input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}" />
                  <input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}" />
                  <input type="hidden" id="cPage" name="cPage" value="${cPage }" />
                  <!-- 타이틀 및 페이지 네비 -->
                        <h2 class="page-title clearfix">
                        ${titleNaviMap.MN_NM }
                        <span class="pull-right site-map">
                           HOME > ${titleNaviMap.NAVI_NM }
                        </span>
                     </h2>
                     <div class="form-container">
                        <div class="clearfix search-box form-inline">
                           <input type="hidden" name="uss_id" id="uss_id" value=""/>
                           <div class="row">
                              <div class ="col-md-6 un-style form-inline mt10">
                                 <span class="inline-element col-md-8 col-md-offset-2"  >
                                    <label>성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명</label>&nbsp;
                                    <input type="text" name="searchField" id="searchField"  value="${params.searchField}" class="form-control" style="inline-block; width : 265px;" title="검색어 입력" />
                                 </span>
                              </div>
                              <div class ="col-md-6 un-style form-inline mt10">
	                              <span class="inline-element col-md-8 col-md-offset-2">
	                              <label >프로젝트</label>&nbsp;
	                              <select name="searchGubun6" id="searchGubun6" class="form-control" title="search" style="width : 265px;" >
	                              <option value="" >전체</option>
	                              <c:forEach var="proj" items="${projList}" varStatus="status">
	                              <option value="${proj.CD}" <c:if test="${proj.CD eq params.searchGubun6 }">selected="selected"</c:if> >${proj.CD_NM}</option>
	                              </c:forEach>
	                              </select>
	                              </span>
                              </div>
                           </div>
                           
                           <div class="row">
                              <div class ="col-md-6 un-style form-inline mt10">
                                 <span class="inline-element col-md-8 col-md-offset-2">
                                    <label>소속부서</label>&nbsp;
                                    <select id="searchCdList4" style="width: 125px; font-size: 12px; display:inline-block;" name="searchCdList4" class="form-control" onchange="javascript:fn_dp2List(this.value)">
											<option value="" >--전체--</option>
											<c:forEach var="dp" items="${dpList}">
												<option value="${dp.CD}" <c:if test="${dp.CD eq params.searchCdList4 }">selected="selected"</c:if> >${dp.CD_NM}</option>
											</c:forEach>
								</select>
								<!-- 소속2  -->
								<!-- <label style="font-size: 14px; padding: 0px;">하위부서</label>	 -->
								<select id="searchCdList5" style="width: 125px; font-size: 12px; display:inline-block;" name="searchCdList5" class="form-control">
											<option value="" >--전체--</option>
											
								</select>
								
<!--                                     <select name="searchGubun4" id="searchGubun4" class="form-control" title="search" style="font-size: 12px; width: 125px;display:inline-block; margin-right: 10px;" > -->
<!--                                        <option value="" >전체</option> -->
<%--                                        <c:forEach var="departList" items="${departList}"> --%>
<%--                                           <option value="${departList.DP_CD}" <c:if test="${departList.DP_CD eq params.searchGubun4 }">selected="selected"</c:if> >${departList.DP_NM}</option> --%>
<%--                                        </c:forEach> --%>
<!--                                     </select> -->
<!--                                     <select name="searchGubun4" id="searchGubun4" class="form-control" title="search" style="font-size: 12px; width: 125px; display:inline-block;" > -->
<!--                                        <option value="" >전체</option> -->
<%--                                        <c:forEach var="departList" items="${departList}"> --%>
<%--                                           <option value="${departList.DP_CD}" <c:if test="${departList.DP_CD eq params.searchGubun4 }">selected="selected"</c:if> >${departList.DP_NM}</option> --%>
<%--                                        </c:forEach> --%>
<!--                                     </select> -->
                                 </span>
                              </div>
                              
                              <div class ="col-md-6 un-style mt10">
                                 <div class="col-md-12">
                                    <div class ="un-style col-md-12 form-inline">
                                       <span class="inline-element"  style="float : right;">
                                          <button type="button" class="fnSearch btn-info btn"  >
                                          	<i class="glyphicon glyphicon-search"></i><span class="hidden-xs hidden-sm"> 검색</span>
                                          </button>
                                       </span>
                                    </div>
                                 </div>
                              </div>
                           </div> <!-- row 끝 -->
                        </div><!-- div from inline 끝 -->
                  <!--    </div> -->
                  <div class="table-responsive">
                  <table class="table table-bordered" summary="사용자 목록">
                     <colgroup>
                        <%-- <col width="5%" />
                        <col width="10%" />
                        <col width="15%" />
                        <col width="10%" />
                        <col width="5%" />
                        <col width="5%" />
                        <col width="15%" />
                        <col width="15%" />
                        <col width="5%" /> --%>
                     </colgroup>
                     <thead>
                        <tr>
                           <th class="visible-md visible-lg" style="vertical-align: middle;">번호</th>
                           <th style="vertical-align: middle;">성명(ID)</th>
                           <th style="vertical-align: middle;">직급</th>
                           <th style="vertical-align: middle;">부서</th>
                           <th style="vertical-align: middle;">프로젝트</th>
                           <th class="visible-md visible-lg" style="vertical-align: middle;">이메일</th>
                           <th class="visible-md visible-lg" style="vertical-align: middle;">전화번호</th>
                        </tr>
                     </thead>
                     <tbody>
                        <c:choose>
                           <c:when test="${totalCnt < 1 }">
                              <tr>
                                 <td colspan="7">검색된 내용이 없습니다.</td>
                              </tr>
                           </c:when>
                           <c:otherwise>
                              <c:forEach var="list" items="${resultList}" varStatus="status">
                                 <tr>
                                    <th style="vertical-align: middle;" class="visible-md visible-lg text-center">${totalCnt - status.index - ((cPage-1) * (intListCnt))}</th>
                                    <td style="vertical-align: middle;" align="center">${list.USS_NM}(${list.USS_ID})</td>
                                    <td style="vertical-align: middle;" align="center">${list.USS_AUTH_NM}</td><!-- 직급 -->
                                    <td style="vertical-align: middle;" align="center">${list.DP_NM}</td><!-- 부서 -->
                                    <td style="vertical-align: middle;" align="center">${list.DP_NM}</td><!-- 프로젝트 -->
                                    <td style="vertical-align: middle;" align="center" class="visible-md visible-lg">${list.USS_EMAIL}</td>
                                    <td style="vertical-align: middle;" align="center" class="visible-md visible-lg">${list.USS_TEL}</td>
                                 </tr>
                              </c:forEach>
                           </c:otherwise>
                     </c:choose>
                  </tbody>
               </table>
               </div>
               <div class="table_foot2">
                  <!-- pase nav-->
                  <div class="text-center">
                  	<br/>
                     <ul class="pagination pagination-sm">
                        ${pageNavigator }
                     </ul>
                  </div>
               </div>
               <div>
                  </div>
               </div>
            </form>
         </div>
         <jsp:include page="/resources/com/inc/aside.jsp" />
      </section>
   </div>
       <jsp:include page="/resources/com/inc/footer.jsp" />
   </div>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
	
	$(function(){
		var dpCd = "<c:out value='${params.searchCdList4}'/>";
		
		fn_dp2List(dpCd);
	});

	function fn_dp2List(val){
		var dp2Cd = '${params.searchCdList5}';
		
		var dpCd = val;
		
		$.ajax({
			type: 'post',
			data : {
				upCd : dpCd 
			},
			url : "${pageContext.request.contextPath}/aprv/getCdList.do",
			dataType : 'json',
			success : function (data){
				var params = data.params;
				var cdList = data.cdList;
				var html = '';
				$(".cdList").remove();
				for(var i in cdList){
					var cd = cdList[i];
					html += '<option class="cdList" value="'+cd.CD+'" id="'+cd.CD+'">'+cd.CD_NM+'</option>';
				}
				$("#searchCdList5").append(html);
				$("#"+dp2Cd).prop('selected', true);
			},error: function (request, status, error) {
		         alert(request.responseText);
		    } 
		});
	}
   /* 검색 */
   $( ".fnSearch" ).click(function() {
      goPage(1);
   });

   /*sub_menu 탭*/
   $(function(){
      $("article.sub_contents:not("+$("ul.tab_gnb li a.sub_nav_on").attr("href")+")").hide()
      $("ul.tab_gnb li a").click(function(){
         $("ul.tab_gnb li a").removeClass("sub_nav_on");
         $(this).addClass("sub_nav_on");
         $("article.sub_contents").hide();
         $($(this).attr("href")).show();
         return false;
      });
   });

</script>
</body>
</html>