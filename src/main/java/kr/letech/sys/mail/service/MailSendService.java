package kr.letech.sys.mail.service;

public interface MailSendService {

	/*
	 * STD_MAIL_SEND Table을 검색하여 발송할 메일 발송 목록 검색
	 * 메일 발송후 완료처리
	 **/
	public void searchMailSend() throws Exception;
}
