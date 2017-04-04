package kr.letech.cal.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.letech.cal.service.HolidayMngService;

import org.springframework.stereotype.Service;

@Service("holidayMngService")
public class HolidayMngServiceImpl implements HolidayMngService {

	/** calMngDAO */
	@Resource(name="holidayMngDAO")
	private HolidayMngDAO holidayMngDAO;

	/**
	 * 휴일 목록
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public List getHolidyList(Map params) throws Exception {
		
		return holidayMngDAO.getHolidayList(params);
	}
	
	/**
	 * 휴일 상세조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public Map getHolidyView(Map params) throws Exception {
		
		return holidayMngDAO.getHolidayView(params);
	}
	
	/**
	 * 휴일 등록
	 * @param params
	 * @throws Exception
	 */
	@Override
	public void holidayInsert(Map params) throws Exception {
		holidayMngDAO.holidayInsert(params);
	}
	
	/**
	 * 휴일 수정
	 * @param params
	 * @throws Exception
	 */
	@Override
	public void holidayUpdate(Map params) throws Exception {
		holidayMngDAO.holidayUpdate(params);
	}
	
	/**
	 * 휴일 삭제
	 * @param params
	 * @throws Exception
	 */
	@Override
	public void holidayDelete(Map params) throws Exception {
		holidayMngDAO.holidayDelete(params);
	}
}
