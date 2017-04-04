package kr.letech.sys.rol.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.letech.sys.rol.service.RoleMngService;

@Service("roleMngService")
public class RoleMngServiceImpl implements RoleMngService {

	@Resource(name="roleMngDAO")
	private RoleMngDAO roleMngDAO;
	
	@Override
	public List get00List(Map params) throws Exception {
		return roleMngDAO.get00List(params);
	}

	@Override
	public Map getView(Map params) throws Exception {
		return roleMngDAO.getView(params);
	}

	@Override
	public void insert(Map params) throws Exception {
		roleMngDAO.insert(params);
	}

	@Override
	public void updateNm(Map params) throws Exception {
		roleMngDAO.updateNm(params);
		if(params.get("author_code")==null || params.get("author_code").equals("")){
		}else{
			roleMngDAO.roleRelateInsert(params);
		}
	}

	@Override
	public void delete(Map params) throws Exception {
		roleMngDAO.relateDel(params);

	}

	@Override
	public List get01List(Map params) throws Exception {
		return roleMngDAO.get01List(params);
	}

	@Override
	public List get02List(Map params) throws Exception {
		return roleMngDAO.get02List(params);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public void deleteAll(Map params) throws Exception {
		try {
			
			int delSuc = roleMngDAO.roleInfoDel(params);
			
			if(delSuc > 0){
				roleMngDAO.roleRelateDel(params);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
			
		}
	}

	@Override
	public List getAuthList(Map params) throws Exception {
		return roleMngDAO.getAuthList(params);
	}

	@Override
	public void roleRelateInsert(Map params) throws Exception {
		roleMngDAO.roleRelateInsert(params);
		
	}

	@Override
	public void authInfoInsert(Map params) throws Exception {
		roleMngDAO.authInfoInsert(params);
	}

	@Override
	public void authRoleHicInsert(Map params) throws Exception {
		roleMngDAO.authRoleHicInsert(params);
	}

	@Override
	public Map getAuthInfo(Map params) throws Exception {
		return roleMngDAO.getAuthInfo(params);
	}

	@Override
	public void updateAuthInfo(Map params) throws Exception {
		roleMngDAO.updateAuthInfo(params);
	}

	@Override
	public void deleteAuthorInfo(Map params) throws Exception {
		roleMngDAO.deleteAuthorInfo(params);
	}

	@Override
	public void deleteRoleHic(Map params) throws Exception {
		roleMngDAO.deleteRoleHic(params);
	}
	
	@Override
	public List roleMenuUserList(Map params) throws Exception {
		return roleMngDAO.roleMenuUserList(params);
	}

}
