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
}
