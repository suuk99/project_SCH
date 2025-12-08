<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link href="https://cdn.jsdelivr.net/npm/daisyui@5" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="/resource/css/Common.css" />
    <link rel="shortcut icon" href="/resource/images/favicon.ico" />
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
</head>
<body>
    
    <section class="header">
		<div class="logo">
			<a href="/sch/home/main"><div>SCHM</div></a>
		</div>
		
		<div class="menu">
			<a href="">인사정보</a>
			<ul>
				<li><a href="/sch/user/information">내 정보</a></li>
				<li><a href="/sch/user/changePw">비밀번호 변경</a></li>
			</ul>
		</div>		
			
		<div class="menu">
			<a href="">근태관리</a>
			<ul>
				<li><a href="/sch/schedule/apply">근무 신청</a></li>
				<li><a href="/sch/schedule/list">근무시간 조회</a></li>
				<li><a href="/sch/schedule/swap">시간변경/대타 신청</a></li>
			</ul>
		</div>
			
		<div class="menu">
			<a href="">급여정보</a>
			<ul>
				<li><a href="/sch/user/selectSal">급여조회</a></li>
			</ul>
		</div>
		
		<c:if test="${sessionScope.loginUserRole == 'ADMIN'}">
			<div class="menu">
				<a href="">관리자 메뉴</a>
				 <ul>
				 	<li><a href="/sch/notice/write">공지사항 작성</a></li>
				 	<li><a href="/sch/admin/checkApply">근무신청 현황</a></li>
				 	<li><a href="/sch/admin/createSchedule">스케줄 작성</a></li>
				 </ul>
			</div>
		</c:if>
		
		<div class="ment"><a href="/sch/user/information">반갑습니다!  ${sessionScope.loginUserName}  님</a></div>
		
		<a class="logout" href="/sch/user/logout" style="font-weight: bold;"> <i class="fa-solid fa-lock" style="color: #dba309"></i> 로그아웃</a>
	</section>
    
    <div id="toast-container" style="
	    position: fixed;
	    top: 60px;
	    left: 50%;
	    transform: translateX(-50%);
	    z-index: 99999;
	"></div>
	
	<script>
		document.addEventListener('DOMContentLoaded', () => {
		    const userRole = '${sessionScope.loginUserRole}';
		    let socket = new SockJS('/ws');
		    let stomp = Stomp.over(socket);
		
            // 웹소켓 연결 시도 및 성공/실패 콜백 정의
		    stomp.connect({}, function (frame) {
		
		        // 1. 전체 사용자 알림 구독 로직 (/topic/scheduleAlert)
		        stomp.subscribe('/topic/scheduleAlert', function (msg) {
		            if(userRole === 'ADMIN') return; // 관리자 제외
		
		            let text = msg.body;
		            
		            try {
		                // ArrayBuffer 디코딩 로직: 구형 stomp.js에서 메시지 본문이 ArrayBuffer로 올 경우 문자열로 변환
		                if (msg.body instanceof ArrayBuffer || (typeof msg.body === 'object' && msg.body !== null && msg.body.byteLength > 0)) {
		                    const decoder = new TextDecoder('utf-8');
		                    text = decoder.decode(msg.body);
		                }
		            } catch (e) {
		                console.error("메시지 디코딩 오류:", e);
		                text = "알림 내용 처리 오류"; 
		            }
		            
		            console.log("최종 처리된 알림 내용:", text); 
		            showAlert(text);
		        });
		
		        // 2. 특정 사용자 알림 구독 로직 (/user/queue/alert)
		        stomp.subscribe('/user/queue/alert', function (msg) {
		            const text = msg.body; 
		            showAlert(text);
		        });
		
		    }, function(error) { // 연결 실패 시 실행 (디버깅용)
		        console.error("STOMP Connection Error:", error); 
		    }); 
		});
		
		// ⭐ Toast 알림 함수 (CSS 충돌 방지 스타일 포함)
		function showAlert(message, actionUrl) {
		    const container = document.getElementById("toast-container");
		    const mainColor = "black";
		    const icon = "ℹ";
		
		    const toast = document.createElement("div");
		    // ... (toast 스타일은 유지 또는 제거) ...
		    toast.style.width = "500px";
		    toast.style.background = "#fff";
		    toast.style.borderRadius = "10px";
		    toast.style.boxShadow = "0 4px 15px rgba(0,0,0,0.15)";
		    toast.style.marginBottom = "12px";
		    toast.style.display = "flex";
		    toast.style.opacity = "1"; // 애니메이션 제거
		    toast.style.transform = "translateY(0)";
		    toast.style.zIndex = "100000"; // z-index 최상위 보장
		
		    const leftBar = document.createElement("div");
		    leftBar.style.width = "6px";
		    leftBar.style.background = mainColor;
		
		    const content = document.createElement("div");
		    content.style.flex = "1";
		    content.style.padding = "12px 15px";
		    
		    // ⭐⭐ 핵심 수정: 내용 영역 CSS 강제 재정의
		    content.innerHTML = `
		        <div style="font-size:28px; font-weight:bold; color:${mainColor}; margin-bottom: 5px;">
		            ${icon} 알림
		        </div>
		        
		        <div id="alert-message-text-final" style="
		            font-size:24px     /* ⭐!important: 다른 CSS 무시 */
		            color:black         /* ⭐!important: 다른 CSS 무시 */
		            min-height: 20px    /* ⭐!important: 높이 확보 */
		            line-height: 1.4 
		            margin-top:4px;
		            padding-bottom: 5px;
		            white-space: normal  /* 텍스트 줄바꿈 보장 */
		            overflow: visible    /* 가려짐 방지 */
		        ">
		        </div>
		    `;
		    
		    // ⭐⭐ 텍스트 노드를 사용하여 메시지를 안전하게 삽입
		    const messageDiv = content.querySelector('#alert-message-text-final');
		    if (messageDiv) {
		        messageDiv.textContent = message; 
		    }
		    
		    const closeBtn = document.createElement("div"); 
		    
		    closeBtn.innerHTML = "&times;";
		    closeBtn.style.fontSize = "20px";
		    closeBtn.style.padding = "10px";
		    closeBtn.style.cursor = "pointer";
		    closeBtn.style.color = "#777";
		    closeBtn.onclick = () => container.removeChild(toast);
		    
		    toast.appendChild(leftBar);
		    toast.appendChild(content);
		    toast.appendChild(closeBtn);
		    container.appendChild(toast);
		    
		    setTimeout(() => { toast.style.opacity = "1"; toast.style.transform = "translateY(0)"; }, 80);
		}
	</script>
