<!doctype html>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
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
<%--     <jsp:include page="/resources/comm/usr/header.jsp" /> --%>
<%--     <jsp:include page="/resources/comm/usr/menu.jsp" /> --%>
    <section>
    		<style scoped>
  table { border-collapse: collapse; border: solid thick ; width: 100%;}
  colgroup, tbody { border: solid medium; }
  td { border: solid thin;  text-align: center; padding: 0; }
 </style>
 <form name="frm1" id="frm1" method="post" action="<%=request.getContextPath()%>/usr/notice00T.do" >
<input type="hidden" name="file2" id="file2" value=""/>
<input type="hidden" name="seq_no" id="seq_no" value=""/>
<input type="hidden" name="flag" id="flag" value="C"/>
<input type="hidden" name="nt_id" id="nt_id" value="${params.nt_id}"/>
 <h4 id="b_tlt"><span></span></h4> 
		<table>
			<tr>
				<th>
					??????
				</th>
				<td>
					<input type="text" id="nt_title" name="nt_title">
				</td>
			</tr>
			<tr>
				<th>
					??????
				</th>
				<td>
					<textarea name="ir1" id="ir1" rows="10" cols="99" style="width:90%; height:312px;"></textarea>
				</td>
			</tr>
		</table>
		<br>
<div>
	<input type="button" value="??????" onclick="javascript:fnJoin();">
</div>
</form>
	</section>
    <footer>footer</footer>
</div>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/se2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
  
$(function() {
	var nt_id = $("#nt_id").val();
	if(nt_id == "nt1"){
		$("#b_tlt").html("?????????1");
	}else if(nt_id == "nt2"){
		$("#b_tlt").html("?????????2");
	}else if(nt_id == "nt3"){
		$("#b_tlt").html("?????????3");
	}
});
  
  
function fnJoin(){
	
	if(validation()){
		oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
		document.frm1.submit();	
	}else{
		alert("?????? ?????? ???????????????");
	}
}

function validation(){
	var nt_title = $("#nt_title").val();
	var cnt = nt_title.length;
	if(cnt < 4){
		alert("????????? ?????? 4??????????????????.");
		return false;
	}

	return true;
}
var oEditors = [];

//?????? ?????? ??????
//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];

nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "ir1",
	sSkinURI: "/se2/SmartEditor2Skin.html",	
	htParams : {
		bUseToolbar : true,				// ?????? ?????? ?????? (true:??????/ false:???????????? ??????)
		bUseVerticalResizer : true,		// ????????? ?????? ????????? ?????? ?????? (true:??????/ false:???????????? ??????)
		bUseModeChanger : true,			// ?????? ???(Editor | HTML | TEXT) ?????? ?????? (true:??????/ false:???????????? ??????)
		//aAdditionalFontList : aAdditionalFontSet,		// ?????? ?????? ??????
		fOnBeforeUnload : function(){
			//alert("??????!");
		}
	}, //boolean
	fOnAppLoad : function(){
		//?????? ??????
		//oEditors.getById["ir1"].exec("PASTE_HTML", ["????????? ????????? ?????? ????????? ???????????? text?????????."]);
	},
	fCreator: "createSEditor2"
});
</script>
</body>
</html>