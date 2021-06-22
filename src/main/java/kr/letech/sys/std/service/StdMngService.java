package kr.letech.sys.std.service;

import java.util.List;
import java.util.Map;

public interface StdMngService {

	/**
	 * 여비정보 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	List get00List(Map params)throws Exception;

	/**
	 * 여비정보 등록
	 * @param params
	 * @throws Exception
	 */
	void insertGrp(Map params)throws Exception;

	/**
	 * 여비정보 수정
	 * @param params
	 * @throws Exception
	 */
	void updateGrp(Map params)throws Exception;

	/**
	 * 여비정보 삭제
	 * @param params
	 * @throws Exception
	 */
	void deleteGrp(Map params)throws Exception;

	/**
	 * 여비정보 상세보기
	 * @param params
	 * @return
	 * @throws Exception
	 */
	Map getView(Map params)throws Exception;
	
	/**
	 * 여비정보 개수 보기
	 * @param params
	 * @return
	 * @throws Exception
	 */
	Map getCnt00(Map params)throws Exception;
	
	
	/**
	 * 그룹별급수 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	List get01List(Map params)throws Exception;
	
	/**
	 * 그룹별급수 등록
	 * @param params
	 * @throws Exception
	 */
	void insertAut(Map params)throws Exception;
	
	/**
	 * 그룹별급수 수정
	 * @param params
	 * @throws Exception
	 */
	void updateAut(Map params)throws Exception;
	
	/**
	 * 그룹별급수 삭제
	 * @param params
	 * @throws Exception
	 */
	void deleteAut(Map params)throws Exception;
	
	/**
	 * 그룹별급수 상세보기
	 * @param params
	 * @return
	 * @throws Exception
	 */
	Map getView2(Map params)throws Exception;
	
	/**
	 * 여비정보 개수 보기
	 * @param params
	 * @return
	 * @throws Exception
	 */
	Map getCnt01(Map params)throws Exception;
	
	/**
	 * 교통비 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	List get02List(Map params)throws Exception;
	
	/**
	 * 교통비 등록
	 * @param params
	 * @throws Exception
	 */
	void insertTrcs(Map params)throws Exception;
	
	/**
	 * 교통비 수정
	 * @param params
	 * @throws Exception
	 */
	void updateTrcs(Map params)throws Exception;
	
	/**
	 * 교통비 삭제
	 * @param params
	 * @throws Exception
	 */
	void deleteTrcs(Map params)throws Exception;
	
	/**
	 * 교통비 상세보기
	 * @param params
	 * @return
	 * @throws Exception
	 */
	Map getView3(Map params)throws Exception;
	
	/**
	 * 권한그룹 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	List getAuthorList(Map params) throws Exception;

	/**
	 * 수정시 새로 추가할  지역 코드 목록
	 * @param params
	 * @return
	 * @throws Exception
	 */
	List getAddList(Map params) throws Exception;

	/**
	 * 교통비 정보 갯수 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	Map getRegnCnt(Map params) throws Exception;

	/**
	 * 지역 코드 목록 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	List getTrcsCdList(Map params) throws Exception;

}
