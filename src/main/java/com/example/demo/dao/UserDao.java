package com.example.demo.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.dto.User;

@Mapper
public interface UserDao {
	
	@Insert("""
			INSERT INTO `user`
				SET regDate = NOW(),
					userId = #{userId},
					password = #{password},
					`name` = #{name},
					sex = #{sex}
			""")
	public void joinUser(String userId, String password, String name, String sex);

	@Select("""
			SELECT * 
				FROM user
				WHERE userId = #{userId}
			""")
	public User getUserLoginId(String userId);
}
