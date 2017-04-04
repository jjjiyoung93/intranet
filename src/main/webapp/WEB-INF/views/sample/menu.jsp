<%@ page contentType="text/html; charset=utf-8" language="java" errorPage="" %>
<nav>
	<ul>
		<c:forEach var="list" items="${mnList}" varStatus="status">
			<li>
				<span>
					<a href="${list.MN_VAL}" >
					${list.MN_NM}
					</a>
				</span>
			</li>
		</c:forEach>
	</ul>
</nav>