package kr.letech.sys.mail.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.letech.cmm.service.impl.AbstractDAO;

@Repository("mailReceDAO")
public class MailReceDAO extends AbstractDAO {

	public Map getReceInfo(Map params) throws Exception {
		return (Map)getObject("mailRece.getReceInfo", params);
	}

	public int setConfRece(Map params) throws Exception {
		return update("mailRece.setConfRece", params);
	}
}
