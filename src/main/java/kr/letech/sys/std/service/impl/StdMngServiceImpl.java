package kr.letech.sys.std.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

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
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public void insertGrp(Map params) throws Exception {
		try {
			stdMngDAO.insertGrpCd(params);
			
			Map grpCd = stdMngDAO.getGrpCdView(params);
			
			if(grpCd != null) {
				params.put("CD", (String)grpCd.get("CD"));
			}
			
			stdMngDAO.insertGrp(params);
		}catch (Exception e) {
			stdMngDAO.getSqlSession().rollback();
			throw new Exception();
		}
		
	}

	@Override
	public void updateGrp(Map params) throws Exception {
		stdMngDAO.updateGrp(params);		
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public void deleteGrp(Map params) throws Exception {
		
		try {
			
			stdMngDAO.deleteTrvctGrupAut(params);
			
			stdMngDAO.deleteGrp(params);		
			//stdMngDAO.deleteGrpCd(params);
		} catch (Exception e) {
			stdMngDAO.getSqlSession().rollback();
			throw new Exception();
		}
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
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public void insertAut(Map params) throws Exception {
		try {
			//STD_CD_MNG에 해당 직급이 있는지 확인
			//없으면 새로 등록 
			//있으면 넘어가
			Map authCd = stdMngDAO.getAutCdView(params);
			
			
			//STD_CD_MNG에 직급 데이터 MERGE(해당 직급 없을 때만 등록, 있을 떄는 아무 작업 없음) -> 키생성
			//NEW_CD : 새로 만들어진 키
			//OLD_CD : 기존 있던 키
			
			if(authCd != null) {
				params.put("OLD_CD", (String)authCd.get("CD"));
			}
			
			
			stdMngDAO.insertAutCd(params);
			
			//STD_AUT_INFO에 직급 데이터 MERGE(기존 자료 없으면 추가 생성, 있으면 연구직급 값만 없데이트) => 키생성
			stdMngDAO.insertAutInfo(params);
			
			//STD_AUT_INFO에 해당 직급이 있는지 확인
			//없으면 새로 등록
			//있으면 넘어가
			Map authInfo = stdMngDAO.getAuthInfoView(params);
			
			params.put("autCode", (String)authInfo.get("AUTHOR_CODE"));
			
			
			//받은키를 가지고 STD_CD_MNG CD_VAL 값 업데이트
			
			stdMngDAO.updateAutCd(params);
			
			
			
			//ROLE의 상속관계 데이터 추가
			
			//STD_AUT_ROLE_HIC에 값 데이터 삽입
			stdMngDAO.insertRoleHic(params);
			
			
			
			//STD_CD_MNG에 급수 데이터 MERGE(없을시만 추가, 있으면 아무 작업 없음) -> 키생성
			stdMngDAO.insertGrpCd(params);
			
			Map grpCd = stdMngDAO.getGrpCdView(params);
			
			if(grpCd != null) {
				params.put("CD", (String)grpCd.get("CD"));
			}
			
			//여비 기본값 0으로 TRVCT_GRUP MERGE -> 키생성
			params.put("trvct", 0);
			
			//TRVCT_GROUP에 여비 정보 데이터 MERGE(없으면)
			int insGrpCnt = 0; 
		    insGrpCnt = stdMngDAO.insertGrp(params);
			
		    if(insGrpCnt > 0) {
		    	params.put("insGrpYn", "Y");
		    }
			
			//그룹별 급수 삽입
			stdMngDAO.insertAut(params);
		} catch (Exception e) {
			stdMngDAO.getSqlSession().rollback();
			throw new Exception();
		}
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public void updateAut(Map params) throws Exception {
		try {
			stdMngDAO.updateAut(params);
			stdMngDAO.updateRsrChNm(params);			
		}catch (Exception e) {
			stdMngDAO.getSqlSession().rollback();
			throw new Exception();
		}
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
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public void insertTrcs(Map params) throws Exception {
		try {
			//codeMngDAO.insertLow(params);
			
			stdMngDAO.insertTrcsCd(params);
			
			Map trcsCd = stdMngDAO.selectTrcsCd(params);
			
			if(trcsCd != null) {
				params.put("cd", (String)trcsCd.get("CD"));
			}
			
			List<TrvctVO> trcsList = null;
			trcsList = (List<TrvctVO>)params.get("trcsList");
			
			if(trcsList != null && !trcsList.isEmpty()) {
				for (TrvctVO trvctVO : trcsList) {
					if(StringUtils.isNotEmpty((String)trvctVO.getRegnCd2())) {
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
			}
			
		}catch (Exception e) {
			//codeMngDAO.getSqlSession().rollback();
			stdMngDAO.getSqlSession().rollback();
			throw new Exception();
		}
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
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
					if(StringUtils.isNotEmpty((String)trvctVO.getRegnCd2())) {
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
			}
		}catch(Exception e) {
			codeMngDAO.getSqlSession().rollback();
			stdMngDAO.getSqlSession().rollback();
			throw new Exception();
		}
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public void deleteTrcs(Map params) throws Exception {
		try {
			stdMngDAO.deleteTrcs(params);
			String cd = (String)params.get("std_id");
			params.put("cd", cd);
			//codeMngDAO.delete(params);			
		}catch(Exception e) {
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

	@Override
	public List getAddList(Map params) throws Exception {
		return stdMngDAO.getAddList(params);
	}

	@Override
	public Map getRegnCnt(Map params) throws Exception {
		return stdMngDAO.getRegnCnt(params);
	}

	@Override
	public List getTrcsCdList(Map params) throws Exception {
		return stdMngDAO.getTrcsCdList(params);
	}
	

}
