package kr.letech.sys.mnm.service;

import java.util.List;
import java.util.Map;

/**
 * @author jwchoi
 * @date 2015. 10. 11.
 */
public interface MenuMngService {

	/**
	 * 상위 메뉴 호출
	 * @param params
	 * @return
	 * @throws Exception
	 */
	List getOneCodeList(Map params)throws Exception;

	/**
	 * 하위메뉴 호출
	 * @param params
	 * @return
	 * @throws Exception
	 */
	List getCodeList(Map params)throws Exception;

	/**
	 * 메뉴 정보 상세보기
	 * @param params
	 * @return
	 * @throws Exception
	 */
	Map getCodeView(Map params)throws Exception;

	/**
	 * 하위메뉴 순서값을 정하기 위한 최대 순번 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	Map getMaxOrdr(Map params)throws Exception;

	/**
	 * 메뉴 등록
	 * @param params
	 * @throws Exception
	 */
	void insert(Map params)throws Exception;

	/**
	 * 메뉴 수정
	 * @param params
	 * @throws Exception
	 */
	void updateNm(Map params)throws Exception;

	/**
	 * 메뉴 삭제(단건)
	 * @param params
	 * @throws Exception
	 */
	void delete(Map params)throws Exception;

	/**
	 * 메뉴 삭제(하위 메뉴 포함)
	 * @param params
	 * @throws Exception
	 */
	void deleteAll(Map params)throws Exception;
	
	/**
	 * 메뉴 Tree 구조 리스트 정보
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List getMenuTreeList(Map params) throws Exception;
	

	/**
	 * 해당 메뉴의 하위 메뉴까지 삭제
	 * @param params
	 * @throws Exception
	 */
	public void mnAllDelete(Map params) throws Exception;
	
	/**
	 * 메뉴타이틀 및 네비게이션 정보 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map getTitleAndNaviInfo(Map params) throws Exception;

	/**
	 * 권한에 따른 메뉴 리스트 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	List getMnList(Map params)throws Exception;
}
