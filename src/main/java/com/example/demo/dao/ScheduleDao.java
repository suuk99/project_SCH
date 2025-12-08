package com.example.demo.dao;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.dto.Schedule;

@Mapper
public interface ScheduleDao {

	@Insert("""
			INSERT INTO userSchedule 
			    SET userId = #{userId},
			        `weekDay` = #{weekDay},
			        workStatus = #{workStatus},
			        startTime = #{startTime},
			        endTime = #{endTime},
			        weekStart= #{weekStart}
			        
			""")
	public void saveSchedule(Schedule schedule);
	
	@Select("""
		    SELECT weekDay, workStatus, startTime, endTime, DATE_ADD(weekStart, INTERVAL weekDay-1 DAY) AS start
			    FROM userSchedule
			    WHERE userId = #{userId}
		""")
		public List<Map<String, Object>> getScheduleByUser(@Param("userId") String userId);
	
	//선택 주 근무신청 여부 확인
	@Select("""
			SELECT COUNT(*)
				FROM userSchedule
				WHERE userId = #{userId}
				AND weekStart = #{weekStart}
			""")
	public int isSubmit(String userId, LocalDate weekStart);
	
	@Select("""
			SELECT u.name, s.weekDay, s.workStatus, s.startTime, s.endTime
			    FROM `user` AS u
			    LEFT JOIN userSchedule AS s
			    ON u.userId = s.userId
			    AND s.weekStart = #{weekStart}
			    WHERE role != 'ADMIN'
			    ORDER BY u.name;
			""")
	public List<Map<String, Object>> getAllSchedule(LocalDate weekStart);

	@Select("""
			SELECT u.name, s.weekDay, s.workStatus, s.startTime, s.endTime
			    FROM `user` AS u
			    INNER JOIN userSchedule AS s
			    ON u.userId = s.userId
			    AND s.weekStart = #{weekStart}
			    WHERE role != 'ADMIN'
			    ORDER BY u.name;
			""")
	public List<Map<String, Object>> getApplyList(LocalDate weekStart);

	@Select("""
			SELECT userId
				FROM `user`
				WHERE role != 'ADMIN'
			""")
	public List<String> getAllUser();

	@Insert("""
		    INSERT INTO fixSchedule 
		        (userName, weekStart, weekDay, workStatus, startTime, endTime)
		    VALUES
		        (#{userName}, #{weekStart}, #{weekDay}, #{workStatus},
		         NULLIF(#{startTime}, ''), NULLIF(#{endTime}, ''))
		""")
	public void saveFixSchedule(String userName, String weekStart, int weekDay, String workStatus,
		                     String startTime, String endTime);
	
	@Insert("""
			INSERT INTO scheduleConfirm (weekStart, userName, confirm)
				VALUES (#{weekStart}, #{userName}, 1)
				ON DUPLICATE KEY UPDATE confirm = 1
			""")
	public void confirmSchedule(@Param("weekStart") String weekStart, @Param("userName") String userName);
	
	@Select("""
			SELECT COUNT(userName) 
				FROM scheduleConfirm
				WHERE confirm = 0
				AND weekStart = #{weekStart}
			""")
	public int countUnconfirmUser(String weekStart);
	
	@Delete("""
			DELETE FROM fixSchedule
				WHERE weekStart = #{weekStart}
			""")
	public void deletFixSchedule(String weekStart);
	
	@Insert("""
			INSERT INTO fixSchedule (userName, weekStart, weekDay, workStatus, startTime, endTime, confirm)
			SELECT u.name, s.weekStart, s.weekDay, s.workStatus, s.startTime, s.endTime, 1
			FROM userSchedule AS s
			INNER JOIN user AS u
			ON u.userId = s.userId
			WHERE s.weekStart = #{weekStart}
			""")
	public void copyFixSchedule(String weekStart);
}
