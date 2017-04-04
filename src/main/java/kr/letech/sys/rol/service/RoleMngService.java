package kr.letech.sys.rol.service;

import java.util.List;
import java.util.Map;

public interface RoleMngService {

	/**
	 * 리스트 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	List get00List(Map params)throws Exception;

	/**
	 * 상세보기
	 * @param params
	 * @return
	 * @throws Exception
	 */
	Map getView(Map params)throws Exception;

	/**
	 * 입력
	 * @param params
	 * @throws Exception
	 */
	void insert(Map params)throws Exception;

	/**
	 * 수정
	 * @param params
	 * @throws Exception
	 */
	void updateNm(Map params)throws Exception;

	/**
	 * 삭제
	 * @param params
	 * @throws Exception
	 */
	void delete(Map params)throws Exception;

	/**
	 * @param params
	 * @return
	 * @throws Exception
	 */
	List get01List(Map params)throws Exception;

	/**
	 * @param params
	 * @return
	 * @throws Exception
	 */
	List get02List(Map params)throws Exception;

	/**
	 * 하위롤 포함 전체 삭제
	 * @param params
	 * @throws Exception
	 */
	void deleteAll(Map params)throws Exception;

	/**
	 * 권한 정보 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	List getAuthList(Map params)throws Exception;

	/**
	 * 롤 매핑 추가
	 * @param params
	 * @throws Exception
	 */
	void roleRelateInsert(Map params)throws Exception;

	/**
	 * 권한 정보 추가
	 * @param params
	 * @throws Exception
	 */
	void authInfoInsert(Map params)throws Exception;

	/**
	 * 권한 계층 정보 등록
	 * @param params
	 * @throws Exception
	 */
	void authRoleHicInsert(Map params)throws Exception;

	/**
	 * 권한 상세보기
	 * @param params
	 * @return
	 * @throws Exception
	 */
	Map getAuthInfo(Map params)throws Exception;

	/**
	 * 권한 정보 수정
	 * @param params
	 * @throws Exception
	 */
	void updateAuthInfo(Map params)throws Exception;

	/**
	 * 권한 정보 삭제
	 * @param params
	 * @throws Exception
	 */
	void deleteAuthorInfo(Map params)throws Exception;

	/**
	 * 롤 계층 정보 삭제
	 * @param params
	 * @throws Exception
	 */
	void deleteRoleHic(Map params)throws Exception;

	/**
	 *  메뉴권한 관리에 사용자권한 목록
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List roleMenuUserList(Map params) throws Exception;
}
