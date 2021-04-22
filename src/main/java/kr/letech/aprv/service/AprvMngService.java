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
	public void updateConfYn(Map params) throws Exception;
	
	/**
	* 로그인한 사용자의 결재라인을 반환
	* 작성자 : JO MIN SOO
	* @param params
	* @return
	* @throws Exception
	*/
	public List aprvLineInfoList(Map params) throws Exception;
	
	/**
	* BIZPLAY API를 호출하여 받아온 데이터를 적재하고 결재완료된 건을 인트라넷에 추가
	* 작성자 : JO MIN SOO
	* @param params
	* @return
	* @throws Exception
	*/
	public void insertBizplayData(Map params) throws Exception;

	/**
	* 데이터베이스에 적재된 비즈플레이 영수증들을 조합하여 인트라넷에 결재 데이터 추가
	* 작성자 : JO MIN SOO
	* @param params
	* @return
	* @throws Exception
	*/
	public void insertBizplayAprv(Map params) throws Exception; 
	
	/**
	* BIZPLAY에서 받아온 영수증과 첨부파일이미지를 반환
	* 작성자 : JO MIN SOO
	* @param params
	* @return
	* @throws Exception
	*/
	public Map getAprvRecList(Map params) throws Exception;

	/**
	* 지역별 출장비 리스트 반환
	* 작성자 : JO MIN SOO
	* @return
	* @throws Exception
	*/
	public List getTrcsList() throws Exception;

	/**
	* 유저의 여비 정보를 반환
	* 작성자 : JO MIN SOO
	* @param params
	* @return
	* @throws Exception
	*/
	public List getTrvctInfo(Map params) throws Exception;

}
