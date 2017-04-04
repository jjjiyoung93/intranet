package kr.letech.app.service;

import java.util.Map;

public interface AppPushService {
	
	public void googlePushSend(Map<String, Object> params) throws Exception;
	
	public void googlePushSendPayment(Map<String, Object> params) throws Exception;

}
