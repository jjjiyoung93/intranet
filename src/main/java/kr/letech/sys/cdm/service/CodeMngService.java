package kr.letech.sys.cdm.service;

import java.util.List;
import java.util.Map;

public interface CodeMngService {

	/**
	 * 상위 코드 리스트 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	List getOneCodeList(Map params)throws Exception;

	/**
	 * 코드 리스트 조회
	 * @param params(up_cd:상위코드)
	 * @return
	 * @throws Exception
	 */
	List getCodeList(Map params)throws Exception;

	/**
	 * 코드 상세정보
	 * @param params
	 * @return
	 * @throws Exception
	 */
	Map getCodeView(Map params)throws Exception;

	/**
	 * 코드 등록
	 * @param params
	 * @throws Exception
	 */
	void insert(Map params)throws Exception;
	
	/**
	 * 하위 코드 등록
	 * @param params
	 * @throws Exception
	 */
	void insertLow(Map params) throws Exception;

	/**
	 * 등록 코드 최대값 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	Map getMaxOrdr(Map params)throws Exception;

	/**
	 * 코드 수정
	 * @param params
	 * @throws Exception
	 */
	void updateNm(Map params)throws Exception;

	/**
	 * 코드 삭제(단일)
	 * @param params
	 * @throws Exception
	 */
	void delete(Map params)throws Exception;

	/**
	 * 하위코드 삭제
	 * @param params
	 * @throws Exception
	 */
	void deleteAll(Map params)throws Exception;
	
	/**
	 * 코드 갯수 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	Map getCodeCnt(Map params) throws Exception;

	/**
	 * 전체 코드 조회
	 * @Method : getAllCodeList
	 * @Author : KIM JI YOUNG
	 * @Date   : 2022.03.21
	 */
	Map getAllCodeList(Map params) throws Exception;



}
