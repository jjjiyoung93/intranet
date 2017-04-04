package kr.letech.sys.bbs.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.letech.sys.bbs.service.BbsMngService;
import kr.letech.sys.rol.service.impl.RoleMngDAO;

@Service("bbsMngService")
public class BbsMngServiceImpl implements BbsMngService {

	@Resource(name="bbsMngDAO")
	private BbsMngDAO bbsMngDAO;
	
	@Override
	public List get00List(Map params) throws Exception {
		return bbsMngDAO.get00List(params);
	}

	@Override
	public void insertBbs(Map params) throws Exception {
		bbsMngDAO.insertBbs(params);
	}

	@Override
	public void updateBbs(Map params) throws Exception {
		bbsMngDAO.updateBbs(params);		
	}

	@Override
	public void deleteBbs(Map params) throws Exception {
		bbsMngDAO.deleteBbs(params);		
	}

	@Override
	public Map getView(Map params) throws Exception {
		return bbsMngDAO.getView(params);
	}

}
