package kr.letech.sys.err.service;

import java.util.List;
import java.util.Map;

public interface ErrMngService {

	/**
	 * 발생에러 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	Map get00PageInfo(Map params)throws Exception;
	
	/**
	 * 발생에러 상세 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	Map get00ErrView(Map params)throws Exception;
	
	/**
	 * 조회시 신규건 작성중으로 변경
	 * @param params
	 * @return
	 * @throws Exception
	 */
	void updateProcessState(Map params)throws Exception;

	/**
	 * 완료처리
	 * @param params
	 * @return
	 * @throws Exception
	 */
	void updateCompletion(Map params)throws Exception;
	
	/**
	 * 저장처리
	 * @param params
	 * @return
	 * @throws Exception
	 */
	void updateSave(Map params)throws Exception;
	
	/**
	 * 처리이력 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	Map get01PageInfo(Map params)throws Exception;

	/**
	 * 처리이력 상세 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	Map get01ErrView(Map params)throws Exception;
	
}
