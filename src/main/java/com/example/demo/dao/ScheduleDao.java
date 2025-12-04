package com.example.demo.dao;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

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
			        confirm = #{confirm},
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
			INSERT INTO fixSchedule (userId, weekStart, weekDay, startTime, endTime)
				VALUES (#{userId}, #{weekStart}, #{weekDay}, #{startTime}, #{endTime})
			""")
	public void saveFixSchedule(String userId, LocalDate weekStart, int weekDay, String startTime, String endTime);
}
