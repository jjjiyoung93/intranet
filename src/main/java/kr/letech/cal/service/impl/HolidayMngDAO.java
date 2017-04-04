package kr.letech.cal.service.impl;

import java.util.List;
import java.util.Map;

import kr.letech.cmm.service.impl.AbstractDAO;

import org.springframework.stereotype.Repository;

@Repository("holidayMngDAO")
public class HolidayMngDAO extends AbstractDAO {

	/**
	 * 휴일정보 목록
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List getHolidayList(Map params) throws Exception {
		return getList("holidayMng.getHolidayList", params);
	}
	
	/**
	 * 휴일정보 상세조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map getHolidayView(Map params) throws Exception {
		return (Map) getObject("holidayMng.getHolidayView", params);
	}
	
	/**
	 * 휴일정보 등록
	 * @param params
	 * @throws Exception
	 */
	public void holidayInsert(Map params) throws Exception {
		insert("holidayMng.holidayInsert", params);
	}
	
	/**
	 * 휴일정보 수정
	 * @param params
	 * @throws Exception
	 */
	public void holidayUpdate(Map params) throws Exception {
		update("holidayMng.holidayUpdate", params);
	}
	
	/**
	 * 휴일정보 삭제
	 * @param params
	 * @throws Exception
	 */
	public void holidayDelete(Map params) throws Exception {
		delete("holidayMng.holidayDelete", params);
	}
}
