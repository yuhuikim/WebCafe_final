<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link  rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
</head>
<body>

   <!-- <div class="container"
      style="float: left; width: 210px; height: 40px; padding-top: 3px; border-bottom: 1px solid #ededed;"> -->
   <h5 class="text-primary" style="color: black;">카테고리</h5>
   <table class="table" style="border-top: 2px solid black;">   

      <c:if test="${empty list }">
         <tr>
            <td>데이터가 없습니다</td>
         </tr>
      </c:if>

      <tr>
         <td style="font-weight:bold; font-size: 14px;">♬&nbsp;영꿀친목 꿀단지</td>
      </tr>
      <tr>
         <td>
            <a href="${path}/guestBookView.html?r_b_num=10" style="color:black; font-size: 12.9px;">
               <img src="${path }/resources/images/c3.svg" alt="" height="13" width="13" 
                  style="margin-bottom: 3.5px; margin-right: 4px; "/>[친목] 가입 인사
            </a>
         </td>
      </tr>
      <tr>
         <td>
            <a href="${path}/guestBookView.html?r_b_num=100" style="color:black; font-size: 12.9px;">
               <img src="${path }/resources/images/c3.svg" alt="" height="13" width="13" 
                  style="margin-bottom: 3.5px; margin-right: 4px; "/>[친목] 등업 신청
            </a>
         </td>
      </tr>
      <tr>
         <td title="${cate.c_intro}" style="font-weight:bold; font-size: 14px;">
                     <c:if test="${!(cate.c_level > 0) }">♬&nbsp;${cate.c_subject }
                     </c:if>
                     <c:if test="${cate.c_level > 0 }">
                        <%-- <img src="images/level.gif" alt="" height="5"
                              width="${cate.c_level*10}"> --%>
                        <a href="${path}/board/list.html?b_c_num=${cate.c_num}" style="color:black; font-weight: 400; font-size: 13;" > 
                           <img src="${path }/resources/images/c3.svg" alt="" height="13" width="13" 
                              style="margin-bottom: 3.5px; margin-right: 4px;"/>${cate.c_subject }
                        </a>
                     </c:if>
         </td>
      </tr>

      <c:if test="${not empty list }">
         <c:forEach var="cate" items="${list }">
            <tr>
               <c:if test="${cate.c_del != 'y'}">
                  <%-- <td align="center" width="5%">
                     <c:if test="${!(cate.c_level > 0) }">♬</c:if>
                  </td> --%>
                  <td title="${cate.c_intro}" style="font-weight:bold; font-size: 14px;">
                     <c:if test="${!(cate.c_level > 0) }">♬&nbsp;${cate.c_subject }
                     </c:if>
                      <c:if test="${cate.c_level > 0 }">
                        <%-- <img src="images/level.gif" alt="" height="5"
                              width="${cate.c_level*10}"> --%>
                        <a href="${path}/board/list.html?b_c_num=${cate.c_num}" style="color:black; font-weight: 400; font-size: 13;" > 
                           <img src="${path }/resources/images/c3.svg" alt="" height="13" width="13" 
                              style="margin-bottom: 3.5px; margin-right: 4px;"/>${cate.c_subject }
                        </a>
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