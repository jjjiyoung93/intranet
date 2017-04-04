package kr.letech.sys.rol.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.letech.cmm.service.impl.AbstractDAO;

@Repository("roleMngDAO")
public class RoleMngDAO extends AbstractDAO{

	/**
	 * 권한 정책(패턴) 조회
	 * @param params
	 * @return
	 * @throws Exception 
	 */
	public List get00List(Map params) throws Exception {
		return getList("roleMng.get00List",params);
	}

	/**
	 * 롤 계층 정보 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List get01List(Map params) throws Exception {
		return getList("roleMng.get01List",params);
	}

	public void insert(Map params) throws Exception {
		insert("roleMng.insert", params);
	}

	/**
	 * 롤정보 삭제
	 * @param params
	 * @return
	 */
	public int roleInfoDel(Map params)throws Exception {
		return delete("roleMng.roleInfoDel", params);
	}

	/**
	 * 롤 권한 매핑 정보 삭제 롤 연결된 정보만 삭제
	 * @param params(role_code)
	 * @throws Exception 
	 */
	public void roleRelateDel(Map params) throws Exception {
		delete("roleMng.roleRelateDel",params);
		
	}

	public List getAuthList(Map params) throws Exception {
		return getList("roleMng.getAuthList",params);
	}

	/**
	 * 롤 매핑 추가
	 * @param params
	 * @throws Exception
	 */
	public void roleRelateInsert(Map params) throws Exception {
		insert("roleMng.roleRelateInsert", params);
	}

	/**
	 * 롤 정책 보기
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map getView(Map params) throws Exception {
		return (Map)getObject("roleMng.getView", params);
	}

	/**
	 * 롤정보 변경
	 * @param params
	 * @throws Exception
	 */
	public void updateNm(Map params) throws Exception {
		update("roleMng.updateNm", params);
	}

	/**
	 * 매핑정보 삭제
	 * @param params
	 * @throws Exception
	 */
	public void relateDel(Map params) throws Exception {
		delete("roleMng.relateDel", params);
		
	}

	/**
	 * 권한 정보 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List get02List(Map params) throws Exception{
		return getList("roleMng.get02List",params);
	}

	/**
	 * 권한 정보 추가
	 * @param params
	 */
	public void authInfoInsert(Map params) throws Exception{
		insert("roleMng.authInfoInsert", params);
	}

	/**
	 * 권한 계층 정보 등록
	 * @param params
	 * @throws Exception
	 */
	public void authRoleHicInsert(Map params) throws Exception{
		insert("roleMng.authRoleHicInsert", params);
	}

	/**
	 * 권한 상세 보기
	 * @param params
	 * @return
	 */
	public Map getAuthInfo(Map params) throws Exception{
		return (Map)getObject("roleMng.getAuthInfo", params);
	}

	public void updateAuthInfo(Map params) throws Exception{
		update("roleMng.updateAuthInfo",params);
		
	}

	public void deleteAuthorInfo(Map params) throws Exception{
		delete("roleMng.deleteAuthorInfo", params);
	}

	public void deleteRoleHic(Map params) throws Exception{
		delete("roleMng.deleteRoleHic", params);
	}
	
	/**
	 * 사용자 권한매핑 정보 등록
	 * @param params
	 * @throws Exception
	 */
	public void roleMapInsert(Map params) throws Exception {
		insert("roleMng.roleMapInsert", params);
	}
	
	/**
	 * 사용자 권한매핑 정보 수정
	 * @param params
	 * @throws Exception
	 */
	public int roleMapUpdate(Map params) throws Exception {
		return update("roleMng.roleMapUpdate", params);
	}
	
	/**
	 * 사용자 권한매핑 정보 삭제
	 * @param params
	 * @throws Exception
	 */
	public void roleMapDelete(Map params) throws Exception {
		delete("roleMng.roleMapDelete", params);
	}
	
	/**
	 * 사용자 권한매핑 정보가 기존에 없을경우 등록, 있을경우 수정
	 * merge 사용
	 * @param params
	 * @throws Exception
	 */
	public void roleMapInsertAndUpdate(Map params) throws Exception {
		update("roleMng.roleMapInsertAndUpdate", params);
	}
	
	/**
	 *  메뉴권한 관리에 사용자권한 목록
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List roleMenuUserList(Map params) throws Exception {
		return getList("roleMng.roleMenuUserList", params);
	}

	/**
	 * 롤과 권한패턴 테이블에 대한 auth코드 조회
	 * @param rCode
	 * @return
	 * @throws Exception
	 */
	public List getAuthCodeList(String rCode) throws Exception {
		return getList("roleMng.getAuthCodeList", rCode);
	}
}
