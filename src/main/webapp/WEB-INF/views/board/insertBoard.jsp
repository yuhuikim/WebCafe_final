<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>Insert title here</title></head><body>
<c:if test="${result > 0}">
   <script type="text/javascript">
      alert("입력 되었습니다.");
      location.href="list.html?b_c_num=${cate.c_num}";  /* /pageNum/${pageNum} */
   </script>
</c:if>
<c:if test="${result == 0}">
   <script type="text/javascript">
      alert("다시 입력해주세요.");
      history.back();
   </script>
</c:if>
</body>
</html>