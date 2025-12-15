package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.dto.User;

@Mapper
public interface UserDao {
	
	@Insert("""
			INSERT INTO `user`
				SET regDate = NOW(),
					userId = #{userId},
					password = #{password},
					`name` = #{name},
					birthDate = #{birthDate},
					phoneNum = #{phoneNum},
					sex = #{sex}
			""")
	public void joinUser(String userId, String password, String name, String birthDate, String phoneNum, String sex);

	@Select("""
			SELECT * 
				FROM user
				WHERE userId = #{userId}
			""")
	public User getUserLoginId(String userId);

	@Update("""
			UPDATE `user`
				SET password = #{newPw}
				WHERE userId= #{userId}
			""")
	public void updatePw(String userId, String newPw);
	
	@Update("""
			UPDATE `user`
				SET status = #{status}
				WHERE id = #{id}
			""")
	public void updateStatus(int id, String status);

	@Select("""
			SELECT *
				FROM user
				WHERE status = 'wating'
			""")
	public List<User> getJoinRequest();
}
