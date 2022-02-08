<%@ page contentType="text/html; charset=utf-8" language="java" errorPage="" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
			<aside>
	    	<%-- 	<div class="tab_box">
					<ul class="tab">
						<li class="col_md_4"><a href="#tab1" class="selected ">결제(<font id="aside_aprvCnt0"></font>)</a></li>
						<li class="col_md_4"><a href="#tab2" >반려(<font id="aside_aprvCnt3"></font>)</a></li>
						<li class="col_md_4"><a href="#tab3" >보류(<font id="aside_aprvCnt2"></font>)</a></li>
					</ul>
					<ul class="panel">
						<li id="tab1" class="tab_cont">
							<ul id="aside_aprv0">
							</ul>
						</li>
						<li id="tab2" class="tab_cont">
							<ul id="aside_aprv3">
							</ul>
						</li>
						<li id="tab3" class="tab_cont">
							<ul id="aside_aprv2">
							</ul>
						</li>
					</ul>
				</div>
	    		<div class="side_bottom">
	    			<div class="sch">
	    				<h3>Search</h3>
    					<form id="leftSchFrm" name="leftSchFrm" method="post" action="" onSubmit="return leftFnSearch();">
							<input type="hidden" id="leftSch_menu_id1" name="menu_id1" value="" />
							<input type="hidden" id="leftSch_menu_id2" name="menu_id2" value="" />
							<input type="hidden" id="leftSch_bbs_id" name="bbs_id" value="" />
    						<input type="hidden" name="searchGubun" id="appendedGubun" value="01" />
    						<fieldset>
    							<div class="row">
	    							<legend>검색</legend>
			    						<select id="selectbasic" name="selectbasic" class="col_md_12">
									     	<option value="">--선택--</option>
<!-- 									     	<option value="01">일정</option> -->
									     	<option value="02">결재</option>
									     	<option value="03">공지사항</option>
									     	<option value="04">커뮤니티</option>
									     	<option value="05">Tech</option>
									     	<option value="06">이모저모</option>
									    </select>
										<input id="appendedtext" name="searchField" class="col_md_10" placeholder="검색어를 입력해 주세요" type="text">
										<button class="btn-danger col_md_2 btn_sch" >
											<span class=""><img src="<%=request.getContextPath()%>/resources/images/layout/icon_sch.png" alt="검색"  > </span>
										</button>
									</div>
							</fieldset>
    					</form>
	    			</div> --%>
	    			<div class="col-lg-2 visible-lg">
	    				<div class="panel panel-brown">
	    					<div class="panel-heading text-center">
				    			<strong class="sky">${loginVO.name }(${loginVO.id})님 환영합니다.</strong>
	    					</div>
	    				</div>
	    			</div>
	    			<div class="col-lg-2 visible-lg">
							<div class="panel panel-brown">
								<div class="panel-heading">연차정보</div>
								<div class="panel-body">
									<div class="vct_box">
										<ul id="vct_info">
											
										</ul>
									</div>
								</div>
							</div>
						</div>
	    			
    				<div class="col-lg-2 visible-lg">
							<div class="panel panel-brown">
								<div class="panel-heading">공지사항</div>
								<div class="panel-body">
									<div class="notic_box">
										<ul id="noties_type">
											
										</ul>
									</div>
								</div>
							</div>
						</div>
<form id="aside_frm1" name="aside_frm1" method="post" action="${pageContext.request.contextPath}/bbs/bbs00View.do" >
	<input type="hidden" id="aside_menu_id1" name="menu_id1" value="MN0019" />
	<input type="hidden" id="aside_menu_id2" name="menu_id2" value="MN0020" />
	<input type="hidden" id="aside_bbs_id" name="bbs_id" value="BB0001" />
	<input type="hidden" id="aside_bbs_seq" name="bbs_seq" value="" />
</form>

</aside>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">	    	
/*aside	*/
$(function(){
	$("ul.panel li.tab_cont:not("+$("ul.tab li a.selected").attr("href")+")").hide()
	$("ul.tab li a").click(function(){
		$("ul.tab li a").removeClass("selected");
		$(this).addClass("selected");
		$("ul.panel li.tab_cont").hide();
		$($(this).attr("href")).show();
		return false;
	});
});
$(document).ready(function(){
	$(".left_fn_sch").click(function(){
		leftFnSearch();		
	});
	
	// 공지사항
	$.ajax({
			type:'post',
			url:'${pageContext.request.contextPath}/bbs/bbs00Ajax.do',
			dataType:'json',
			success: function(json){
				var data = json.notiesList;
				
				var ussVctInfo = json.ussVctInfo;
				var vctLeftDayCnt = ussVctInfo.VCT_LEFT_DAY;
				var vctUseDayCnt = 0;
				var vctGrntDay = 0;
				
				if(ussVctInfo.VCT_DAY_CNT != null && "" != ussVctInfo.VCT_DAY_CNT){
					vctUseDayCnt = ussVctInfo.VCT_DAY_CNT;
				}
				
				if(ussVctInfo.VCT_GRNT_DAY != null && "" != ussVctInfo.VCT_GRNT_DAY){
				vctGrntDay = ussVctInfo.VCT_GRNT_DAY;
				}
				
				
				var vctInf = '<li><a href="${pageContext.request.contextPath}/vct/vctInf00List.do" class="text-center"><strong class=\"sky\" id="vctDayCnt">연차 사용일 / 부여일 : '+vctUseDayCnt+' / '+vctGrntDay+'</strong></a></li>';
				$("#vct_info").append(vctInf);
				
				
				if(data==null){
					$("#noties_type").append("<li><strong class=\"sky\">공지사항 정보가 없습니다</strong></li>");
				}
				for(var i=0; i<data.length; i++){
					$("#noties_type").append("<li><a href=\"#\" onclick=\"goBbsPage('"+data[i]['BBS_SEQ']+"')\"><strong class=\"sky\">"+data[i]['TITLE']+"</strong><br /><span>"+data[i]['REG_DT']+"</span></a></li>");
				}
			}
	});
});

function leftFnSearch(){
	if($("#selectbasic").val() == ""){
		alert("검색 항목을 선택해 주세요.");
		$("#searchbasic").focus();
		return false;
	}
	
	if($("#appendedtext").val() == ""){
		alert("검색 내용을 선택해 주세요.");
		$("#appendedtext").focus();
		return false;
	}
	
	var val = $("#selectbasic").val();
	if(val == "01"){		// 일정 목록
		$("#leftSchFrm").attr("action", "");
		$("#leftSchFrm").submit();
	}else if(val == "02"){	// 결재목록
		$("#leftSch_menu_id1").val("MN0013");
		$("#leftSch_menu_id2").val("MN0014");
		$("#leftSchFrm").attr("action", "${pageContext.request.contextPath}/aprv/aprv00List.do");
		$("#leftSchFrm").submit();
	}else if(val == "03"){	// 결재목록
		$("#leftSch_menu_id1").val("MN0019");
		$("#leftSch_menu_id2").val("MN0020");
		$("#leftSch_bbs_id").val("BB0001");
		$("#leftSchFrm").attr("action", "${pageContext.request.contextPath}/bbs/bbs00List.do");
		$("#leftSchFrm").submit();
	}else if(val == "04"){	// 결재목록
		$("#leftSch_menu_id1").val("MN0019");
		$("#leftSch_menu_id2").val("MN0020");
		$("#leftSch_bbs_id").val("BB0002");
		$("#leftSchFrm").attr("action", "${pageContext.request.contextPath}/bbs/bbs00List.do");
		$("#leftSchFrm").submit();
	}else if(val == "05"){	// 결재목록
		$("#leftSch_menu_id1").val("MN0019");
		$("#leftSch_menu_id2").val("MN0020");
		$("#leftSch_bbs_id").val("BB0003");
		$("#leftSchFrm").attr("action", "${pageContext.request.contextPath}/bbs/bbs00List.do");
		$("#leftSchFrm").submit();
	}else if(val == "06"){	// 결재목록
		$("#leftSch_menu_id1").val("MN0019");
		$("#leftSch_menu_id2").val("MN0020");
		$("#leftSch_bbs_id").val("BB0004");
		$("#leftSchFrm").attr("action", "${pageContext.request.contextPath}/bbs/bbs00List.do");
		$("#leftSchFrm").submit();
	}
}

function goBbsPage(bbs_seq){
	$("#aside_bbs_seq").val(bbs_seq);
	$("#aside_frm1").submit();
}
</script>
			
	    	