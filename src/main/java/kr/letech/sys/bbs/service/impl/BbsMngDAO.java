package kr.letech.sys.bbs.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.letech.cmm.service.impl.AbstractDAO;

@Repository("bbsMngDAO")
public class BbsMngDAO extends AbstractDAO{

	/**
	 * 게시판 리스트 조회
	 * @param params
	 * @return
	 */
	public List get00List(Map params)throws Exception {
		return getList("bbsMng.get00List", params);
	}

	/**
	 * 게시판 등록
	 * @param params
	 * @throws Exception
	 */
	public void insertBbs(Map params) throws Exception {
		insert("bbsMng.insertBbs", params);
	}

	/**
	 * 게시판 수정
	 * @param params
	 * @throws Exception
	 */
	public void updateBbs(Map params) throws Exception {
		insert("bbsMng.updateBbs", params);		
	}

	/**
	 * 게시판 삭제
	 * @param params
	 * @throws Exception
	 */
	public void deleteBbs(Map params) throws Exception {
		insert("bbsMng.deleteBbs", params);		
	}

	/**
	 * 게시판 정보 상세보기
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map getView(Map params) throws Exception {
		return (Map) getObject("bbsMng.getView", params);
	}

}
