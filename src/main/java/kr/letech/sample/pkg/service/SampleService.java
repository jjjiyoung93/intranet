package kr.letech.sample.pkg.service;

import java.util.List;
import java.util.Map;

/**
 * 전자정부프레임워크의 기본형태를 
 * 참고한 샘플 인터페이스
 * @author jwchoi
 *
 */
public interface SampleService {

	/**
	 * 등록
	 * @param params
	 * @throws Exception
	 */
	void insert(Map params)throws Exception;

	/**
	 * 리스트 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	List getlsit(Map params)throws Exception;

	void insert2(Map params);

}
