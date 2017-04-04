package kr.letech.app.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface AppBbsService {

	public List<EgovMap> getSelectBbsPageInfo(Map<String, Object> params) throws Exception;
	
	public EgovMap getSelectAppBbsView(Map<String, Object> params) throws Exception;
	
	public List<EgovMap> getSelectPaymentPageInfo(Map<String, Object> params) throws Exception;
	
	public String getSelectPaymentPageInfoCnt(Map<String, Object> params) throws Exception;
	
	public EgovMap getSelectAppPaymnentView(Map<String, Object> params) throws Exception;
	
	public List<EgovMap> getSelectAppPaymnentLineView(Map<String, Object> params) throws Exception;
	
	
}
