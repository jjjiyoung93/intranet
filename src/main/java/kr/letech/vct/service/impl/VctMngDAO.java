package kr.letech.vct.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.letech.cmm.service.impl.AbstractDAO;

@Repository("vctMngDAO")
public class VctMngDAO extends AbstractDAO {

	/**
	 * 휴가부여일수 총 건수
	 * @param params
	 * @return
	 */
	public int getVctDayTotCount(Map params) throws Exception {
		return (Integer)getObject("vctMng.getVctDayTotCount", params);
	}

	/**
	 * 휴가부여일수 목록 조회 (pageing 처리)
	 * @param params
	 * @param offSet
	 * @param limit
	 * @return
	 */
	public List getVctDayPageList(Map params, int offSet, int limit) throws Exception {
		return getList("vctMng.getVctDayList", params, offSet, limit);
	}

	/**
	 * 휴가부여일수 등록, 수정 : MERGE
	 * @param params
	 * @throws Exception
	 */
	public int mergeVctDay(Map params) throws Exception {
		return (Integer)insert("vctMng.mergeVctDay", params);
	}
	
	
	/**
	 * 휴가현황조회 사용자 총 건수
	 * @param params
	 * @return
	 */
	public int getVctInfTotCount(Map params) throws Exception {
		return (Integer)getObject("vctMng.getVctInfTotCount", params);
	}
	
	/**
	 * 휴가현황조회 사용자 목록 조회 (pageing 처리)
	 * @param params
	 * @param offSet
	 * @param limit
	 * @return
	 */
	public List getVctInfPageList(Map params, int offSet, int limit) throws Exception {
		return getList("vctMng.getVctInfList", params, offSet, limit);
	}

	/**
	 * 휴가현황조회 휴가 현황 목록 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List getVctViewList(Map params) throws Exception {
		return getList("vctMng.getVctViewList", params);
	}

	/**
	 * 휴가현황집계 사원 총 수
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int getVctStatTotCount(Map params) throws Exception {
		return (Integer)getObject("vctMng.getVctStatTotCount", params);
	}

	
	/**
	 * 휴가현황집계 목록 조회
	 * @param params
	 * @param offSet
	 * @param limit
	 * @return
	 * @throws Exception
	 */
	public List getVctStatPageList(Map params, int offSet, int limit) throws Exception {
		return getList("vctMng.getVctStatList", params, offSet, limit);
	}

	/**
	 * 휴가정보 등록
	 * @param vctInfMap
	 * @return
	 * @throws Exception
	 */
	public int insertVctInf(Map params) throws Exception {
		return (Integer)insert("vctMng.insertVctInf", params);
	}

	/**
	 * 휴가정보 삭제
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int deleteVctInf(Map params) throws Exception {
		return (Integer)delete("vctMng.deleteVctInf", params);
	}
	
	

}
