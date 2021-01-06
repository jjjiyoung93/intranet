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
	
//	@Scheduled(cron = "0 0 17 * * *") // 매일 오후 5시에?
//	@Scheduled(cron = "0 0/1 * * * *") // 1분마다
	@Scheduled(cron = "0 0 07 * * *") // 매일 오전 7시에 
	public void bizplayAPI() {
		Map<String, Object> params = new HashMap<String, Object>(); // 넘겨줄 파라미터
		
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd", Locale.getDefault()); // 날짜 포맷 지정
		Calendar cal = Calendar.getInstance(); // 오늘 날짜  가져오기
		
		String endDate = df.format(cal.getTime()); // 종료일
		
		cal.add(Calendar.MONTH, -1); // 한달 전
		String startDate = null;
		if(("2020").equals(df.format(cal.getTime()).substring(0, 4))) { // 시작일
			startDate = "20210101"; // 2021년 전 인경우 2021년으로 세팅
		} else {
			startDate = df.format(cal.getTime());
		}
		
		params.put("START_DATE", startDate);
		params.put("END_DATE", endDate);
		
		System.err.println("##### BIZPLAY 시작 #####");
		System.err.println("startDate : " + startDate);
		System.err.println("endDate : " + endDate);
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
