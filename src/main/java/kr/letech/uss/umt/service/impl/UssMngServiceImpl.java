package kr.letech.uss.umt.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.letech.cmm.util.EgovFileScrty;
import kr.letech.cmm.util.ObjToConvert;
import kr.letech.cmm.util.PageNavigator;
import kr.letech.cmm.util.ReqUtils;
import kr.letech.sys.rol.service.impl.RoleMngDAO;
import kr.letech.uss.umt.service.UssMngService;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("ussMngService")
public class UssMngServiceImpl implements UssMngService {

	/** ussMngDAO */
	@Resource(name="ussMngDAO")
	private UssMngDAO ussMngDAO;
	
	/** 권한 */
	@Resource(name="roleMngDAO")
	private RoleMngDAO roleMngDAO;
	
	/**
	 * 페이지 처리, 목록정보 가져오기
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public Map getUssPageingList(Map params) throws Exception {
		
		String cPage = ReqUtils.getEmptyResult2((String)params.get("cPage"), "1");
		String listCnt = ReqUtils.getEmptyResult2((String)params.get("listCnt"), "10");
		String searchGubun = ReqUtils.getEmptyResult2((String)params.get("searchGubun"), "");	
		String searchField = ReqUtils.getEmptyResult2((String)params.get("searchField"), "");
		
		
		int intPage = Integer.parseInt(cPage);			/* 현재페이지 */
		int intListCnt = Integer.parseInt(listCnt);		/* 세로페이징(게시글수)*/
		int pageCnt = 10;								/* 가로페이징(페이지수) */
		int totalCnt = 0;								/* 총 건수  */
		
		totalCnt = ussMngDAO.getUssTotCount(params);
		
		int offSet = intListCnt * (ObjToConvert.strToint(cPage)-1);
		int limit = intListCnt; //ObjToConvert.strToint(cPage)*intListCnt;
		
		// 페이지 네비게이터 생성
		PageNavigator pageNavigator = new PageNavigator(
				intPage		
			   ,""
			   ,pageCnt		
			   ,intListCnt	
			   ,totalCnt	
			   ,""); // 검색 파라미터
		
		
		List list = ussMngDAO.getUssPageList(params, offSet, limit);
		
		Map objectMap = new HashMap();
		
		objectMap.put("resultList", list);
		objectMap.put("cPage", cPage);
		objectMap.put("intListCnt", intListCnt);
		objectMap.put("totalCnt", totalCnt);
		objectMap.put("pageNavigator", pageNavigator.getMakePageScript());
		
		return objectMap;
	}
	
	/**
	 * 리스트 목록정보
	 */
	@Override
	public List getUssList(Map params) throws Exception {
		return ussMngDAO.getUssList(params);
	}
	
	/**
	 * 총건수
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public int getUssTotCount(Map params) throws Exception {
		return ussMngDAO.getUssTotCount(params);
	}
	
	/**
	 * ID 중복체크
	 */
	@Override
	public String checkRepetition(Map params) throws Exception {
		int cnt = ussMngDAO.checkRepetition(params);
		String id_check = "";
		if(cnt == 0){
			id_check = "Y";
		}else{
			id_check = "N";
		}
		return id_check;
	}
	
	/**
	 * 사원번호 중복체크
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public String emNoCheckRepetition(Map params) throws Exception{
		int cnt = ussMngDAO.emNoCheckRepetition(params);
		String emno_check = "";
		if(cnt == 0){
			emno_check = "Y";
		}else{
			emno_check = "N";
		}
		return emno_check;
	}
	
	/**
	 * 사용자 등록
	 * @param params
	 * @throws Exception
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public void ussInsert(Map params) throws Exception {
		// 비밀번호 암호화
		String uss_pwd = (String) params.get("uss_pwd");
		String uss_id = (String) params.get("uss_id");
		String enpassword = EgovFileScrty.encryptPassword(uss_pwd, uss_id);
		params.put("uss_pwd", enpassword);
		
		// 사용자 등록
		ussMngDAO.ussInsert(params);
		
		if(params.get("uss_auth_cd") == null || params.get("uss_auth_cd").equals("")){
		}else{
			// 권한 정보가 있을경우
			params.put("scrty_dtrmn_trget_id", params.get("uss_id"));			// 사용자 ID
			params.put("author_code", params.get("uss_auth_cd"));		// 권한 코드
			params.put("mber_ty_code", "USR01");					// 부서정보
			// 사용자 권한매핑정보에 등록
			roleMngDAO.roleMapInsertAndUpdate(params);		// merge사용 기존 정보가 없을경우 등록, 없을경우 수정
			//roleMngDAO.roleMapInsert(params);				// 등록
		}
	}
	
	/**
	 * 사용자 상세조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public Map getUssView(Map params) throws Exception {
		Map viewMp = ussMngDAO.getUssView(params);
		
		/* 전화번호 나누기 (수정화면일 경우) */
		String uss_tel = viewMp.get("USS_TEL")==null?"":(String)viewMp.get("USS_TEL");
		String[] telArr = uss_tel.split("-");
		
		if(telArr == null || telArr.length <= 1){
		}else{
			viewMp.put("USS_TEL1", telArr[0]);
			viewMp.put("USS_TEL2", telArr[1]);
			viewMp.put("USS_TEL3", telArr[2]);
		}
		
		return viewMp;
	}
	
	/**
	 * 사용자 수정
	 * @param params
	 * @throws Exception
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public void ussUpdate(Map params) throws Exception {
		if(params.get("uss_pwd") == null || params.get("uss_pwd").equals("")){
		}else{
			// 비밀번호 수정할 경우 (비밀번호가 null값이 아닐경우)
			String uss_pwd = (String) params.get("uss_pwd");
			String uss_id = (String) params.get("uss_id");
			String enpassword = EgovFileScrty.encryptPassword(uss_pwd, uss_id);
			params.put("uss_pwd", enpassword);
		}
		// 사용자 수정
		ussMngDAO.ussUpdate(params);
		
		if(params.get("uss_auth_cd") == null || params.get("uss_auth_cd").equals("")){
			// 권한 정보가 없을경우, 삭제
			params.put("scrty_dtrmn_trget_id", params.get("uss_id"));			// 사용자 ID
			// 사용자 권한매핑 정보 삭제
			roleMngDAO.roleMapDelete(params);
		}else{
			// 권한 정보가 있을경우, 수정 및 등록
			params.put("scrty_dtrmn_trget_id", params.get("uss_id"));			// 사용자 ID
			params.put("author_code", params.get("uss_auth_cd"));		// 권한 코드
			params.put("mber_ty_code", "USR01");					// 부서정보
			// 사용자 권한매핑정보에 등록
			roleMngDAO.roleMapInsertAndUpdate(params);		// merge사용 기존 정보가 없을경우 등록, 없을경우 수정
			
			/* 위 쿼리에서 merge로 처리함. 자바로 처리 할겨웅 사용 
			 * update후 값이 0이면 삽입 , 아니면 삽입하지 않음 (update시 0값일경우에는 기존 정보가 없을때)
			int cnt = roleMngDAO.roleMapUpdate(params);
			if(cnt > 0){
			}else{
				// 업데이트 데이더가 없을경우 등록.
				roleMngDAO.roleMapInsert(params);
			}
			*/
		}
	}
	
	/**
	 * 사용자 삭제
	 * @param params
	 * @throws Exception
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public void ussDelete(Map params) throws Exception {
		// 사용자 삭제
		ussMngDAO.ussDelete(params);

		params.put("scrty_dtrmn_trget_id", params.get("uss_id"));			// 사용자 ID
		// 사용자 권한매핑 정보 삭제
		roleMngDAO.roleMapDelete(params);
	}
	

	/**
	 * 팝업검색 페이지 처리, 목록정보 가져오기
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public Map getUssPageingListPopup(Map params) throws Exception {
		
		String cPage = ReqUtils.getEmptyResult2((String)params.get("cPage"), "1");
		String listCnt = ReqUtils.getEmptyResult2((String)params.get("listCnt"), "10");
		String searchGubun = ReqUtils.getEmptyResult2((String)params.get("searchGubun"), "");	
		String searchField = ReqUtils.getEmptyResult2((String)params.get("searchField"), "");
		
		
		int intPage = Integer.parseInt(cPage);			/* 현재페이지 */
		int intListCnt = Integer.parseInt(listCnt);		/* 세로페이징(게시글수)*/
		int pageCnt = 10;								/* 가로페이징(페이지수) */
		int totalCnt = 0;								/* 총 건수  */
		
		totalCnt = ussMngDAO.getUssTotCountPopup(params);
		
		int offSet = intListCnt * (ObjToConvert.strToint(cPage)-1);
		int limit = intListCnt; //ObjToConvert.strToint(cPage)\*intListCnt;
		
		// 페이지 네비게이터 생성
		PageNavigator pageNavigator = new PageNavigator(
				intPage		
			   ,""
			   ,pageCnt		
			   ,intListCnt	
			   ,totalCnt	
			   ,""); // 검색 파라미터
		
		
		List list = ussMngDAO.getUssPageListPopup(params, offSet, limit);
		
		Map objectMap = new HashMap();
		
		objectMap.put("resultList", list);
		objectMap.put("cPage", cPage);
		objectMap.put("intListCnt", intListCnt);
		objectMap.put("totalCnt", totalCnt);
		objectMap.put("pageNavigator", pageNavigator.getMakePageScript());
		
		return objectMap;
	}

	/* (non-Javadoc)
	 * @see kr.letech.uss.umt.service.UssMngService#getUssDepartList(java.util.Map)
	 */
	@Override
	public List getUssDepartList(Map params) throws Exception {
		return ussMngDAO.getUssDepartList(params);
	}

}
