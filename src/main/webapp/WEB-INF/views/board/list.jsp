<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>Insert title here</title>

<style>
@import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css);
body {
	font-family: "Apple SD Gothic Neo", "맑은 고딕", "Malgun Gothic", 돋움, dotum, sans-serif;
}

.cateTitle {

	color: #333;
	font-weight: bolder;
    font-family: "Apple SD Gothic Neo", "맑은 고딕", "Malgun Gothic", 돋움, dotum, sans-serif;
    font-size: 22px;
    line-height: 24px;
    vertical-align: sub;
}

.cateIntro {
	margin-top: 15px;
    font-size: 13px;
    line-height: 15px;
    color: #999;
}

.boardChoose {
	float:right;
}

table {
	border-spacing: 2px;
}

.tHead tr {
	align : center;
	vertical-align: middle;
    border-bottom-color: #f2f2f2;
    color: #4e4e4e;
    
    height: 40px;
    padding: 2px;
    
    border-bottom: 1px solid #f2f2f2;
    text-align: center;
    font-weight: bolder;
    font-size: 15px;
}

.tBody tr {
	align : center;
	vertical-align: middle;
    border-bottom-color: #f2f2f2;
    color: #4e4e4e;
    
    height: 40px;
    padding: 2px;
    
    border-bottom: 1px solid #f2f2f2;
    text-align: center;
    
    font-size: 13px;
}

</style>

</head><body>


<div class="container" align="center" style="margin-left:200px;width:900px;padding-top:10px;padding-bottom:2px; padding-left:40px">

<!-- 카테고리 -->
<div style="height:80px">
	<h2 align="left" class="cateTitle">${cate.c_subject }</h2>
	<p style="margin-bottom: 0px;" align="left"class="cateIntro"> ${cate.c_intro } </p>	


<!-- 앨범,목록 선택 -->
<span class= "boardChoose" id="boardChoose" align="right">
  <a href="${path}/board/listWithPhoto.html?b_c_num=${cate.c_num}&pageNum=${pb.currentPage}&search=${board.search}&keyword=${board.keyword}"
     style="color: black" class="btn  glyphicon glyphicon-th-large ">앨범형</a>
  <a href="${path}/board/list.html?b_c_num=${cate.c_num}&pageNum=${pb.currentPage}&search=${board.search}&keyword=${board.keyword}"
     style="color: black"class="btn glyphicon glyphicon-th-list ">목록형</a>   
</span>
</div>

<hr style="border-top:1px solid black"/>	


<!-- 목록형 게시판 -->
<div id="boardBody">
<!-- <table class="table table-striped table-bordered"> -->
<table align="center">

<thead class="tHead"> 
   <tr align="center"><td width=88 > No.</td>
      <td width=438 >제목</td>
      <td width=118>작성자</td>
      <td width=80>작성일</td>
      <td width=68>조회수</td>
      <td width=68>좋아요</td></tr>
 </thead>
 
 <tbody class="tBody">
<c:if test="${empty list }">
   <tr><td colspan="6">데이터가 없습니다</td></tr>
</c:if>      
<c:if test="${not empty list }">

<c:forEach var="board" items="${list }">
<c:if test="${board.b_del != 'y'}">
   <tr align="center"><td>${board.b_num }</td>
<%--    <c:if test="${board.del == 'y'}">
      <td colspan="5">삭제된 글입니다</td>
   </c:if> --%>

      <td  title="${board.b_content}">
         <c:if test="${board.b_read_cnt > 30 }">
         <img src="${path }/resources/images/hot.gif" alt="" />
            </c:if>
         <a href="boardView.html?b_c_num=${cate.c_num}&b_num=${board.b_num}&pageNum=${pb.currentPage}"
            >${board.b_subject }</a></td>
      <td>${board.b_nick}</td>
      <td>${board.b_regdate }</td>
      <td>${board.b_read_cnt }</td>
      <td>${board.b_like_cnt }</td>
   </tr>
</c:if>   
</c:forEach>
</c:if>
</tbody>
</table>

<!-- 버튼 -->         
<div align="right" style="padding-top:15px">

<a href="${path}/board/insertBoardForm.html?b_c_num=${cate.c_num}" class="btn btn-default">게시글 입력</a> 
</div>

<!-- 페이징 -->
<div align="center">
   <ul class="pagination">
      <c:if test="${pb.startPage > pb.pagePerBlock}">
         <li><a href="list.html?b_c_num=${cate.c_num }&pageNum=1&search=${board.search }&keyword=${board.keyword}">
                     <span class="glyphicon glyphicon-backward"></span>
               </a></li>
               
               <li><a href="list.html?b_c_num=${cate.c_num }&pageNum=${pb.startPage-1}&search=${board.search }&keyword=${board.keyword}">
                     <span class="glyphicon glyphicon-triangle-left"></span>
               </a></li>
            </c:if>
            
            <c:forEach var="i" begin="${pb.startPage }" end="${pb.endPage}">
               <c:if test="${i == pb.currentPage }">
                  <!-- 현재 페이지를 보고 있으면 active 효과 -->
                  <li class="active"><a href="list.html?b_c_num=${cate.c_num }&pageNum=${i}&search=${board.search }&keyword=${board.keyword}">${i}</a></li>
               </c:if>
               <c:if test="${i != pb.currentPage }">
                  <li><a href="list.html?b_c_num=${cate.c_num }&pageNum=${i}&search=${board.search }&keyword=${board.keyword}">${i}</a></li>
               </c:if>
            </c:forEach>
            <c:if test="${pb.endPage < pb.totalPage }">
               <li><a href="list.html?b_c_num=${cate.c_num }&pageNum=${pb.endPage+1}&search=${board.search }&keyword=${board.keyword}">
                     <span class="glyphicon glyphicon-triangle-right"></span>
               </a></li>
               <li><a href="list.html?b_c_num=${cate.c_num }&pageNum=${pb.totalPage}&search=${board.search }&keyword=${board.keyword}">
                     <span class="glyphicon glyphicon-triangle-forward"></span>
               </a></li>
            </c:if>
         </ul>
      </div>

<!-- 검색 -->
<form action="list.html">
<div class="input-group">
   <input type="hidden" name="b_c_num" value="${cate.c_num }"/>
   <input type="hidden" name="pageNum" value="1" />
      <select name="search" class="btn btn-default">
         <c:forTokens var="item" items="b_nick,b_subject,b_content,subcon" delims=","
            varStatus="i">
            
            <c:if test="${board.search==item }">
               <option value="${item }" selected="selected">${tit[i.index]}</option>
            </c:if>
            <c:if test="${board.search!=item }">
               <option value="${item }" >${tit[i.index]}</option>
            </c:if>
         </c:forTokens>              
      </select>
      <input class="btn btn-default" type="text" placeholder="검색어를 입력하세요" name="keyword" value="${board.keyword }"/>
      <%-- <input type="text" name="keyword" value="${board.keyword }"/> --%>
      <button class="btn btn-default btn-lg" type="submit">
	  	<i class="glyphicon glyphicon-search"></i>
	  </button> 
</div>
</form>

</div>
</div>
</body>
</html>