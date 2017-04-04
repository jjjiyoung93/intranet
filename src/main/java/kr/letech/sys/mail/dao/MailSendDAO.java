package kr.letech.sys.mail.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.letech.cmm.service.impl.AbstractDAO;

@Repository("mailSendDAO")
public class MailSendDAO extends AbstractDAO {

	/**
	 * 메일발송 총 건수
	 * @param
	 * @return List
	 * @throws Exception
	 */
	public List mailSendList() throws Exception {
		return getList("mailSend.selectMailSendList");
	}

	/**
	 * 메일발송 결과 수정
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public void updateSendResult(Map params) throws Exception {
		update("mailSend.updateSendResult", params);
	}
}
