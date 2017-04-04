package kr.letech.app.service;

import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface AppLoginService {

	public EgovMap getSelectAppLogin(Map<String, Object> params) throws Exception;
	
	//public EgovMap getCertification(Map<String, Object> params) throws Exception;
	
	public EgovMap getSelectSettingInfo(Map<String, Object> params) throws Exception;
}
