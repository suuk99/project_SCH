package com.example.demo.dao;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.dto.FixSchedule;
import com.example.demo.dto.Schedule;
import com.example.demo.dto.SwapRequest;
import com.example.demo.service.ScheduleService;

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
			    AND u.status = 'o'
			    ORDER BY u.name;
			""")
	public List<Map<String, Object>> getAllSchedule(LocalDate weekStart);

	@Select("""
			SELECT u.name, s.weekDay, s.workStatus, s.startTime, s.endTime
			    FROM `user` AS u
			    INNER JOIN userSchedule AS s
			    ON u.userId = s.userId
			    AND s.weekStart = #{weekStart}
			    WHERE u.role != 'ADMIN'
			    AND u.status = 'o'
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
	
	@Update("""
			UPDATE scheduleConfirm
				SET confirm = 1
				WHERE weekStart = #{weekStart}
				AND userName = #{userName}
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
	
	@Insert("""
			INSERT INTO scheduleConfirm (weekStart, userName, confirm)
				VALUES (#{weekStart}, #{userName}, 0);
			""")
	public void insertScheduleConfirm(String userName, String weekStart, int confirm);

	@Select("""
			SELECT confirm 
				FROM scheduleConfirm
				WHERE userName = #{userName}
				AND weekStart = #{weekStart}
			""")
	public Integer getUserConfirm(String userName, String weekStart);

	@Select("""
			SELECT *
				FROM fixSchedule
				WHERE userName = #{userName}
			""")
	public List<FixSchedule> getFixSchedule(String userName);
	
	@Select("""
			SELECT u.userId, u.name, f.weekDay, f.startTime, f.endTime, f.workStatus
			    FROM `user` AS u
			    LEFT JOIN fixSchedule AS f
			        ON u.name = f.userName
			        AND f.weekStart = #{weekStart}
			    WHERE u.name != '관리자'
			    AND status = 'o'
			    ORDER BY u.name
			""")
	public List<Map<String, Object>> getAllUserName(@Param("weekStart") String weekStart);
	
	@Select("""
			SELECT userId, name
				FROM user
				WHERE role != 'ADMIN'
				AND status = 'o'
				ORDER BY name
			""")
	public List<Map<String, Object>> getUserInfo();

	@Insert("""
			INSERT INTO swapRequest (requester, target, swapDate, weekStart, weekDate, startTime, endTime, status)
				VALUES (#{requester}, #{target}, #{swapDate}, #{weekStart}, #{weekDate}, #{startTime}, #{endTime}, 'pending')
			""")
	public void insertSwapRequest(Map<String, Object> data);
	
	@Select("""
			SELECT * 
				FROM swapRequest
				WHERE target = #{target}
				AND status = 'pending'
				ORDER BY weekStart, weekDate
			""")
	public List<SwapRequest> getPending(String userId);
	
	//대타 요청 상태 변경
	@Update("""
			UPDATE swapRequest
				SET `status` = #{status}
				WHERE id = #{id}
			""")
	public void updateSwapStatus(int id, String status);
	
	//대타 상황 조회
	@Select("""
			SELECT * 	
				FROM swapRequest
				WHERE id = #{id}
			""")
	public SwapRequest getSwapRequestId(int id);

	//요청 수락 시 요청자 근무 삭제
	@Delete("""
			DELETE 
				FROM fixSchedule
				WHERE userName = #{requester}
				AND weekStart = #{weekStart}
				AND `weekDay` = #{weekDate}
			""")
	public void deleteFixSchedule(String requester, LocalDate weekStart, int weekDate);

	//수락한 사용자 근무 추가
	@Insert("""
			INSERT INTO fixSchedule (userName, weekStart, `weekDay`, workStatus, startTime, endTime, confirm)
				VALUES (#{target}, #{weekStart}, #{weekDate}, "대타", #{start}, #{end}, #{confirm})
			""")
	public void insertFixSchedule(@Param("target") String target, @Param("weekStart") LocalDate weekStart, @Param("weekDate") int weekDate, @Param("workStatus") String workStatus, @Param("start") String start,
								  @Param("end") String end, @Param("confirm") int confirm);
	
	@Select("""
			SELECT *
				FROM fixSchedule
				WHERE userName = #{userName}
				AND DATE_FORMAT(weekStart, '%Y-%m') = #{monthStr}
				AND confirm = 1
			""")
	public List<FixSchedule> getFixScheduleByMonth(String userName, String monthStr);
}
