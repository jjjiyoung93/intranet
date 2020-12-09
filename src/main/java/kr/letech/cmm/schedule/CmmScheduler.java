package kr.letech.cmm.schedule;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import kr.letech.aprv.service.AprvMngService;
import kr.letech.cmm.util.ReqUtils;
import kr.letech.sys.mail.service.MailSendService;

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
	
	@Scheduled(cron = "0 0 07 * * *") // 오전 7시에 
//	@Scheduled(cron = "0 0 17 * * *") // 오후 5시에?
//	@Scheduled(cron = "0 0/1 * * * *") // 매 분 0초 마다
	public void bizplayAPI() {
		System.err.println("############### bizplay 호출 ###############");
		System.err.println("############### bizplay 호출 ###############");
		System.err.println("############### bizplay 호출 ###############");
		System.err.println("############### bizplay 호출 ###############");
		System.err.println("############### bizplay 호출 ###############");
		System.err.println("############### bizplay 호출 ###############");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("START_DATE", "20201120");
		params.put("END_DATE", "20201220");
		
		try {
			aprvMngService.loadBizplay(params);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
