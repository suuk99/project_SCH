package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.dto.Notice;

@Mapper
public interface NoticeDao {
	
	@Insert("""
			INSERT INTO notice
			    SET title = #{title},
			        content = #{content},
			        writerId = #{loginUserID};
			""")
	void doWrite(String title, String content, int loginUserID);

	@Select("""
			SELECT n.id, n.title, u.name AS writerName, n.regDate, n.hit
			    FROM notice AS n
			    INNER JOIN `user` AS u
			    ON n.writerId = u.id
			    ORDER BY n.id DESC
			    LIMIT #{limitFrom}, #{itemsInAPage};
			""")
	List<Notice> showNoticeList(int limitFrom, int itemsInAPage);
	
	@Select("""
			SELECT n.id, n.title, n.content, n.writerId, n.regDate, n.updateDate, n.hit, u.name AS writerName, u.role
			    FROM notice AS n
			    INNER JOIN `user` AS u ON n.writerId = u.id
			    WHERE n.id = #{id};
			""")
	Notice getNoticeId(int id);

	@Delete("""
			DELETE FROM notice
			 	WHERE id = #{id};
			""")
	void delete(int id);
	
	
	@Update("""
			UPDATE notice 
				SET title = #{title},
					content= #{content},
					updateDate = NOW()
				WHERE id = #{id};
			""")
	void modifyNotice(int id, String title, String content);
	
	@Update("""
			UPDATE notice
				SET hit = hit + 1
				WHERE id = #{id};
			""")
	void addHit(int id);
	
	@Select("""
			SELECT COUNT(id)
				FROM notice;
			""")
	int getArticlesCnt();

}
