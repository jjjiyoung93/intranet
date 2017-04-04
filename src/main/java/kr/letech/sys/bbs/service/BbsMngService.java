package kr.letech.sys.bbs.service;

import java.util.List;
import java.util.Map;

public interface BbsMngService {

	/**
	 * 게시판 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	List get00List(Map params)throws Exception;

	/**
	 * 게시판 등록
	 * @param params
	 * @throws Exception
	 */
	void insertBbs(Map params)throws Exception;

	/**
	 * 게시판 수정
	 * @param params
	 * @throws Exception
	 */
	void updateBbs(Map params)throws Exception;

	/**
	 * 게시판 삭제
	 * @param params
	 * @throws Exception
	 */
	void deleteBbs(Map params)throws Exception;

	/**
	 * 게시판 정보 상세보기
	 * @param params
	 * @return
	 * @throws Exception
	 */
	Map getView(Map params)throws Exception;

}
