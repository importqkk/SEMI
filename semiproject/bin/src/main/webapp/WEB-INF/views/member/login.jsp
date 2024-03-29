<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    <style>
      h2{
        color:#776BFF;
        margin-top : 250px;
      }
    </style>
  <form action="/member/login" method="post" autocomplete="off">

    <div class="container-400">
      <div class="row center">
          <h2>MYFORMULA</h2>
        </div>
      <div class="row">
        <input type="text" name="memberId" required class="form-input w-100 medium light" placeholder="아이디" >
      </div>
      <div class="row">
        <input type="password" name="memberPw" required class="form-input w-100 medium light" placeholder="비밀번호">
        <c:if test="${param.mode == 'error'}">
          <div class="row center" style="font-size: 15px; color: red;">
            <h3>아이디 또는 비밀번호를 잘못 입력했습니다.</h3>
          </div>
        </c:if>
      </div>
      <div class="row">
        <button type="submit" class="form-btn positive w-100 medium">로그인</button>
      </div>	
      <div class="row center">
        <a href="${pageContext.request.contextPath}/find" class="link">아이디찾기</a>|<a href="${pageContext.request.contextPath}/find" class="link">비밀번호 찾기</a>|<a href="${pageContext.request.contextPath}/find" class="link">회원가입</a>
      </div>
  
    </div>
    </form>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>