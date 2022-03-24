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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/jstree-bootstrap-theme@1.0.1/dist/themes/proton/style.min.css" />
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
                           <label>코&nbsp;&nbsp;&nbsp;&nbsp;드</label>&nbsp;
                           <input type="text" name="searchField" id="sear_cd" value="${params.searchGubun1}" class="form-control" style="inline-block;" title="검색어 입력" />
                        </span>
                     </div>
                     <div class ="col-md-6 un-style form-inline mt10">
	                     <span class="inline-element col-md-8 col-md-offset-2">
		                     <label >코드명</label>&nbsp;
		                     <input type="text" name="searchField" id="sear_cd_nm"  value="${params.searchGubun2}" class="form-control" style="inline-block;" title="검색어 입력" />
	                     </span>
                     </div>
                  </div>
                  <div class="row">
                     <div class ="col-md-6 un-style form-inline mt10">
                        <span class="inline-element col-md-8 col-md-offset-2">
                           <label>코드값</label>&nbsp;
                           <input type="text" name="searchField" id="sear_cd_val"  value="${params.searchGubun3}" class="form-control" style="inline-block;" title="검색어 입력" />
                        </span>
                     </div>
                     <div class ="col-md-6 un-style mt10">
                        <div class="col-md-12">
                           <div class ="un-style col-md-12 form-inline" style="float:right;">
                              <span class="inline-element" style="float:right;">
                                 <button type="button" class="fnSearch btn-info btn" id="clear" onclick="btn_clear()">
                                    <span class="hidden-xs hidden-sm"> 초기화</span>
                                 </button>
                                 <button type="button" class="fnSearch btn-info btn" id="search" >
                                 	<i class="glyphicon glyphicon-search"></i><span class="hidden-xs hidden-sm"> 검색</span>
                                 </button>
                              </span>
                           </div>
                        </div>
                     </div>
                  </div>
               </div><!-- 검색 div 끝 -->
               
               <p class="clearfix">
                  <span class="pull-right">
                     <input type="button" class="button-a btn btn-sm btn-default" onclick="codeInsert();" value="코드등록">
                  </span>
               </p>
               <div class="row">
                  <div class="col-md-5">
                     <div class=" panel panel-default">
                        <h3 class="panel-title panel-heading clearfix">코드구조</h3>
                        <!-- jstree -->
                        <div class="panel-body" id="tree">
                        </div><!-- pannel body 끝 -->
                     </div>
                  </div><!-- 코드구조 끝 -->
                  
                  <!-- 하위메뉴 -->
                  <div class="col-md-7 tree_menu_box" id="menu_box">
	                  <!-- 테이블 -->
                  </div>   <!-- 하위메뉴 끝 -->
              </div>
			  <p class="clearfix">
				 <span class="pull-right">
				  	<input type="button" class="button-a btn btn-sm btn-default" onclick="codeInsert();" value="코드등록">
				 </span>
			  </p>
            <!-- page nav -->
            </div><!-- container 끝 -->
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
	get00Table();
})

function getTree() {
	
	var cd = $('#sear_cd').val();
	var cd_nm = $('#sear_cd_nm').val();
	var cd_val = $('#sear_cd_val').val();
	console.log('cd', cd, 'cd_nm', cd_nm, 'cd_val', cd_val);
	
	$.ajax({
		type	 : 'get',
		url  	 : '<%=request.getContextPath() %>/sys/cdm/jstreeAjax.do',
		data	 : {cd : cd , cd_nm : cd_nm, cd_val : cd_val},
		dataType : 'json',
		success  : function(json){
			var list = new Array();
			//데이터 받아옴
			var data = json.resultList;
			
			let cd_val = [];
			var text;
			$.each(data, function(i, v){
				
				if(v.CD_VAL == undefined) {
					cd_val[i] = '';
				}else {
					cd_val[i] = v.CD_VAL;
				}
				
				text = v.CD_NM + '(' + v.CD + ')';
				list[i] = {id : v.CD, parent : v.UP_CD, text : text}
			});
			
			//트리 생성	
			$('#tree').jstree({
				'plugins' : [ "search" ], //검색, 테마
				'core' : {
					//데이터 연결
					'data'		: list,
					'themes'	: {
						name : "proton",
						responsive : true
					}
				}
			}); //트리 생성 끝

			//검색
			var to = false;
			
			//keyup시 검색
//			$('#sear_cd_nm').keyup(function(){
//				if(to) {
//					clearTimeout(to);
//				}
//				to = setTimeout(function(){
//					var v = $('#sear_cd_nm').val();
//					$('#tree').jstree(true).search(v);
//					}, 250);
//			});
//			
//			$('#sear_cd').keyup(function(){
//				if(to) {
//					clearTimeout(to);
//				}
//				to = setTimeout(function(){
//					var v = $('#sear_cd').val();
//					$('#tree').jstree(true).search(v);
//				}, 250);
//			});
			
			//검색 버튼 클릭 시 검색
//			$('#search').click(function(){
//				console.log('d');
//				if(to) {
//					clearTimeout(to);
//				}
//				console.log($('#sear_cd_nm').val());
//				console.log($('#sear_cd').val());
//				to = setTimeout(function(){
//					if($('#sear_cd').val() != '') {
//						var v = $('#sear_cd').val();
//						$('#tree').jstree(true).search(v);
//					}
//					if($('#sear_cd_nm').val() != '') {
//						var v1 = $('#sear_cd_nm').val();
//						$('#tree').jstree(true).search(v1);
//					}
//				}, 250);
//			})
			
			$('#search').click(function(){
				if(to) {
					clearTimeout(to);
				}
				to = setTimeout(function(){
					var v = $('#sear_cd_nm').val();
					var v1 = $('#sear_cd').val();
					$('#tree').jstree(true).search(v);
					
					console.log('???',$('#tree').jstree(true).search(v));
				}, 250);
				
				console.log('?', $('#tree').jstree('get_selected', true));
			});
			
			//초기화
			$('#clear').click(function(){
				$("#sear_cd").val('');
				$("#sear_cd_nm").val('');
				$("#sear_cd_val").val('');
				
				$('#tree').jstree("close_all");
				get00Table();
				
			});
			
		} //success 끝

	}); //ajax 끝
}

$('#tree').bind("click.jstree", function(event, data){
	console.log("Binde Result : ", event.type);
});

$('#tree').bind("select_node.jstree", function(event, data){
	var id = data.instance.get_node(data.selected).id; 
	console.log(id);
	get01Table();
});

//초기 하위메뉴 테이블
function get00Table() {
	
	$('#menu_box').empty();

	var html = '';
		
		html += '<table class="table table-bordered">'
		html += '<colgroup>'
		html += '<col width="30%"  />'
		html += '<col width="30%"  />'
		html += '<col width="*"  />'
		html += '</colgroup>'
		html += '<thead class="table-light ag_left">'    
		html += '<tr>'
		html += '<th>코드</th>'
		html += '<th>코드명</th>'
		html += '<th>코드값</th>'
		html += '</tr>'
		html += '</thead>'
		html += '<tbody class="ag_left">'
		html += '<tr>'
		html += '<td colspan="3" align="center">코드를 클릭하세요.</td>'
		html += '</tr>'
		html += '</tbody>'
		html += '</table>'
		
		$('#menu_box').append(html);
	
}

//코드 클릭 시 하위메뉴 테이블
function get01Table() {
	
	$('#menu_box').empty();
	
	var html = '';

		html += '<table class="table table-bordered">'
		html += '<colgroup>'
		html += '<col width="30%"  />'
		html += '<col width="30%"  />'
		html += '<col width="*"  />'
		html += '</colgroup>'
		html += '<thead class="table-light ag_left"> '           
		html += '<tr>'
		html += '<th>코드</th>'
		html += '<th>코드명</th>'
		html += '<th>코드값</th>'
		html += '</tr>'
		html += '</thead>'
		html += '<tbody class="ag_left">'
		html += '<tr>'
		html += '<td align="center">'
		html += '<a href="javascript:codeView()">CD0001001</a>'
		html += '</td>'
		html += '<td>업무보고</td>'
		html += '<td>100</td>'
		html += '</tr>'
		html += '<tr>'
		html += '<td align="center">'
		html += '<a href="javascript:codeView()">CD0001007</a>'
		html += '</td><!-- 코드 -->'
		html += '<td>지출결의</td><!-- 코드명 -->'
		html += '<td></td><!-- 코드값 -->'
		html += '</tr>'
		html += '<tr>'
		html += '<td align="center">'
		html += '<a href="javascript:codeView()">CD0001008</a>'
		html += '</td><!-- 코드 -->'
		html += '<td>품위</td><!-- 코드명 -->'
		html += '<td></td><!-- 코드값 -->'
		html += '</tr>'
		html += '<tr>'
		html += '<td align="center">'
		html += '<a href="javascript:codeView()">CD0001009</a>'
		html += '</td><!-- 코드 -->'
		html += '<td>출장</td><!-- 코드명 -->'
		html += '<td></td><!-- 코드값 -->'
		html += '</tr>'
		html += '<tr>'
		html += '<td align="center">'
		html += '<a href="javascript:codeView()">CD0001011</a>'
		html += '</td><!-- 코드 -->'
		html += '<td>휴가신청</td><!-- 코드명 -->'
		html += '<td></td><!-- 코드값 -->'
		html += '</tr>'
		html += '<tr>'
		html += '<td align="center">'
		html += '<a href="javascript:codeView()">CD0001012</a>'
		html += '</td><!-- 코드 -->'
		html += '<td>휴직신청</td><!-- 코드명 -->'
		html += '<td></td><!-- 코드값 -->'
		html += '</tr>'
		html += '<tr>'
		html += '<td align="center">'
		html += '<a href="javascript:codeView()">CD0001013</a>'
		html += '</td><!-- 코드 -->'
		html += '<td>유연근무제신청</td><!-- 코드명 -->'
		html += '<td></td><!-- 코드값 -->'
		html += '</tr>'
		
		html += '</tbody>'
		html += '</table>'

		$('#menu_box').append(html);
}
//$('#search').click(function(){
//	getTree();
//});

//function goPage(){
//	$("#form1").attr("action", "${pageContext.request.contextPath}/sys/cdm/list.do");
//	$("#form1").submit();
//}

/* 상세조회 */
function codeView() {
	window.open('getCodeForm.do?flag=2&cd=CD0001','target_name','scrollbars=yes,toolbar=yes,resizable=yes,width=500,height=400,left=750,top=250');
}

/* 등록조회 */
function codeInsert() {
	window.open('getCodeForm.do?flag=1&cd=','target_name','scrollbars=yes,toolbar=yes,resizable=yes,width=500,height=400,left=750,top=250');
}

</script>
</body>
</html>