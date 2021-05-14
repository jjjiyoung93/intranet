package kr.letech.sys.std.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.letech.cmm.service.impl.AbstractDAO;

@Repository("stdMngDAO")
public class StdMngDAO extends AbstractDAO{

	/**
	 * 여비정보 리스트 조회
	 * @param params
	 * @return
	 */
	public List get00List(Map params)throws Exception {
		return getList("stdMng.get00List", params);
	}

	/**
	 * 여비정보 등록
	 * @param params
	 * @throws Exception
	 */
	public void insertGrp(Map params) throws Exception {
		insert("stdMng.insertGrp", params);
	}

	/**
	 * 여비정보 수정
	 * @param params
	 * @throws Exception
	 */
	public void updateGrp(Map params) throws Exception {
		insert("stdMng.updateGrp", params);		
	}

	/**
	 * 여비정보 삭제
	 * @param params
	 * @throws Exception
	 */
	public void deleteGrp(Map params) throws Exception {
		insert("stdMng.deleteGrp", params);		
	}

	/**
	 * 여비정보 정보 상세보기
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map getView(Map params) throws Exception {
		return (Map) getObject("stdMng.getView", params);
	}
	
	
	/**
	 * 그룹별급수 리스트 조회
	 * @param params
	 * @return
	 */
	public List get01List(Map params)throws Exception {
		return getList("stdMng.get01List", params);
	}
	
	/**
	 * 그룹별급수 등록
	 * @param params
	 * @throws Exception
	 */
	public void insertAut(Map params) throws Exception {
		insert("stdMng.insertAut", params);
	}
	
	/**
	 * 그룹별급수 수정
	 * @param params
	 * @throws Exception
	 */
	public void updateAut(Map params) throws Exception {
		insert("stdMng.updateAut", params);		
	}
	
	/**
	 * 그룹별급수 삭제
	 * @param params
	 * @throws Exception
	 */
	public void deleteAut(Map params) throws Exception {
		insert("stdMng.deleteAut", params);		
	}
	
	/**
	 * 그룹별급수 상세보기
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map getView2(Map params) throws Exception {
		return (Map) getObject("stdMng.getView2", params);
	}
	
	
	/**
	 * 교통비 리스트 조회
	 * @param params
	 * @return
	 */
	public List get02List(Map params)throws Exception {
		return getList("stdMng.get02List", params);
	}
	
	/**
	 * 교통비 등록
	 * @param params
	 * @throws Exception
	 */
	public void insertTrcs(Map params) throws Exception {
		insert("stdMng.insertTrcs", params);
	}
	
	/**
	 * 교통비 수정
	 * @param params
	 * @throws Exception
	 */
	public void updateTrcs(Map params) throws Exception {
		insert("stdMng.updateTrcs", params);		
	}
	
	/**
	 * 교통비 삭제
	 * @param params
	 * @throws Exception
	 */
	public void deleteTrcs(Map params) throws Exception {
		insert("stdMng.deleteTrcs", params);		
	}
	
	/**
	 * 교통비 상세보기
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map getView3(Map params) throws Exception {
		return (Map) getObject("stdMng.getView3", params);
	}

	/**
	 * 권한 그룹 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List getAuthorList(Map params) throws Exception {
		return getList("stdMng.getAuthorList", params);
	}

	/**
	 * 급수별 여비 갯수 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map getCnt00(Map params) throws Exception {
		return (Map) getObject("stdMng.getCnt00", params);
	}

	/**
	 * 그룹별 급수 갯수 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map getCnt01(Map params) throws Exception {
		return (Map) getObject("stdMng.getCnt01", params);
	}

}
