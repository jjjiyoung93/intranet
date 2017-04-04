package kr.letech.cal.service.impl;

import java.util.List;
import java.util.Map;

import kr.letech.cmm.service.impl.AbstractDAO;

import org.springframework.stereotype.Repository;

@Repository("calMngDAO")
public class CalMngDAO extends AbstractDAO {

	/**
	 * 일정 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List getCalList(Map params) throws Exception {
		return getList("calMng.getCalList", params);
	}
	
	/**
	 * 일정 등록
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int calInsert(Map params) throws Exception {
		insert("calMng.calInsert", params);
		int cal_seq = (Integer)params.get("cal_seq");
		return cal_seq;
	}
	
	/**
	 * 일정 상세정보 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map getCalView(Map params) throws Exception {
		return (Map)getObject("calMng.getCalView", params);
	}
	
	/**
	 * 일정 수정
	 * @param params
	 * @throws Exception
	 */
	public void calUpdate(Map params) throws Exception {
		update("calMng.calUpdate", params);
	}
	
	/**
	 * 일정 삭제
	 * @param params
	 * @throws Exception
	 */
	public void calDelete(Map params) throws Exception {
		delete("calMng.calDelete", params);
	}
	
	/**
	 * 일정 파일 등록
	 * @param params
	 * @throws Exception
	 */
	public void calFileInsert(Map params) throws Exception {
		insert("calMng.calFileInsert", params);
	}
	
	/**
	 * 일정 파일정보 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List getCalFileList(Map params) throws Exception {
		return getList("calMng.getCalFileList", params);
	}
	
	/**
	 * 일정 파일 삭제 (일정 시퀀스로 삭제)
	 * @param params
	 * @throws Exception
	 */
	public void calFileDelete(Map params) throws Exception {
		delete("calMng.calFileDelete", params);
	}
	
	/**
	 * 일정파일 삭제 (파일 시퀀스로 삭제)
	 * @param params
	 * @throws Exception
	 */
	public void calFileOneDelete(Map params) throws Exception {
		delete("calMng.calFileOneDelete", params);
	}
}
