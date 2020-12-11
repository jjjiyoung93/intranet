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
		
		cal.add(Calendar.DATE, -1); // 하루 전 날
		String endDate = df.format(cal.getTime()); // 종료일
		
		cal.add(Calendar.MONTH, -1); // 하루 전 + 한달 전
		String startDate = df.format(cal.getTime()); // 시작일
		
		params.put("START_DATE", startDate);
		params.put("END_DATE", endDate);
		
		try {
			aprvMngService.loadBizplay(params);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
