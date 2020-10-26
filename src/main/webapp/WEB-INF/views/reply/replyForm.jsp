<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


</head>
<body>

<div id="replyForm" class="container" align="left" style="width:780px;">
	<form action="insertReply.html" method="post">
		<input type="hidden" name="r_num" value="0">	
		<input type="hidden" name="r_b_num" value="${r_b_num}">
		<c:if test="${empty r_ref || r_ref==0}">
			<input type="hidden" name="r_ref" value="0">
		</c:if>
		<c:if test="${not empty r_ref || r_ref!=0}">
			<input type="hidden" name="r_ref" value="${r_ref}">
		</c:if>
		<input type="hidden" name="r_id" value="${sessionScope.user_id}">
		<input type="hidden" name="r_nick" value="${sessionScope.user_nickname}">
		
		<div class="container" style="float:left;width:760px;border:2px solid #e5e5e5;border-radius:10px;padding-top:10px;padding-bottom:1px;">
	 		<table>
				<tr>
					<td><p style="float:left;font-size:13px;font-weight:bold;padding-top:1px;line-height:1px;" onclick="">${r_nick}</p></td>
				</tr>
				<tr>
					<td>
						<c:if test="${not empty sessionScope.user_id}">
							<textarea style="float:left;border:none;outline:none;width:720px;font-size:12px;resize:none;" name="r_content" cols="90" rows="3" placeholder="댓글을 남겨보세요" required="required"></textarea>
						</c:if>
						<c:if test="${empty sessionScope.user_id}">
							<textarea style="float:left;border:none;outline:none;width:720px;font-size:12px;resize:none;" name="r_content" cols="90" rows="3" placeholder="로그인 후 이용 가능한 서비스입니다" readonly="readonly"></textarea>
						</c:if>
					
					</td>
				</tr>
				<tr>
					<td>
						<p>
							<img src="${path }/resources/images/i8.jpg" alt="" style="float:left;cursor:pointer" onclick=""/>
							<img src="${path }/resources/images/i9.jpg" alt="" style="float:left;cursor:pointer" onclick=""/>
							<c:if test="${not empty sessionScope.user_id}">
								<input style="float:right;border-radius:6px;border:none;outline:none;margin-right:10px;font-size:13px;background-color:transparent;color:#a3a3a3;font-weight:bold" type="submit" value="등록"></input>
							</c:if>
							<c:if test="${empty sessionScope.user_id}">
								<input style="float:right;border-radius:6px;border:none;outline:none;margin-right:10px;font-size:13px;background-color:transparent;color:#a3a3a3;font-weight:bold" type="button" value="등록"></input>
							</c:if>
						
						</p>
					</td>
				</tr>
			</table>
		</div>
	</form>
</div>

</body>
</html>