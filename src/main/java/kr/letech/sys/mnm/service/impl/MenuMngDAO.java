package kr.letech.sys.mnm.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.letech.cmm.service.impl.AbstractDAO;

@Repository("menuMngDAO")
public class MenuMngDAO extends AbstractDAO {

	public List getCodeList(Map params)throws Exception {
		return getList("menuMng.getCodeList",params);
	}

	public List getOneCodeList(Map params)throws Exception {
		return getList("menuMng.getOneCodeList",params);
	}

	public Map getCodeView(Map params) throws Exception{
		return (Map)getObject("menuMng.getCodeView", params);
	}

	public void insert(Map params) {
		insert("menuMng.insert", params);
	}

	public Map getMaxOrdr(Map params) throws Exception{
		return (Map)getObject("menuMng.getMaxOrdr", params);
	}

	public void updateNm(Map params) throws Exception{
		update("menuMng.updateNm", params);
	}

	public void delete(Map params) throws Exception{
		delete("menuMng.delete", params);
	}

	public void deleteAll(Map params) throws Exception{
		delete("menuMng.deleteAll", params);
	}
	
	/**
	 * 메뉴 Tree 구조 리스트 정보
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List getMenuTreeList(Map params) throws Exception {
		return getList("menuMng.getMenuTreeList", params);
	}
	
	/**
	 * 해당 메뉴의 하위 메뉴까지 삭제
	 * @param params
	 * @throws Exception
	 */
	public void mnAllDelete(Map params) throws Exception {
		delete("menuMng.mnAllDelete", params);
	}
	
	/**
	 * 메뉴타이틀 및 네비게이션 정보 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map getTitleAndNaviInfo(Map params) throws Exception {
		return (Map)getObject("menuMng.getTitleAndNaviInfo", params);
	}

	/**
	 * 권한포함 메뉴리스트 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map> getMnList(Map params) throws Exception {
		return getList("menuMng.getMnList", params);
	}
}
