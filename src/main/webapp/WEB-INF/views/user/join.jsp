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
	<c:if test="${result>0}">
		<script type="text/javascript">
			alert("회원가입이 완료 되었습니다.");
			location.href = "loginForm.html";
		</script>
	</c:if>
	<c:if test="${result==0 }">
		<script type="text/javascript">
			alert("다시 입력하세요.");
			history.go(-1);
		</script>
	</c:if>

	<c:choose>
		<c:when test="${result==-1}">
			<script type="text/javascript">
				alert("중복된 아이디 입니다.");
				history.go(-1);
			</script>
		</c:when>
		<c:when test="${result==-2}">
			<script type="text/javascript">
				alert("중복된 닉네임 입니다.");
				history.go(-1);
			</script>
		</c:when>
		<c:when test="${result==-3}">
			<script type="text/javascript">
				alert("중복된 아이디 및 닉네임 입니다.");
				history.go(-1);
			</script>
		</c:when>
	</c:choose>

</body>
</html>