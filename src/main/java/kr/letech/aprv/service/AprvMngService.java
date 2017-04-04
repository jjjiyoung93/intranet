package kr.letech.aprv.service;

import java.util.List;
import java.util.Map;

public interface AprvMngService {
	
	/**
	 * 페이징처리, 결재정보 목록조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map getAprvPageingList(Map params) throws Exception;
	
	/**
	 * 결재정보 목록조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List getAprvList(Map params) throws Exception;
	
	/**
	 * 결재 총건수
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int getAprvTotalCount(Map params) throws Exception;
	
	/**
	 * 결재정보 상세조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map getAprvView(Map params) throws Exception;
	
	/**
	 * 결재정보 등록
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int aprvInsert(Map params, List fileList) throws Exception;
	public void aprvInsert2(Map params) throws Exception;
	
	/**
	 * 결재정보 수정
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int aprvUpdate(Map params, List fileList) throws Exception;
	
	/**
	 * 결재정보 삭제
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int aprvDelete(Map params) throws Exception;

	/**
	 * 결재라인 등록
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int aprvLineInsert(Map params) throws Exception;
	
	/**
	 * 결재라인 삭제
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int aprvLineDelete(Map params) throws Exception;
	
	public List aprvLineList(Map params) throws Exception;
	
	public void aprvLineUpdate(Map params) throws Exception ;
	
	public List aprvFileList(Map params) throws Exception;
	
	public void aprvFileDelete(Map params) throws Exception;

	/**
	 * 결제중, 반려, 보류인 정보 조회(aprv_yn_cd = 0:결재중, 3:반려, 2:보류 )
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List layerAprvInfo(Map params) throws Exception;

	/**
	 * 결제중, 반려, 보류인 정보 건수조회(aprv_yn_cd = 0:결재중, 3:반려, 2:보류 )
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int layerAprvInfoCount(Map params) throws Exception;

	/**
	 * 결재자가 결재할 정보를 확인한 경우
	 * @param params
	 * @throws Exception
	 */
	public void updateConfYn(Map params) throws Exception ;
}
