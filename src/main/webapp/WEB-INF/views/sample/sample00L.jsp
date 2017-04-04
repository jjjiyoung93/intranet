<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>layout2-html5</title>
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
 <form name="frm1" id="frm1" method="post" action="<%=request.getContextPath()%>/sample/list.do" >
<input type="hidden" name="file1" id="file1" value=""/>
<input type="hidden" name="file2" id="file2" value=""/>
<input type="hidden" name="seq_no" id="seq_no" value=""/>
<input type="hidden" name="flag" id="flag" value=""/>
<input type="hidden" name="nt_id" id="nt_id" value="${params.nt_id}"/>
 <h4 id="b_tlt"><span></span></h4> 
 <p class="left " style="text-align: right;"><strong style="font-size: 12px;">Total : ${totalCnt} 건</strong></p>
 
t1: ${resultList.t1}
<br>
t2: ${resultList.t2}
<br>
t3: ${resultList.t3}
<br>
<div>
결제구분코드:
<select id="cdList1" name="cdList1">
		<option value="" >--선택--</option>
	<c:forEach var="codeList" items="${codeList}">
		<option value="${codeList.CD}" >${codeList.CD_NM}</option>
	</c:forEach>
</select>
하위구분코드:
<select id="cdList2" name="cdList2">
		<option value="" >--선택--</option>
</select>
</div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"  summary="게시판 검색 입니다." >
			 <tbody>		
				<tr>
					<td class="ri">
						<fieldset>
							<select name="searchGubun" id="searchGubun" class="search" title="search">
								<option value="01" <c:if test="${params.searchGubun == '01'}">selected = "selected"</c:if>>
								제목
								</option>
								<option value="02" <c:if test="${params.searchGubun == '02'}">selected = "selected"</c:if>>
								내용
								</option>
							</select>
							<input type="text" name="searchField" id="searchField" value="${params.searchField}" size="20" title="검색어 입력" />
							<input type="button" onclick="fnSearch();" value="검색" title="검색" />
						</fieldset>
					</td>
				</tr>
			</tbody>
		</table>
		<table>
        <thead>
        	<tr>
				<th>제목</th>
				<th>내용</th>
				<th>작성자</th>
            </tr>
        </thead>
        <tbody>
        	<c:choose>
				<c:when test="${totalCnt < 1 }">
					<tr>
						<td colspan="3">
							검색된 내용이 없습니다.
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="list" items="${getList}" varStatus="status">
						<tr>
							<td style="text-align: left;">&nbsp;
								<a href="javascript:fnView('${list.seq}');">
									${list.SAMPLE1}
								</a> 
							</td>
							<td>
								${list.SAMPLE2}
							</td>
							<td>
								${list.SAMPLE3}
							</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
        </tbody>
        </table>
 		<br>
		 <div class="table_foot2">
            <!-- pase nav-->
            
			<p class="page_nav" style="text-align: center;">
				<strong>
				<%=(String)request.getAttribute("pageNavigator")%>
				</strong>
			</p>
        </div>
 		<br>
        <div>
	<input type="text" value="제목"   id="smaple1" name="sample1">
	<input type="text" value="내용"   id="smaple2" name="sample2">
	<input type="text" value="작성자" id="sample3" name="sample3">
	<input type="button" value="등록" onclick="javascript:fnJoin();">
</div>
</form>
	</section>
    <footer>footer</footer>
</div>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">

//select box 선택 기능
$("#cdList1").change(function(){
	$("#cdList2").find('option').each(function(){
		$(this).remove();	
	});
	
	$("#cdList2").append("<option value=''>--선택--</option>");
	
	var selectVal = $(this).val();
	
	if(selectVal != ""){
		$.ajax({
				type:'get',
				url:'/sys/cdm/getCodeList.do?cd='+selectVal,
				dataType:'json',
				success: function(json){
					var data = json.codeList;
					if(data==null){
						data=0;
					}
					for(var i=0; i<data.length; i++){
						$("#cdList2").append("<option value='"+ data[i]['CD_VAL'] + "'>" + data[i]['CD_NM'] + "</option>");
					}
				}
		});
	}
	
});


/* 등록 */
function fnJoin(){
	
	var cdval = $("#cdList2").val();
	alert(cdval);
	//document.frm1.action = "insert.do";	
	//document.frm1.submit();	
}

/* 글보기 */
function fnView(seq){
	
	$("#seq_no").val(seq);
	document.frm1.action = "notice00V.do";
	document.frm1.submit();	
}

/*문서전체 키다운 onKeyDown*/
$(document).keydown(function(e){
	keyDown();
});
	
/* 키를 눌렀을 시 동작.*/
function keyDown(){
	if(event != null) {
		//엔터키
		if (event.keyCode==13){
			fnSearch();
			
		}
	}
}
function fnSearch(){
	//document.frm1.action = "notice00L.do";
	document.frm1.submit();
	
}

</script>
</body>
</html>