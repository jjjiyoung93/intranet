<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="kr.letech.cmm.util.VarConsts"%>
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
					<form name="form1" id="form1" method="post" action="<%=request.getContextPath()%>/sys/sch/sch00List.do">
						<!-- 타이틀 및 페이지 네비 -->
						<h2 class="page-title clearfix">
							${titleNaviMap.MN_NM }
							<span class="pull-right site-map">
								HOME > ${titleNaviMap.NAVI_NM }
							</span>
						</h2>
						<!-- page -->
						<div class="form-container">
							<p class="clearfix">
								<span class="pull-right">
									<a href="#" class="btn btn-sm btn-info" onclick="fnInsert();">등록</a>
								</span>
							</p>

							<div class="table-responsive">
							<!-- 테이블 -->
								<table class="table table-bordered">
									<caption>그룹별급수 정보관리</caption>
									<colgroup>
										<col width="25%" />
										<col width="*" />
										<col width="15%" />
										<col width="15%" />
										<col width="15%" />
									</colgroup>
									<thead>
										<tr>
											<th>배치명</th>
											<th>배치프로그램</th>
											<th>등록일</th>
											<th>최근 실행일</th>
											<th>배치주기</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td align="center">비즈플레이</td>
											<td align="center">
												<a href="javascript:fnView();">비즈플레이</a>
											</td>
											<td align="center">2020.12.01</td>
											<td align="center">20222.03.02</td>
											<td align="center">* * * * * *</td>
										</tr>
									</tbody>
								</table>
							</div><!-- table 끝 -->
							
							<p class="clearfix">
								<span class="pull-right">
									<a href="#" class="btn btn-sm btn-info" onclick="fnInsert();">등록</a>
								</span>
							</p>
						</div> <!-- form-container 끝 -->
					</form>
				</div>
			<jsp:include page="/resources/com/inc/aside.jsp" />
			</section>
		</div><!-- page-wrapper 끝 -->
	<jsp:include page="/resources/com/inc/footer.jsp" />
	</div><!-- wrapper 끝 --> 

<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">

	/* 등록 */
	function fnInsert() {
		$("#form1").attr("action", "${pageContext.request.contextPath}/sys/sch/sch00Form.do");
		$("#form1").submit();
	}

	/* 상세조회 */
	function fnView() {
		$("#form1").attr("action", "${pageContext.request.contextPath}/sys/sch/sch00View.do");
		$("#form1").submit();
	}
	
</script>
</body>
</html>