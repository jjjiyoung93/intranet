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
	public int insertGrp(Map params) throws Exception {
		return (Integer)insert("stdMng.insertGrp", params);
	}
	
	/**
	 * 여비정보 코드 등록
	 * @param params
	 * @throws Exception
	 */
	public void insertGrpCd(Map params) throws Exception {
		insert("stdMng.insertGrpCd", params);
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
	 * 여비정보 코드 삭제
	 * @param params
	 * @throws Exception
	 */
	public void deleteGrpCd(Map params) throws Exception {
		insert("stdMng.deleteGrpCd", params);		
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
		return (Map) getObject("stdMng.getGrpCnt", params);
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

	/**
	 * 수정시 새로 추가할 지역 코드 목록
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List getAddList(Map params) throws Exception {
		return getList("stdMng.getAddList", params);
	}

	/**
	 * 권한구분코드 추가
	 * @param params
	 * @throws Exception
	 */
	public void insertAutCd(Map params) throws Exception {
		insert("stdMng.insertAutCd", params);
		
	}

	/**
	 * 권한 정보 추가
	 * @param params
	 * @throws Exception
	 */
	public void insertAutInfo(Map params) throws Exception {
		insert("stdMng.insertAutInfo", params);
		
	}

	/**
	 * 권한 코드 - 권한 정보 연결
	 * @param params
	 * @throws Exception
	 */
	public void updateAutCd(Map params) throws Exception {
		update("stdMng.updateAutCd", params);
	}

	/**
	 * 권한 상속 관계 삽입
	 * @param params
	 * @throws Exception
	 */
	public void insertRoleHic(Map params) throws Exception {
		insert("stdMng.insertRoleHic", params);
		
	}

	/**
	 * 권한 구분 코드 가져오기
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map getAutCdView(Map params) throws Exception {
		return (Map) getObject("stdMng.getAutCdView", params);
	}

	/**
	 * 권한 정보 가져오기
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map getAuthInfoView(Map params) throws Exception {
		return (Map) getObject("stdMng.getAuthInfoView", params);
	}

	/**
	 * 급수 정보 가져오기
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map getGrpCdView(Map params) throws Exception {
		return (Map) getObject("stdMng.getGrpCdView", params);
	}

	/**
	 * 권한 정보 테이블 연구직 명 변경
	 * @param params
	 * @throws Exception
	 */
	public void updateRsrChNm(Map params) throws Exception {
		update("stdMng.updateRsrchNm", params);
	}

	/**
	 * 급수 코드를 이용하여 그룹별 급수 삭제
	 * @param params
	 * @throws Exception
	 */
	public void deleteTrvctGrupAut(Map params) throws Exception {
		delete("stdMng.deleteTrvctGrupAut", params);
	}

	/**
	 * 출장 지역 공통코드 등록
	 * @param params
	 * @throws Exception
	 */
	public void insertTrcsCd(Map params) throws Exception {
		insert("stdMng.insertTrcsCd", params);
		
	}

	/**
	 * 출장 지역 공통 코드 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map selectTrcsCd(Map params) throws Exception {
		return (Map)getObject("stdMng.getTrcsCdView", params);
	}

	/**
	 * 교통비 정보 갯수 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map getRegnCnt(Map params) throws Exception {
		return (Map)getObject("stdMng.getRegnCnt", params);
	}

	/**
	 * 지역 코드 목록 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List getTrcsCdList(Map params) throws Exception {
		return getList("stdMng.getTrcsCdList", params);
	}
	
	

}
