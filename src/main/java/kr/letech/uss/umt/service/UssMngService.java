package kr.letech.uss.umt.service;

import java.util.List;
import java.util.Map;

public interface UssMngService {

	public Map getUssPageingList(Map params) throws Exception;
	
	public List getUssList(Map params) throws Exception;
	
	public int getUssTotCount(Map params) throws Exception;
	
	public String checkRepetition(Map params) throws Exception;
	
	public String emNoCheckRepetition(Map params) throws Exception;
	
	public void ussInsert(Map params) throws Exception;
	
	public Map getUssView(Map params) throws Exception;
	
	public void ussUpdate(Map params) throws Exception;
	
	public void ussDelete(Map params) throws Exception;
	
	/**
	 * 팝업검색 페이지 처리, 목록정보 가져오기
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map getUssPageingListPopup(Map params) throws Exception;
	
	/**
	 * 부서목록 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List getUssDepartList(Map params) throws Exception;
}
