package kr.letech.cal.service;

import java.util.List;
import java.util.Map;

import org.springframework.ui.ModelMap;

public interface CalMngService {
	
	public void getCalList(Map params, ModelMap model) throws Exception;

	public int calInsert(Map params, List<Map<String, Object>> fileList) throws Exception;
	
	public Map getCalView(Map params) throws Exception;
	
	public void calUpdate(Map params, List<Map<String, Object>> fileList) throws Exception;
	
	public void calDelete(Map params) throws Exception;
	
	public void calFileInsert(Map params) throws Exception;
	
	public List getCalFileList(Map params) throws Exception;
	
	public void calFileDelete(Map params) throws Exception;
}
