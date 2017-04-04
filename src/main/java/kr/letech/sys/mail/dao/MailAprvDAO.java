package kr.letech.sys.mail.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.letech.cmm.service.impl.AbstractDAO;

@Repository("mailAprvDAO")
public class MailAprvDAO extends AbstractDAO {

	public Map getAprvLineInfo(Map params) throws Exception {
		return (Map)getObject("mailAprv.getAprvLineInfo", params);
	}
	
	public Map getUppAprvLineInfo(Map params) throws Exception {
		return (Map)getObject("mailAprv.getUppAprvLineInfo", params);
	}
	
	public int setMailSend(Map params) throws Exception {
		return (Integer)insert("mailAprv.setMailSend", params);
	}

	public int outMailSend(Map params) throws Exception {
		return delete("mailAprv.outMailSend", params);
	}

	public int getRefeCount(Map params) throws Exception {
		return (Integer) getObject("mailAprv.getRefeCount", params);
	}

	public int getMailSeq() throws Exception {
		return (Integer) getObject("mailAprv.getMailSeq");
	}
}
