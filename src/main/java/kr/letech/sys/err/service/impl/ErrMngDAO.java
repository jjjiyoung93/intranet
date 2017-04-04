package kr.letech.sys.err.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.letech.cmm.service.impl.AbstractDAO;

@Repository("errMngDAO")
public class ErrMngDAO extends AbstractDAO{

	/**
	 * 발생에러 카운트
	 * @param params
	 * @return
	 * @throws Exception 
	 */
	public int get00ErrListCnt(Map params) throws Exception {
		return (Integer) getObject("errMng.get00ErrListCnt", params);
	}
	
	/**
	 * 발생에러 조회
	 * @param params
	 * @return
	 * @throws Exception 
	 */
	public List get00List(Map params, int offSet, int limit) throws Exception {
		return getList("errMng.get00List", params, offSet, limit);
	}
	
	/**
	 * 발생에러 상세 조회
	 * @param params
	 * @return
	 * @throws Exception 
	 */
	public Map get00ErrView(Map params) throws Exception {
		return (Map) getObject("errMng.get00ErrView", params);
	}

	/**
	 * 처리상태 변경(확인중)
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public void updateProcessState(Map params) throws Exception {
		update("errMng.updateProcessState", params);
	}

	/**
	 * 완료처리
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public void updateCompletion(Map params) throws Exception {
		update("errMng.updateCompletion", params);
	}

	/**
	 * 저장처리
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public void updateSave(Map params) throws Exception {
		update("errMng.updateSave", params);
	}
	
	/**
	 * 완료처리 카운트
	 * @param params
	 * @return
	 * @throws Exception 
	 */
	public int get01ErrListCnt(Map params) throws Exception {
		return (Integer) getObject("errMng.get01ErrListCnt", params);
	}
	
	/**
	 * 처리이력 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List get01List(Map params, int offSet, int limit) throws Exception {
		return getList("errMng.get01List", params, offSet, limit);
	}

	public Map get01ErrView(Map params) throws Exception {
		return (Map) getObject("errMng.get01ErrView", params);
	}
}
