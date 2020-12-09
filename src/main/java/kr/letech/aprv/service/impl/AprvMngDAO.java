package kr.letech.aprv.service.impl;

import java.util.List;
import java.util.Map;

import kr.letech.cmm.service.impl.AbstractDAO;

import org.springframework.stereotype.Repository;

@Repository("aprvMngDAO")
public class AprvMngDAO extends AbstractDAO {

	/**
	 * 결재정보 목록조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List getAprvPageingList(Map params, int offSet, int limit) throws Exception {
		return getList("aprvMng.getAprvList", params, offSet, limit);
	}

	/**
	 * 결재정보 목록조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List getAprvList(Map params) throws Exception {
		return getList("aprvMng.getAprvList", params);
	}
	
	/**
	 * 결재정보 총 건수
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int getAprvTotalCount(Map params) throws Exception {
		return (Integer)getObject("aprvMng.getAprvTotalCount", params);
	}
	
	/**
	 * 결재정보 상세조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map getAprvView(Map params) throws Exception {
		return (Map)getObject("aprvMng.getAprvView", params);
	}
	
	/**
	 * 결재정보 등록
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int aprvInsert(Map params) throws Exception {
		return (Integer)insert("aprvMng.aprvInsert", params);
	}
	
	/**
	 * 결재정보 수정
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int aprvUpdate(Map params) throws Exception {
		return update("aprvMng.aprvUpdate", params);
	}
	
	/**
	 * 결재정보 삭제
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int aprvDelete(Map params) throws Exception {
		return delete("aprvMng.aprvDelete", params);
	}
	
	/**
	 * 결재라인 등록
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int aprvLineInsert(Map params) throws Exception {
		return (Integer)insert("aprvMng.aprvLineInsert", params);
	}
	
	/**
	 * 결재라인 삭제
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int aprvLineDelete(Map params) throws Exception {
		return (Integer)delete("aprvMng.aprvLineDelete", params);
	}
	
	/**
	 * 결재라인 목록정보
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List aprvLineList(Map params) throws Exception {
		return getList("aprvMng.aprvLineList", params);
	}
	
	/**
	 * 결재 승인(완료, 보류, 반려)
	 * @param params
	 * @throws Exception
	 */
	public void aprvLineUpdate(Map params) throws Exception {
		update("aprvMng.aprvLineUpdate", params);
	}
	
	/**
	 * 결재라인 대기로 변경(반려, 보류에 대한 정보)
	 * @param params
	 * @throws Exception
	 */
	public void aprvLineUpdateYncd(Map params) throws Exception {
		update("aprvMng.aprvLineUpdateYncd", params);
	}
	
	/**
	 * 결재 첨부파일 등록
	 * @param params
	 * @throws Exception
	 */
	public void aprvFileInsert(Map params) throws Exception {
		insert("aprvMng.aprvFileInsert", params);
	}
	
	/**
	 * 결재 삭제시 해당 파일정보 삭제
	 * @param params
	 * @throws Exception
	 */
	public void aprvFileDelete(Map params) throws Exception {
		delete("aprvMng.aprvFileDelete", params);
	}
	
	/**
	 * 단일 파일 삭제
	 * @param params
	 * @throws Exception
	 */
	public void aprvFileOneDelete(Map params) throws Exception {
		delete("aprvMng.aprvFileOneDelete", params);
	}
	
	/**
	 * 결재파일 목록 정보 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List aprvFileList(Map params) throws Exception {
		return getList("aprvMng.aprvFileList", params);
	}
	
	/**
	 * 결제중, 반려, 보류인 정보 조회(aprv_yn_cd = 0:결재중, 3:반려, 2:보류 )
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List layerAprvInfo(Map params) throws Exception {
		return getList("aprvMng.layerAprvInfo", params);
	}

	/**
	 * 결제중, 반려, 보류인 정보 건수조회(aprv_yn_cd = 0:결재중, 3:반려, 2:보류 )
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int layerAprvInfoCount(Map params) throws Exception {
		return (Integer)getObject("aprvMng.layerAprvInfoCount", params);
	}
	
	/**
	 * 결재자가 결재할 정보를 확인한 경우
	 * @param params
	 * @throws Exception
	 */
	public void updateConfYn(Map params) throws Exception {
		update("aprvMng.updateConfYn", params);
	}
	
	/**
	 * 반려시 이전 결재자들의 데이터 반려로 변경
	 * @param params
	 * @throws Exception
	 */
	public void updateCompanion(Map params) throws Exception {
		update("aprvMng.updateCompanion", params);
	}

	/**
	* BIZPLAY에서 받아온 데이터를 저장
	* 작성자 : JO MIN SOO
	* @param params
	* @return
	* @throws Exception
	*/
	public int insertBizplayData(Map params) throws Exception {
		return (Integer)insert("aprvMng.insertBizplayData", params);
	}

	/**
	* BIZPLAY에서 결재완료된 건의 영수증 첨부파일을 추가
	* 작성자 : JO MIN SOO
	* @param params
	* @return
	* @throws Exception
	*/
	public int insertBizplayFile(Map params) {
		return (Integer)insert("aprvMng.insertBizplayFile", params);
	}
	
	/**
	* BIZPLAY에서 결재완료된 건의 영수증 첨부파일을 제거
	* 작성자 : JO MIN SOO
	* @param params
	* @return
	* @throws Exception
	*/
	public int deleteBizplayFile(Map params) {
		return (Integer)insert("aprvMng.deleteBizplayFile", params);
	}
	
	/**
	* BIZPLAY에서 결재완료된 건의 결재정보를 인트라넷에 추가
	* 작성자 : JO MIN SOO
	* @param params
	* @return
	* @throws Exception
	*/
	public int insertBizplayAprv(Map params) {
		return (Integer)insert("aprvMng.insertBizplayAprv", params);
		
	}
	
	/**
	* BIZPLAY에서 결재완료된 건의 결재라인을 추가
	* 작성자 : JO MIN SOO
	* @param params
	* @return
	* @throws Exception
	*/
	public int insertBizplayAprvLine(Map params) throws Exception {
		return (Integer)insert("aprvMng.insertBizplayAprvLine", params);
	}
	
	/**
	* BIZPLAY에서 결재완료된 건의 결재라인을 제거
	* 작성자 : JO MIN SOO
	* @param params
	* @return
	* @throws Exception
	*/
	public int deleteBizplayAprvLine(Map params) throws Exception {
		return (Integer)insert("aprvMng.deleteBizplayAprvLine", params);
	}

	/**
	* BIZPLAY에서 받아온 영수증을 반환
	* 작성자 : JO MIN SOO
	* @param params
	* @return
	* @throws Exception
	*/
	public List getBizplayData(Map params) throws Exception {
		return (List)getList("aprvMng.getBizplayData", params);
	}
	
	/**
	* BIZPLAY에서 받아온 영수증의 첨부파일을 반환
	* 작성자 : JO MIN SOO
	* @param params
	* @return
	* @throws Exception
	*/
	public List getBizplayFile(Map params) throws Exception {
		return (List)getList("aprvMng.getBizplayFile", params);
	}
}
