package com.example.demo.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

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
			        weekStart= #{weekStart};
			""")
	public void saveSchedule(Schedule schedule);

}
