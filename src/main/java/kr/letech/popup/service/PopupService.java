package kr.letech.popup.service;

import java.util.List;
import java.util.Map;

public interface PopupService {

	List<Map> getPopupList(Map paraMap) throws Exception;

	Map getPopup(Map paraMap) throws Exception;

}
