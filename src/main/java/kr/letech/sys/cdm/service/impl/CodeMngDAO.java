package kr.letech.sys.cdm.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.letech.cmm.service.impl.AbstractDAO;

@Repository("codeMngDAO")
public class CodeMngDAO extends AbstractDAO {

	public List getCodeList(Map params)throws Exception {
		return getList("codeMng.getCodeList",params);
	}

	public List getOneCodeList(Map params)throws Exception {
		return getList("codeMng.getOneCodeList",params);
	}

	public Map getCodeView(Map params) throws Exception{
		return (Map)getObject("codeMng.getCodeView", params);
	}

	public void insert(Map params) {
		insert("codeMng.insert", params);
	}

	public void insertLow(Map params) {
		insert("codeMng.insertLow", params);
	}

	public Map getMaxOrdr(Map params) throws Exception{
		return (Map)getObject("codeMng.getMaxOrdr", params);
	}

	public void updateNm(Map params) throws Exception{
		update("codeMng.updateNm", params);
	}

	public void delete(Map params) throws Exception{
		delete("codeMng.delete", params);
	}

	public void deleteAll(Map params) throws Exception{
		delete("codeMng.deleteAll", params);
	}
	
	public Map getCodeCnt(Map params) throws Exception{
		return (Map)getObject("codeMng.getCodeCnt", params);
	}

	public List getAllCodeList(Map params) throws Exception{
		return getList("codeMng.getAllCodeList", params);
	}


}
