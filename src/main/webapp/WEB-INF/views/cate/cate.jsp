<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<!-- <div class="container"
		style="float: left; width: 210px; height: 40px; padding-top: 3px; border-bottom: 1px solid #ededed;"> -->
	<h4 class="text-primary" style="color: black;">카테고리</h4>
	<table class="table" style="border-top: 2px solid black;font-size: 14px;">	

		<c:if test="${empty list }">
			<tr>
				<td>데이터가 없습니다</td>
			</tr>
		</c:if>

		<tr>
			<td style="font-weight:bold;">♬&nbsp;영꿀친목 꿀단지</td>
		</tr>
		<tr>
			<td><a href="${path}/guestBookView.html?r_b_num=100" style="color:black;">가입 인사</a></td>
		</tr>
		<tr>
			<td><a href="${path}/guestBookView.html?r_b_num=100" style="color:black;">등업 신청</a></td>
		</tr>
		<tr>
			<td><a href="${path}/board/list.html?b_c_num=0" style="color:black;">자유 게시판</a></td>
		</tr>

		<c:if test="${not empty list }">
			<c:forEach var="cate" items="${list }">
				<tr>
					<c:if test="${cate.c_del != 'y'}">
						<%-- <td align="center" width="5%">
							<c:if test="${!(cate.c_level > 0) }">♬</c:if>
						</td> --%>
						<td title="${cate.c_intro}" style="font-weight:bold;">
							<c:if test="${!(cate.c_level > 0) }">♬&nbsp;${cate.c_subject }</c:if>
		 					<c:if test="${cate.c_level > 0 }">
								<%-- <img src="images/level.gif" alt="" height="5"
				width="${cate.c_level*10}"> --%>
								<a href="${path}/board/list.html?b_c_num=${cate.c_num}"
									class="btn" style="color:black;">${cate.c_subject }</a>
							</c:if>
						</td>
					</c:if>
				</tr>
			</c:forEach>
		</c:if>
	</table>

	<!-- </div> -->


</body>
</html>