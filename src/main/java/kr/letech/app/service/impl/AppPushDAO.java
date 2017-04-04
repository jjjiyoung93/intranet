package kr.letech.app.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.letech.cmm.service.impl.AbstractDAO;

@Repository("appPushDAO")
public class AppPushDAO extends AbstractDAO {

	/**
	 * 구글 푸시 발송 정보 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<String> getSelectAppPushList(Map<String, Object> params) throws Exception {
		return getList("appPush.getSelectAppPushList", params);
	}

	/**
	 * 구글 푸시 발송 조회 결제관리
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<String> getSelectAppPushListPayment(Map<String, Object> params) throws Exception {
		return getList("appPush.getSelectAppPushListPayment", params);
	}
}
