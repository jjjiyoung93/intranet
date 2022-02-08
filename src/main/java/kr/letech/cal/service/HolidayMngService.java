package kr.letech.cal.service;

import java.util.List;
import java.util.Map;

public interface HolidayMngService {
	
	public List getHolidyList(Map params) throws Exception;
	
	public Map getHolidyView(Map params) throws Exception;
	
	public void holidayInsert(Map params) throws Exception;
	
	public void holidayUpdate(Map params) throws Exception;

	public void holidayDelete(Map params) throws Exception;

	/**
	 * 휴일관리 목록 조회
	 * @param params : 기준년도(stdd_yr)
	 * @return
	 * @throws Exception
	 */
	public List getHolMngList(Map params) throws Exception;
	
	/**
	 * 공휴일 정보를 공공데이터 포털로부터 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List getHolidayInfo(Map params) throws Exception;

	/**
	 * 휴일 정보 삭제
	 * @param params
	 * @throws Exception
	 */
	public int holMngDelete(Map params) throws Exception;

	/**
	 * 휴일정보 최대 시퀀스
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int getHolMngMaxSeq(Map params) throws Exception;

	/**
	 * 휴일정보 등록/수정
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map mergeHolMng(Map params) throws Exception;

	/**
	 * 휴일정보 업데이트 : 공공데이터 포털 특일정보 api 동기화
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int holMngUpdateBySys(Map params) throws Exception;
}
