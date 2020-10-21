<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Jua&display=swap"
	rel="stylesheet">
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<title>꿀카페 : 회원가입</title>

<script type="text/javascript">
	function idChk() {
		var user_id = frm.user_id.value;
		if (!frm.user_id.value) {
			alert("아이디 입력 후 중복체크 버튼을 눌러주세요!");
			frm.user_id.focus();
			return false;
		}
		$.post('idChk.html', 'user_id=' + frm.user_id.value, function(data) {
			$('#idChk').html(data);
			//alert(data);
		});
	}
	function nickChk() {
		var user_nickname = frm.user_nickname.value;
		if (!frm.user_nickname.value) {
			alert("닉네임 입력 후 중복체크 버튼을 눌러주세요!");
			frm.user_nickname.focus();
			return false;
		}
		$.post('nickChk.html', 'user_nickname=' + frm.user_nickname.value,
				function(data) {
					$('#nickChk').html(data);
					//alert(data);
				});
	}
	/* 	function chk() {
	 if (frm.user_pwd.value != frm.user_pwd2.value) {
	 alert("암호와 암호확인이 서로 일치하지 않습니다.");
	 frm.user_pwd.value = "";
	 frm.user_pwd.focus();
	 return false;
	 }
	 } */
	function idChk2() {
		// /^: 시작,  $/: 끝, []: 속에 글자 중에 하나
		// .*(?=.{4,8}) 점을 포함한 한글자 이상을 사용하는 4~8이내
		// (?=.*[0-9]) 숫자 하나는 포함
		// (?=.*[a-zA-Z]) 소문자/대문자 구별없이 한글자 이상
		// (?=.*[@!#$*()_&]) []속의 글자(특수문자) 하나는 있어야한다
		var user_pwd = /^.*(?=.{10,16})(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[@!#$*()_&]).*$/;
		if (!user_pwd.test(frm.user_pwd.value)) {
			alert("비밀번호 조건에 맞지 않습니다.");
			frm.user_pwd.focus();
			return false;
		} else if (frm.user_pwd.value != frm.user_pwd2.value) {
			alert("암호와 암호확인이 서로 일치하지 않습니다.");
			frm.user_pwd.value = "";
			frm.user_pwd.focus();
			return false;
		}
		return true;
	}
</script>

<style>
html, body {
	height: 100%;
}

body {
	display: -ms-flexbox;
	display: flex;
	-ms-flex-align: center;
	align-items: center;
	padding-top: 40px;
	padding-bottom: 40px; <%--
	background-color: #f5f5f5; --%>
	background-color: white;
}

.form-signin {
	width: 100%;
	max-width: 330px;
	padding: 15px;
	margin: auto;
}

.form-signin .checkbox {
	font-weight: 400;
}

.form-signin .form-control2 {
	position: relative;
	box-sizing: border-box;
	height: auto;
	font-size: 16px;
}

.form-signin .form-control {
	position: relative;
	box-sizing: border-box;
	height: auto;
	padding: 2px;
	font-size: 16px;
}

.form-signin .form-control:focus {
	z-index: 2;
}

.form-signin input[type="number"] {
	padding-top: 7px;
	padding-bottom: 7px;
	border-bottom-right-radius: 0;
	border-bottom-left-radius: 0;
}

.form-signin input[type="email"] {
	padding-top: 7px;
	padding-bottom: 7px;
	border-bottom-right-radius: 0;
	border-bottom-left-radius: 0;
}

.form-signin input[type="password"] {
	padding-top: 7px;
	padding-bottom: 7px;
	border-top-left-radius: 0;
	border-top-right-radius: 0;
}

.form-signin input[type="text"] {
	padding-top: 7px;
	padding-bottom: 7px;
	border-top-left-radius: 0;
	border-top-right-radius: 0;
}

.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}
</style>

</head>

<body class="text-center">

	<%-- 
	<c:choose>
		<c:when test="${not empty message }">
			<script type="text/javascript">
				alert("${message}");
			</script>
		</c:when>
		<c:when test="${not empty message1 }">
			<script type="text/javascript">
				alert("${message1}");
			</script>
		</c:when>
	</c:choose>
 --%>
	<form class="form-signin" action="join.html" method="post"
		enctype="multipart/frm-data" name="frm" onsubmit="return idChk2()">

		<div id="header" role="banner">
			<a href="http://www.naver.com"></a> <img class="mb-4"
				src="${path }/resources/images/logo/join_logo2.png">
		</div>

		<!-- 		<h1 class="h3 mb-3 font-weight-normal">회원가입</h1> -->

		<label for="input1" class="sr-only">ID</label>
		<!--  <input type="text"
			name="user_id" class="form-control" placeholder="아이디" required
			autofocus> -->

		<!-- 여기 수정 -->


		<c:choose>
			<c:when test="${not empty user_id }">
				<span class="form-control" style="border: 1px solid #ced4da;">
					<input type="text" name="user_id"
					style="border: 1px solid white; margin: 0px; outline: none;"
					size="30" class="form-control" value="${user_id }"
					placeholder="아이디" required="required" autofocus="autofocus">
					&nbsp; <span> <img height="23" width="23"
						src="${path }/resources/images/logo/confirm_logo.png"
						onclick="idChk()">
				</span>
				</span>

			</c:when>
			<c:when test="${empty user_id }">
				<span class="form-control" style="border: 1px solid #ced4da;">
					<input type="text" name="user_id"
					style="border: 1px solid white; outline: none;" size="30"
					required="required" placeholder="아이디" autofocus="autofocus">&nbsp;
					<span> <img height="23" width="23"
						src="${path }/resources/images/logo/confirm_logo.png"
						onclick="idChk()">
				</span>
				</span>
			</c:when>
		</c:choose>
		<div id="idChk" class="err"
			style="font-family: verdana; font-size: 15px; color: red;"></div>

		<div style="padding-bottom: 10px"></div>

		<label for="input2" class="sr-only">Nickname</label>


		<c:choose>
			<c:when test="${not empty user_nickname }">
				<span class="form-control"> <input type="text"
					name="user_nickname"
					style="border: 1px solid white; margin: 0px; outline: none;"
					size="30" class="form-control" value="${user_nickname }"
					placeholder="닉네임" required="required" autofocus="autofocus">
					&nbsp; <span> <img height="23" width="23"
						src="${path }/resources/images/logo/confirm_logo.png"
						onclick="nickChk()">
				</span>
				</span>
			</c:when>

			<c:when test="${empty user_nickname }">
				<span class="form-control"> <input type="text"
					name="user_nickname"
					style="border: 1px solid white; outline: none;" size="30"
					required="required" placeholder="닉네임" autofocus="autofocus">&nbsp;
					<span> <img height="23" , width="23"
						src="${path }/resources/images/logo/confirm_logo.png"
						onclick="nickChk()">
				</span></span>
			</c:when>
		</c:choose>

		<div id="nickChk" class="err"
			style="font-family: verdana; font-size: 15px; color: red;"></div>
			
		<div style="padding-bottom: 10px"></div>

		<label for="input5" class="sr-only">Name</label> <input type="text"
			name="user_name" class="form-control" placeholder="  이름" required>
		<%-- 	<c:if test="${errors.name }">이름을 입력하세요.</c:if> --%>

		<div style="padding-bottom: 10px"></div>
		<label for="input3" class="sr-only">Password</label> <input
			type="password" name="user_pwd" class="form-control"
			placeholder="  비밀번호" required>
		<p
			style="padding-top: 10px; color: gray; font-size: 11px; margin: 0px">
			※ 영문 대소문자/숫자/특수문자를 조합, 10~16자로 설정※</p>
		<%-- <c:if test="${errors.password }">암호를 입력하세요.</c:if>--%>
		<div style="padding-bottom: 10px"></div>
		<label for="input4" class="sr-only">Password2</label> <input
			type="password" name="user_pwd2" class="form-control"
			placeholder="  비밀번호 확인" required>
	
		<div style="padding-bottom: 10px"></div>
		<label for="input6" class="sr-only">Age</label> <input type="number"
			name="user_age" min="14" max="100" class="form-control"
			placeholder="  나이" required="required">

		<div style="padding-bottom: 10px"></div>
		<label for="input7" class="sr-only">Email</label> <input type="email"
			name="user_email" class="form-control" placeholder="  이메일" required>

		<p></p>
		<p>
			<a href="../main.html"> | HOME | </a> <a href="loginForm.html"> SIGN
				IN | </a>
		</p>
		<button class="btn btn-lg btn-primary btn-block" type="submit">가입하기
		</button>
		
	</form>
</body>
</html>