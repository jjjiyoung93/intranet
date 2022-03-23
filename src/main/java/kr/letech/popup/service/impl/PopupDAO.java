package kr.letech.popup.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.letech.cmm.service.impl.AbstractDAO;

@Repository("popupDAO")
public class PopupDAO extends AbstractDAO{

	public List<Map> getPopupList(Map paraMap) throws Exception {
		return getList("", paraMap);
	}

	public Map getPopup(Map paraMap) throws Exception {
		return (Map) getObject("", paraMap);
	}
	
}	
