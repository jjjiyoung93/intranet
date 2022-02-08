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

	/**
	 * 휴일관리 - 휴일 목록 조회
	 * @param params 기준녀도(stdd_yr)
	 * @return
	 * @throws Exception
	 */
	public List getHolMngList(Map params) throws Exception {
		return getList("holidayMng.getHolMngList", params);
	}
	
	/**
	 * 휴일관리 - 휴일 상세 조회
	 * @param params 시퀀스(cal_hol_seq)
	 * @return
	 * @throws Exception
	 */
	public Map getHolMngView(Map params) throws Exception {
		return (Map)getObject("holidayMng.getHolMngView", params);
	}
	
	/**
	 * 휴일정보 건수 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int getHolidayCnt(Map params) throws Exception {
		return (Integer)getObject("holidayMng.getHolidayCnt", params);
	}
	
	/**
	 * 휴일정보 삭제
	 * @param params
	 * @throws Exception
	 */
	public int deleteHolMng(Map params) throws Exception {
		return (Integer)delete("holidayMng.deleteHolMng", params);
	}
	
	/**
	 * 휴일정보 시퀀스 최댓값
	 * @param params
	 * @throws Exception
	 */
	public int getHolMngMaxSeq(Map params) throws Exception {
		return (Integer)getObject("holidayMng.getHolMngMaxSeq", params);
	}

	/**
	 * 휴일정보 등록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int insertHolMng(Map paramMap) throws Exception {
		return (Integer)insert("holidayMng.insertHolMng", paramMap);
	}
	
	/**
	 * 휴일정보 수정
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int updateHolMng(Map paramMap) throws Exception {
		return (Integer)update("holidayMng.updateHolMng", paramMap);
	}

	/**
	 * 휴일정보 SYSTEM 등록 건 삭제
	 * @param params
	 * @throws Exception
	 */
	public void deleteHolMngBySys(Map params) throws Exception {
		delete("holidayMng.deleteHolMngBySys", params);
		
	}
	
	/**
	 * 휴일정보 등록 BY SYSTEM
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int insertHolMngBySys(Map paramMap) throws Exception {
		return (Integer)insert("holidayMng.insertHolMngBySys", paramMap);
	}
}
