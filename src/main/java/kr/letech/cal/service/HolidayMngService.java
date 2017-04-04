package kr.letech.cal.service;

import java.util.List;
import java.util.Map;

public interface HolidayMngService {
	
	public List getHolidyList(Map params) throws Exception;
	
	public Map getHolidyView(Map params) throws Exception;
	
	public void holidayInsert(Map params) throws Exception;
	
	public void holidayUpdate(Map params) throws Exception;

	public void holidayDelete(Map params) throws Exception;
}
