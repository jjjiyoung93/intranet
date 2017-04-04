package kr.letech.sys.mail.service;

import java.util.Map;

public interface MailReceService {

	void sendMailConfRece(Map<String, Object> params) throws Exception;
	
}
