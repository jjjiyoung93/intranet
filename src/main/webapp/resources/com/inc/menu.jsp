<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<nav>
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
	<ul>
		<li>
			<span>
			<a href="/letech/usr/notice00L.do?nt_id=nt1" >
			게시판1
			</a>
			</span>
		</li>
		<li>
			<span>
			<a href="/letech/usr/notice00L.do?nt_id=nt2" >
			게시판2
			</a>
			</span>
		</li>
		<li>
			<span>
			<a href="/letech/usr/notice00L.do?nt_id=nt3" >
			게시판3
			</a>
			</span>
		</li>
	</ul>
</nav>