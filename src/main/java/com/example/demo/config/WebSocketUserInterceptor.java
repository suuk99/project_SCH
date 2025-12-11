package com.example.demo.config;

import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.simp.stomp.StompCommand;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.ChannelInterceptor;
import org.springframework.messaging.support.MessageHeaderAccessor;

public class WebSocketUserInterceptor implements ChannelInterceptor{
	@Override
    public Message<?> preSend(Message<?> message, MessageChannel channel) {
        StompHeaderAccessor accessor = MessageHeaderAccessor.getAccessor(message, StompHeaderAccessor.class);
        if (StompCommand.CONNECT.equals(accessor.getCommand())) {
            // 여기서 로그인 세션의 userId 가져와서 principal로 설정
            String userId = (String) accessor.getSessionAttributes().get("loginUserName");
            if (userId != null) {
                accessor.setUser(new StompPrincipal(userId));
            }
            
            System.out.println("CONNECT userId=" + userId);
        }
        return message;
    }
}