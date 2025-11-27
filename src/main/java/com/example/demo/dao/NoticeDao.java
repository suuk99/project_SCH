package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

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
			    ORDER BY n.id DESC;
			""")
	List<Notice> showNoticeList();
	
	@Select("""
			SELECT n.id, n.title, n.content, n.writerId, n.regDate, n.updateDate, n.hit, u.name AS writerName
			    FROM notice AS n
			    INNER JOIN `user` AS u ON n.writerId = u.id
			    WHERE n.id = #{id};
			""")
	Notice getNoticeId(int id);

}
