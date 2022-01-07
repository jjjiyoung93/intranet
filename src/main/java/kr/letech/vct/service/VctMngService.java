package kr.letech.vct.service;

import java.util.Map;

public interface VctMngService {
	
	
	/**
	 * 휴가일수 목록 조회 (총건수, 페이징 조회)
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map getVctDayPageingList(Map params) throws Exception;

	/**
	 * 휴가부여일수 수정(등록, 수정 merge)
	 * @param params
	 * @throws Exception
	 */
	public int mergeVctDay(Map params) throws Exception;
	
	/**
	 * 휴가현황조회 사용자 목록 조회 (총건수, 페이징 조회)
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map getVctInfPageingList(Map params) throws Exception;

}
