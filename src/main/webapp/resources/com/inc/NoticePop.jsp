<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice-Popup</title>
<link href="<%=request.getContextPath()%>/resources/css/bootstrap.min.css" rel="stylesheet">

<style type="text/css">
	.backgroud{
		background-color: #7a706e;
	}
	
	.logoImg{
		width : 150;
	}
	
	.title{
		text-align: left;
	}
	
	.content{
		font-size: 14px;
	}
	
	.date{
		color: red;
		font-size : 16px;
		font-weight: bold;
	}
	
	.detail{
	}
	
	.remark{
	}
	
	.notice-container{
	}
	
	.btn-container{
		margin-right: 10px;
		float: right;
	}

</style>

</head>
<body>
	<div class="notice-container">
		<div class="background" style="background: #7a706e;"><img class="logoImg" alt="LETECH로고" src="http://intra.letech.kr/letech/resources/images/layout/nav_logo.png"  width="150"></div>
		<div class= "title"><h2>[공지] 인트라넷 개선작업 배포를 위한 시스템 사용중단 안내</h2></div>
		<br>
		<div class="content">
			<div class="date">
				1. 일시 : 2022.02.11(금) 오전 11시 ~ 오후 1시
			</div>
	
			<div class="detail">
				<br>
				<span>2. 개선사항</span><br>
				   <span>&nbsp;&nbsp;&nbsp;1) 우측 배너 : 로그인 정보, 당해년도 연차정보(사용일, 부여일) 표시</span><br>
				   <span>&nbsp;&nbsp;&nbsp;2) 일정관리 : 공휴일 정보, 생일 정보 표시</span><br>
				   <span>&nbsp;&nbsp;&nbsp;3) 휴가 신청서 : 휴가 기간 선택 시 공휴일 표시, 시간 선택 -> 코드(종일,반차,반반차) 선택으로 개선</span><br>
				   <span>&nbsp;&nbsp;&nbsp;4) 휴가관리 : 개인별 휴가현황조회, 휴가현황 엑셀출력</span><br>
				   <span>&nbsp;&nbsp;&nbsp;5) 관리자 : 휴가일수관리, 휴가현황조회/집계, 공휴일관리</span>
				   <br>
			</div>
			<div class="remark">
				<br>
				<span>3. 사용매뉴얼 : 개선작업 완료 후 카톡 및 인트라넷 공지사항으로 배포 예정</span>
				<br>		
			</div>
		</div>
		<div class="btn-container"><button type="button" class="btn btn-default" onclick="window.close();">닫기</button></div>
	</div>
</body>
</html>