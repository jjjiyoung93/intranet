<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Letech Intranet</title>
<style>

html,body{width:100%;height:100%}
html{overflow-y:scroll}
body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,form,fieldset,p,button{margin:0;padding:0}
body,h1,h2,h3,h4,input,button{font-family:NanumGothicWeb,verdana,dotum,Helvetica,sans-serif;font-size:13px;color:#383d41}
body{background-color:#fff;*word-break:break-all;-ms-word-break:break-all}
img,fieldset,iframe{border:0 none}
li{list-style:none}

#wrap{width:760px;margin:0 auto}
header{margin-top:20px;padding:20px;border:1px solid #000;background:#E8FFFF}
hgroup{overflow:hidden;padding-bottom:20px}
hgroup h1{float:left;font-size:18px;color:#fff}
hgroup h2{float:right;font-weight:normal;color:#fff;opacity:0.8}
nav{clear:both;overflow:hidden}
nav li{float:left;padding-right:5px;font-family:verdana}
nav li span{display:inline-block;padding:3px 10px;border-radius:5px;background-color:#fff}
section{float:left;width:715px;margin-top:15px;margin-bottom:20px;padding:20px;border:1px solid #ccc;line-height:20px}
article{margin-bottom:20px}
article h3{font-size:16px}
aside{float:right;width:163px;padding:10px;margin-top:15px;border:1px solid #ccc;line-height:20px}
aside .ad{height:100px;margin-bottom:20px;background-color:#ebebeb}
footer{clear:both;padding:20px;border:1px solid #ccc}

</style>
</head>

<body>
<div id="wrap">
<section>
	<style scoped>
	  table { border-collapse: collapse; border: solid thick ; width: 100%;}
	  colgroup, tbody { border: solid medium; }
	  td { border: solid thin;  text-align: center; padding: 0; }
	</style>
	
	<form name="frm1" id="frm1" method="post" action="${pageContext.request.contextPath}/uss/umt/uss00List.do" >
		<input type="hidden" name="cal_hol_seq" id="cal_hol_seq" value=""/>
	<h4 id="b_tlt"><span>휴일관리</span></h4> 
	<p class="left " style="text-align: right;"><strong style="font-size: 12px;">Total : ${totalCnt} 건</strong></p>
 
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>휴일명</th>
				<th>날짜</th>
			</tr>
		</thead>
		<tbody>
<c:choose>
	<c:when test="${totalCnt < 1 }">
			<tr>
				<td colspan="5">검색된 내용이 없습니다.</td>
			</tr>
	</c:when>
	<c:otherwise>
		<c:forEach var="list" items="${resultList}" varStatus="status">
			<tr>
				<td>${totalCnt - status.index - ((cPage-1) * (intListCnt))}</td>
				<td style="text-align: left;">&nbsp;
					<a href="javascript:fnView('${list.CAL_HOL_SEQ}');">${list.CAL_HOL_NM}</a> 
				</td>
				<td>${list.CAL_HOL_DT}</td>
			</tr>
		</c:forEach>
	</c:otherwise>
</c:choose>
		</tbody>
	</table>
	<br />
	<div class="table_foot2">
	<!-- pase nav-->
         
		<p class="page_nav" style="text-align: center;">
			<strong><%=(String)request.getAttribute("pageNavigator")%></strong>
		</p>
	</div>
	<br />
	<div>
		<input type="button" value="등록" class="fnJoin" />
	</div>
	</form>
</section>
<footer>footer</footer>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	/* 등록 */
	$( ".fnJoin" ).click(function() {
		$("#frm1").attr("action", "${pageContext.request.contextPath}/cal/hol00Form.do");
		$("#frm1").submit();
	});
});

/* 상세조회 */
function fnView(cal_hol_seq){
	$("#cal_hol_seq").val(cal_hol_seq);
	$("#frm1").attr("action", "${pageContext.request.contextPath}/cal/hol00View.do");
	$("#frm1").submit();
}

</script>
</body>
</html>