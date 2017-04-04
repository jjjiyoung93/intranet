package kr.letech.app.service.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.letech.cmm.service.impl.AbstractDAO;

@Repository("appLoginDAO")
public class AppLoginDAO extends AbstractDAO {

	/**
	 * 회원 정보 체크 (앱에서 로그인 정보)
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> getSelectAppLogin(Map<String, Object> params) throws Exception {
		return (Map<String, Object>)getObject("appLogin.getSelectAppLogin", params);
	}

	/**
	 * 회원 정보 체크 (앱에서 로그인 - 인증키)
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> getSelectAppLoginCret(Map<String, Object> params) throws Exception {
		return (Map<String, Object>)getObject("getSelectAppLoginCret", params);
	}
	
	/**
	 * 폰 토큰번호 저장
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int insertAppMng(Map<String, Object> params) throws Exception {
		return (Integer)insert("insertAppMng", params);
	}
	
	
	/**
	 * 푸시셋팅정보 호출
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public EgovMap getSelectSettingInfo(Map<String, Object> params) throws Exception {
		return (EgovMap) getObject("getSelectSettingInfo", params);
	}
}
