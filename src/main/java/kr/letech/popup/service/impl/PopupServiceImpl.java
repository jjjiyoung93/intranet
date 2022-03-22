package kr.letech.popup.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.letech.popup.service.PopupService;

@Service("popupService")
public class PopupServiceImpl implements PopupService{
	
	@Resource(name = "popupDAO")
	private PopupDAO popupDAO;

	@Override
	public List<Map> getPopupList(Map paraMap) throws Exception {
		List<Map> popupList = popupDAO.getPopupList(paraMap);
		return popupList;
	}

	@Override
	public Map getPopup(Map paraMap) throws Exception {
		Map popup = popupDAO.getPopup(paraMap);
		return popup;
	}
	
}
