<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <!-- 제이쿼리, 폰트어썸, Tailwind, DaisyUI, common.css, common.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link href="https://cdn.jsdelivr.net/npm/daisyui@5" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="/resource/css/Common.css" />
   <!--  <script src="${pageContext.request.contextPath}/resource/js/common.js"></script> -->
</head>
<body>
	<section class="header">
		<div class="logo">
			<a href="/sch/home/main"><div>SCHM</div></a>
		</div>
		
		<div class="menu">
			<a href="/sch/user/information">인사정보</a>
			<ul>
				<li><a href="/sch/user/information">내 정보</a></li>
				<li><a href="/sch/user/changePw">비밀번호 변경</a></li>
			</ul>
		</div>		
			
		<div class="menu">
			<a href="/sch/schedule/apply">근태관리</a>
			<ul>
				<li><a href="/sch/schedule/apply">근무 신청</a></li>
				<li><a href="/sch/schedule/confirm">근무 확정</a></li>
				<li><a href="/sch/schedule/list">근무시간 조회</a></li>
				<li><a href="/sch/schedule/swap">시간변경/대타 신청</a></li>
			</ul>
		</div>
			
		<div class="menu">
			<a href="/sch/user/selectSal">급여정보</a>
			<ul>
				<li><a href="/sch/user/selectSal">급여조회</a></li>
			</ul>
		</div>
		
		<div class="ment">반갑습니다 ${sessionScope.loginUserName} 님</div>
		
		<a class="logout" href="/sch/user/logout"> 🔒로그아웃</a>
	</section>