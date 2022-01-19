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
	
	/**
	* 결재라인 삭제
	* @Method : deleteAprvLine
	* @Author : JO MIN SOO
	* @Date : 2021. 1. 26.
	* @param params
	* @return
	* @throws Exception
	*/
	public int deleteAprvLine(Map params) throws Exception {
		return delete("ussMng.deleteAprvLine", params);
	}
	
	/**
	* 결재라인 생성
	* @Method : insertAprvLine
	* @Author : JO MIN SOO
	* @Date : 2021. 1. 26.
	* @param params
	* @return
	* @throws Exception
	*/
	public int insertAprvLine(Map params) throws Exception {
		return (Integer) insert("ussMng.insertAprvLine", params);
	}
	
	/**
	 * 재직중 사원 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List getWorkUssList(Map params) throws Exception {
		return getList("ussMng.getWorkUssList", params);
	}
	
	/**
	 * 사용자 생일 캘린더 수정
	 * @param params
	 * @throws Exception
	 */
	public void updateBirCalSeq(Map params) throws Exception {
		update("ussMng.updateBirCalSeq", params);
	}
	
	/**
	 * 사용자 근속 년수 수정
	 * @param params
	 * @throws Exception
	 */
	public void updateWorkYrCnt(Map params) throws Exception {
		update("ussMng.updateWorkYrCnt", params);
	}
	
	
}
