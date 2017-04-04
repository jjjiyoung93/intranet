package kr.letech.uss.umt.service.impl;

import java.util.List;
import java.util.Map;

import kr.letech.cmm.service.impl.AbstractDAO;

import org.springframework.stereotype.Repository;

@Repository("ussMngDAO")
public class UssMngDAO extends AbstractDAO {

	/**
	 * 사용자 목록조회(pageing처리)
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List getUssPageList(Map params, int offSet, int limit) throws Exception {
		return getList("ussMng.getUssList", params, offSet, limit);
	}
	/**
	 * 사용자 목록조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List getUssList(Map params) throws Exception {
		return getList("ussMng.getUssList", params);
	}
	/**
	 * 사용자 총건수
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int getUssTotCount(Map params) throws Exception {
		return (Integer)getObject("ussMng.getUssTotCount", params);
	}
	/**
	 * ID중복체크
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int checkRepetition(Map params) throws Exception {
		return (Integer)getObject("ussMng.idCheckRepetition", params);
	}
	
	/**
	 * 사원번호 중복체크
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int emNoCheckRepetition(Map params) throws Exception {
		return (Integer)getObject("ussMng.emNoCheckRepetition", params);
	}
	/**
	 * 사용자 등록
	 * @param params
	 * @throws Exception
	 */
	public void ussInsert(Map params) throws Exception {
		insert("ussMng.ussInsert", params);
	}
	/**
	 * 상세조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map getUssView(Map params) throws Exception {
		return (Map)getObject("ussMng.getUssView", params);
	}
	
	/**
	 * 사용자 수정
	 * @param params
	 * @throws Exception
	 */
	public void ussUpdate(Map params) throws Exception {
		update("ussMng.ussUpdate", params);
	}
	
	/**
	 * 사용자 삭제
	 * @param params
	 * @throws Exception
	 */
	public void ussDelete(Map params) throws Exception {
		delete("ussMng.ussDelete", params);
	}

	/**
	 * 팝업검색 사용자 목록조회(pageing처리)
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List getUssPageListPopup(Map params, int offSet, int limit) throws Exception {
		return getList("ussMng.getUssListPopup", params, offSet, limit);
	}
	/**
	 * 팝업검색 사용자 총건수
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int getUssTotCountPopup(Map params) throws Exception {
		return (Integer)getObject("ussMng.getUssTotCountPopup", params);
	}

	/**
	 * 부서목록 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List getUssDepartList(Map params) throws Exception {
		return getList("ussMng.getUssDepartList", params);
	}
}
