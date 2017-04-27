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
<body>
<div id="warpper">
	<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
		<jsp:include page="/resources/com/inc/header.jsp" />
		<%@ include file="/WEB-INF/views/letech/com/layout/menu.jsp" %>
	</nav>
	<div class="" id="page-wrapper">
		<section class="row">
			<div class="col-lg-10">
				<form name="form1" id="form1" method="post" action="<%=request.getContextPath()%>/sys/mnm/mnm01List.do" >
					<input type="hidden" id="menu_id1" name="menu_id1" value="${params.menu_id1}"/>
					<input type="hidden" id="menu_id2" name="menu_id2" value="${params.menu_id2}"/>
					<input type="hidden" id="mode" name="mode" value="<%=VarConsts.MODE_I%>" />
					<input type="hidden" name="mn" id="mn" value=""  /> 
					<input type="hidden" id="levl" name="levl" value="" />
					<input type="hidden" id="up_mn" name="up_mn" value="" />
					<input type="hidden" id="flag" name="flag" value="1" />
					<!-- 타이틀 및 페이지 네비 -->
					<h2 class="page-title clearfix">
						${titleNaviMap.MN_NM }
						<span class="pull-right site-map">
							HOME > ${titleNaviMap.NAVI_NM }
						</span>
					</h2>
	
					<!-- page -->
					<div class="form-container">
					<div class="row">
						<div class="col-md-5">
						<div class=" panel panel-warning">
								<h3 class="panel-title panel-heading clearfix">메뉴구조
								<span class="page_navi pull-right">
									<a href="#" class="btn btn-xs btn-warning" onclick="fnInsert('1');">메뉴추가</a>
								</span>
							</h3>
							<div class="panel-body">
							<ul id="tree1">
							<c:choose>
								<c:when test="${fn:length(resultList) > 0 }">
								<li><a href="#"> HOME</a>
									<ul>
									<c:set var="levelVar" value="1" />
										<c:forEach var="result" items="${resultList }" varStatus="status">
											<c:choose>
										<c:when test="${status.count == 1 }">	
										<li <c:if test="${result.USE_YN eq 'N' }">class="off"</c:if> > 
											<a href="#" onclick="fnFrom('${result.MN}')">${result.MN_NM }</a>
										</c:when>
										<c:when test="${status.last }" >
										<c:if test="${levelVar == result.LEVEL }">
										</li>
										<li <c:if test="${result.USE_YN eq 'N' }">class="off"</c:if> > 
											<a href="#" onclick="fnFrom('${result.MN}')">${result.MN_NM }</a>
										</c:if>
										<c:if test="${levelVar < result.LEVEL }">
											<ul>
												<li <c:if test="${result.USE_YN eq 'N' }">class="off"</c:if> > 
													<a href="#" onclick="fnFrom('${result.MN}')">${result.MN_NM }</a>
										</c:if>
										<c:if test="${levelVar > result.LEVEL }">
												<c:forEach begin="${result.LEVEL }" end="${levelVar-1 }" step="1">
												</li>
											</ul>
										</c:forEach>
										</li>
										<li <c:if test="${result.USE_YN eq 'N' }">class="off"</c:if> > 
											<a href="#" onclick="fnFrom('${result.MN}')">${result.MN_NM }</a>
									</c:if>
									<c:forEach begin="${result.LEVEL }" end="${levelVar }" step="1">
										</li>
											</ul>
									</c:forEach>
									<c:forEach begin="${levelVar}" end="${result.LEVEL }" step="1">
												</li>
											</ul>
									</c:forEach>
					</c:when>
					<c:when test="${levelVar == result.LEVEL }">
										</li>
										<li <c:if test="${result.USE_YN eq 'N' }">class="off"</c:if> > <a href="#" onclick="fnFrom('${result.MN}')">${result.MN_NM }</a>
					</c:when>
					<c:when test="${levelVar < result.LEVEL }">
											<ul>
												<li <c:if test="${result.USE_YN eq 'N' }">class="off"</c:if> > <a href="#" onclick="fnFrom('${result.MN}')">${result.MN_NM }</a>
					</c:when>
					<c:when test="${levelVar > result.LEVEL }">
						<c:forEach begin="${result.LEVEL }" end="${levelVar-1 }" step="1">
												</li>
											</ul>
						</c:forEach>
										</li>
										<li <c:if test="${result.USE_YN eq 'N' }">class="off"</c:if> > <a href="#" onclick="fnFrom('${result.MN}')">${result.MN_NM }</a>
					</c:when>
				</c:choose>
				<c:set var="levelVar" value="${result.LEVEL }" />
			</c:forEach>
		</c:when>
		<c:otherwise>
								<li>
									등록된 메뉴가 없습니다.
								</li>
		</c:otherwise>
	</c:choose>
	</div>
	</div>
	</div>
						<div class="col-md-7 tree_menu_box">
							<div class="panel panel-warning">
							<h3 class="panel-heading panel-title clearfix" id="tree_titme_form">메뉴 추가</h3>
									<div class="tree_w panel-body">
										<div class="form_group">
											<div class="form-group">
												<label class="">메뉴명</label>
												<input class="form-control " name="mn_nm" id="mn_nm" type="text" value="" />	
											</div>
											<div class="form-group">
												<label class="">메뉴타입<br/></label>
												<select id="mn_type" class="form-control" name="mn_type">
													<option value="" >--선택--</option>
										<c:forEach var="codeList" items="${codeList}">
													<option value="${codeList.CD}" >${codeList.CD_NM}</option>
										</c:forEach>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label class="">메뉴 선택값(***Mng)<br/></label>
											<input class="form-control" name="mn_val" id="mn_val" type="text" value="" />	
										</div>
										<div class="form-group">
											<label class="">정렬순서<br/></label>
											<input class="form-control" name="mn_ord" id="mn_ord" type="text"  />	
										</div>
										<div class="form-group">
											<label class="">메뉴 URL(1레멜의 경우 필요없음)<br/></label>
											<input class="form-control" name="mn_href" id="mn_href" type="text"  />	
										</div>
										<p class="clearfix">
											<span class="pull-right">
												<a href="#submit" class="btn_ok btn btn-warning" ><span>저장</span></a>
												<a href="#delete" class="btn_del btn btn-default" ><span>삭제</span></a>
			<!-- 								<a href="#cancel" class="btn btn_default"><span>닫기</span></a> -->
											</span>
										</p>
									</div>		
								</div>
								</div>
						<!-- 상세, 등록, 수정 폼 End -->
					</div>
				<!-- tree 테스트 -->
	
			</div>
		</form>
	<div class="pop_bg">
		<div class="popup">
			<a href="#" class="close" title="창닫기"></a>
	 		<iframe id="iframe" name="iframe" src="" frameborder="0" scrolling="no"></iframe>
		</div>
	</div>
				
</div>
<jsp:include page="/resources/com/inc/aside.jsp" />
</section>
</div>
	 <jsp:include page="/resources/com/inc/footer.jsp" />
</div>

<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
function fnFrom(mn){
	$.ajax({
		url: "<%=request.getContextPath()%>/sys/mnm/mnm00Ajax.do",
		type: "post",
		dataType : "json", 
		data : {"mn":mn},
		success: function(result){
			$("#mn").val(result.getCodeView.MN);
			$("#mn_nm").val(result.getCodeView.MN_NM);
			$("#mn_type").val(result.getCodeView.MN_TYPE);
			$("#mn_val").val(result.getCodeView.MN_VAL);
			$("#mn_ord").val(result.getCodeView.MN_ORD);
			$("#mn_href").val(result.getCodeView.MN_HREF);
			$("#mode").val("<%=VarConsts.MODE_U%>");
			$("#tree_titme_form").text(result.getCodeView.MN_NM+" 메뉴 수정 ");
			$("#tree_titme_form").append("<span class=\"page_navi pull-right\" ><a href=\"#\" class=\"btn btn-xs btn-warning\"  onclick=\"fnInsert('2');\">하위 메뉴추가</a></span>");
		},error: function (request, status, error) {
			alert(request.responseText);
		} 
	});
}

function fnInsert(type){
	if(type == "1"){
		$("#mn").val("");
		$("#mode").val("<%=VarConsts.MODE_I%>");
		$("#flag").val(type);
		$("#tree_titme_form").text(" 메뉴 추가");	
	}else{
		$("#mode").val("<%=VarConsts.MODE_I%>");
		$("#flag").val(type);
		$("#tree_titme_form").text($("#mn_nm").val()+" 하위메뉴 추가");	
	}
	$("#mn_nm").val("");
	$("#mn_type").val("");
	$("#mn_val").val("");
	$("#mn_ord").val("");
	$("#mn_href").val("");
}

function fnEnt(){
	if($("#mode").val() == "<%=VarConsts.MODE_I%>"){
		alert("저장되었습니다.");
		$("#form1").submit();	
	}else if($("#mode").val() == "<%=VarConsts.MODE_U%>"){
		alert("수정되었습니다.");
		$("#form1").submit();	
// 		fnFrom($("#mn").val());
	}else if($("#mode").val() == "<%=VarConsts.MODE_D%>"){
		alert("삭제되었습니다.");
		$("#form1").submit();
	}
}

$(document).ready(function(){
	$(".btn_ok").click(function(){
		$.ajax({
			url: "<%=request.getContextPath()%>/sys/mnm/mnm01Tran.do",
			type: "post",
			dataType : "json", 
			data : $("#form1").serialize(),
			success: function(result){
				fnEnt();
			},error: function (request, status, error) {
				alert(request.responseText);
			} 
		});
	});
	
	$(".btn_del").click(function(){
		if(confirm('하위코드도 모두 삭제됩니다. 삭제하시겠습니까?')){
			$("#mode").val("<%=VarConsts.MODE_D%>");
			$.ajax({
				url: "<%=request.getContextPath()%>/sys/mnm/mnm01Tran.do",
				type: "post",
				dataType : "json", 
				data : $("#form1").serialize(),
				success: function(result){
					fnEnt();
				},error: function (request, status, error) {
					alert(request.responseText);
				} 
			});
		}
	});
	
<c:if test="${not empty params.mn}">
	fnFrom('${params.mn}');
</c:if>
});

/*tree Start*/
$.fn.extend({
    treed: function (o) {
      
      var openedClass = 'glyphicon-minus-sign';
      var closedClass = ' glyphicon-plus-sign';
      
      if (typeof o != 'undefined'){
        if (typeof o.openedClass != 'undefined'){
        openedClass = o.openedClass;
        }
        if (typeof o.closedClass != 'undefined'){
        closedClass = o.closedClass;
        }
      };
      
        //initialize each of the top levels
        var tree = $(this);
        tree.addClass("tree");
        tree.find('li').has("ul").each(function () {
            var branch = $(this); //li with children ul
            branch.prepend("<i class='indicator glyphicon " + closedClass + "'></i>");
            branch.addClass('branch');
            branch.on('click', function (e) {
                if (this == e.target) {
                    var icon = $(this).children('i:first');
                    icon.toggleClass(openedClass + " " + closedClass);
                    $(this).children().children().toggle();
                }
            })
            branch.children().children().toggle();
        });
        //fire event from the dynamically added icon
      tree.find('.branch .indicator').each(function(){
        $(this).on('click', function () {
            $(this).closest('li').click();
//             alert("2");
        });
      });
        //fire event to open branch if the li contains an anchor instead of text
        tree.find('.branch>a').each(function () {
            $(this).on('click', function (e) {
                $(this).closest('li').click();
                e.preventDefault();
//                 alert("3");
            });
        });
        //fire event to open branch if the li contains a button instead of text
        tree.find('.branch>button').each(function () {
            $(this).on('click', function (e) {
                $(this).closest('li').click();
                e.preventDefault();
//                 alert("4");
            });
        });
    }
});

//Initialization of treeviews
// $('#tree1').treed();
$('#tree1').treed({openedClass : 'glyphicon-folder-open', closedClass : 'glyphicon-folder-close'});
/*tree End*/


</script>
</body>
</html>