package kr.letech.cmm.schedule;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import kr.letech.sys.mail.service.MailSendService;

@Component
public class CmmScheduler {

	/**
	 * 메일보내기 관리 서비스
	 */
	@Resource(name = "mailSendService")
	private MailSendService mailSendService;

	@Scheduled(fixedDelay=30000)
	public void mailSender() throws Exception {
		mailSendService.searchMailSend();
	}
}
