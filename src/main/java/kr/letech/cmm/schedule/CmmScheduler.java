package kr.letech.cmm.schedule;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import kr.letech.aprv.service.AprvMngService;

@Component
public class CmmScheduler {

	/**
	 * 메일보내기 관리 서비스
	 */
//	@Resource(name = "mailSendService")
//	private MailSendService mailSendService;
	
	@Resource(name = "aprvMngService")
	private AprvMngService aprvMngService;

//	@Scheduled(fixedDelay=30000)
//	public void mailSender() throws Exception {
//		mailSendService.searchMailSend();
//	}
	

	/**
	* 비즈플레이 배치
	* @Method : bizplayAPI
	* @Author : JO MIN SOO
	* @Date : 2021. 1. 6.
	*/
	@Scheduled(cron = "0 0 07 * * *") // 매일 오전 7시에 
	public void bizplayAPI() {
		Map<String, Object> params = new HashMap<String, Object>(); // 넘겨줄 파라미터
		
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd", Locale.getDefault()); // 날짜 포맷 지정
		Calendar cal = Calendar.getInstance(); // 오늘 날짜  가져오기
		
		String endDate = df.format(cal.getTime()); // 종료일
		
		cal.add(Calendar.MONTH, -1); // 한달 전
		String startDate = null;
		if(("2020").equals(df.format(cal.getTime()).substring(0, 4))) { // 시작일
			startDate = "20210101"; // 2021년 전 인경우 2021년으로 세팅(2020년에 테스트 데이터들이 있음)
		} else {
			startDate = df.format(cal.getTime());
		}
		
		params.put("START_DATE", startDate);
		params.put("END_DATE", endDate);
		
		try {
			// BIZPLAY 데이터 호출하여 DB에 저장
			aprvMngService.insertBizplayData(params);
			// 저장된 BIZPLAY 데이터를 이용하여 결재 데이터 생성
			aprvMngService.insertBizplayAprv(params);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
