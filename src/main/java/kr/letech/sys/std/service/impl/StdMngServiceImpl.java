package kr.letech.sys.std.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.letech.sys.bbs.service.BbsMngService;
import kr.letech.sys.cdm.service.impl.CodeMngDAO;
import kr.letech.sys.rol.service.impl.RoleMngDAO;
import kr.letech.sys.std.TrvctVO;
import kr.letech.sys.std.service.StdMngService;

@Service("stdMngService")
public class StdMngServiceImpl implements StdMngService {

	@Resource(name="stdMngDAO")
	private StdMngDAO stdMngDAO;
	
	@Resource(name="codeMngDAO")
	private CodeMngDAO codeMngDAO;
	
	@Override
	public List get00List(Map params) throws Exception {
		return stdMngDAO.get00List(params);
	}

	@Override
	public void insertGrp(Map params) throws Exception {
		stdMngDAO.insertGrp(params);
	}

	@Override
	public void updateGrp(Map params) throws Exception {
		stdMngDAO.updateGrp(params);		
	}

	@Override
	public void deleteGrp(Map params) throws Exception {
		stdMngDAO.deleteGrp(params);		
	}

	@Override
	public Map getView(Map params) throws Exception {
		return stdMngDAO.getView(params);
	}

	@Override
	public List get01List(Map params) throws Exception {
		return stdMngDAO.get01List(params);
	}

	@Override
	public void insertAut(Map params) throws Exception {
		stdMngDAO.insertAut(params);
	}

	@Override
	public void updateAut(Map params) throws Exception {
		stdMngDAO.updateAut(params);
	}

	@Override
	public void deleteAut(Map params) throws Exception {
		stdMngDAO.deleteAut(params);
	}

	@Override
	public Map getView2(Map params) throws Exception {
		return stdMngDAO.getView2(params);
	}

	@Override
	public List get02List(Map params) throws Exception {
		return stdMngDAO.get02List(params);
	}

	@Override
	//트랜잭션 처리 필요
	public void insertTrcs(Map params) throws Exception {
		try {
			codeMngDAO.insertLow(params);
			
			List<TrvctVO> trcsList = null;
			trcsList = (List<TrvctVO>)params.get("trcsList");
			
			if(trcsList != null && !trcsList.isEmpty()) {
				for (TrvctVO trvctVO : trcsList) {
					trvctVO.setRegnCd1((String)params.get("cd"));
					params.put("trvctVO", trvctVO);
					stdMngDAO.insertTrcs(params);
					// 위치 역방향 자료 생성
					String temp = trvctVO.getRegnCd1();
					trvctVO.setRegnCd1(trvctVO.getRegnCd2());
					trvctVO.setRegnCd2(temp);
					params.put("trvctVO", trvctVO);
					stdMngDAO.insertTrcs(params);				
				}
			}
			
		}catch (Exception e) {
			codeMngDAO.getSqlSession().rollback();
			stdMngDAO.getSqlSession().rollback();
			throw new Exception();
		}
	}

	@Override
	public void updateTrcs(Map params) throws Exception {
		try {
			String cd = (String)params.get("cd");
			if(cd != null && !"".equals(cd)) {
				codeMngDAO.updateNm(params);			
			}
			
			List<TrvctVO> trcsList = null;
			trcsList = (List<TrvctVO>)params.get("trcsList");
			
			if(trcsList != null && !trcsList.isEmpty()) {
				for (TrvctVO trvctVO : trcsList) {
					params.put("trvctVO", trvctVO);
					stdMngDAO.updateTrcs(params);
					
					//위치 역방향 자료 수정
					String temp = trvctVO.getRegnCd1();
					trvctVO.setRegnCd1(trvctVO.getRegnCd2());
					trvctVO.setRegnCd2(temp);
					params.put("trvctVO", trvctVO);
					stdMngDAO.updateTrcs(params);		
				}
			}		
		}catch(Exception e) {
			codeMngDAO.getSqlSession().rollback();
			stdMngDAO.getSqlSession().rollback();
			throw new Exception();
		}
	}

	@Override
	public void deleteTrcs(Map params) throws Exception {
		try {
			stdMngDAO.deleteTrcs(params);
			String cd = (String)params.get("std_id");
			params.put("cd", cd);
			codeMngDAO.delete(params);			
		}catch(Exception e) {
			codeMngDAO.getSqlSession().rollback();
			stdMngDAO.getSqlSession().rollback();
			throw new Exception();
		}
	}

	@Override
	public Map getView3(Map params) throws Exception {
		return stdMngDAO.getView3(params);
	}

	@Override
	public List getAuthorList(Map params) throws Exception {
		return stdMngDAO.getAuthorList(params);
	}

	@Override
	public Map getCnt00(Map params) throws Exception {
		return stdMngDAO.getCnt00(params);
	}

	@Override
	public Map getCnt01(Map params) throws Exception {
		return stdMngDAO.getCnt01(params);
	}
	

}
