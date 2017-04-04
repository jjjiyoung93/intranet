package kr.letech.sys.cdm.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.letech.sample.pkg.service.impl.SampleDAO;
import kr.letech.sys.cdm.service.CodeMngService;

@Service("codeMngService")
public class CodeMngServiceImpl implements CodeMngService {
	
	@Resource(name="codeMngDAO")
	private CodeMngDAO codeMngDAO;
	
	@Override
	public List getOneCodeList(Map params) throws Exception {
		return codeMngDAO.getOneCodeList(params);
	}

	@Override
	public List getCodeList(Map params) throws Exception {
		return codeMngDAO.getCodeList(params);
	}

	@Override
	public Map getCodeView(Map params) throws Exception {
		return codeMngDAO.getCodeView(params);
	}

	@Override
	public void insert(Map params) throws Exception {
		codeMngDAO.insert(params);
	}

	@Override
	public void insertLow(Map params) throws Exception {
		codeMngDAO.insertLow(params);
	}

	@Override
	public Map getMaxOrdr(Map params) throws Exception {
		return codeMngDAO.getMaxOrdr(params);
	}

	@Override
	public void updateNm(Map params) throws Exception {
		codeMngDAO.updateNm(params);
	}

	@Override
	public void delete(Map params) throws Exception {
		codeMngDAO.delete(params);
	}

	@Override
	public void deleteAll(Map params) throws Exception {
		codeMngDAO.deleteAll(params);
	}

}
