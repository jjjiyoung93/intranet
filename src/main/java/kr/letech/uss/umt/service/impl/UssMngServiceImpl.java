package kr.letech.uss.umt.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.letech.cal.service.impl.CalMngDAO;
import kr.letech.cmm.util.EgovDateUtil;
import kr.letech.cmm.util.EgovFileScrty;
import kr.letech.cmm.util.ObjToConvert;
import kr.letech.cmm.util.PageNavigator;
import kr.letech.cmm.util.ReqUtils;
import kr.letech.sys.rol.service.impl.RoleMngDAO;
import kr.letech.uss.umt.service.UssMngService;

@Service("ussMngService")
public class UssMngServiceImpl implements UssMngService {

	/** ussMngDAO */
	@Resource(name="ussMngDAO")
	private UssMngDAO ussMngDAO;
	
	/** 권한 */
	@Resource(name="roleMngDAO")
	private RoleMngDAO roleMngDAO;
	
	/** 캘린더  */
	@Resource(name = "calMngDAO")
	private CalMngDAO calMngDAO;
	
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
		
		/*검색조건 추가 - 2022.01.04 :BEGIN*/
		String searchGubun2 = ReqUtils.getEmptyResult2((String)params.get("searchGubun2"), "");
		String searchGubun3 = ReqUtils.getEmptyResult2((String)params.get("searchGubun3"), "");
		String searchGubun4 = ReqUtils.getEmptyResult2((String)params.get("searchGubun4"), "");
		String searchGubun5 = ReqUtils.getEmptyResult2((String)params.get("searchGubun5"), "");
		String searchGubun6 = ReqUtils.getEmptyResult2((String)params.get("searchGubun6"), "");
		/*검색조건 추가 - 2022.01.04 :END*/
		
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
		
		/*2022.01.19 생일을 캘린더에 등록 후 캘린더 번호 사원 테이블에 저장 : BEGIN*/
		Date today = new Date();
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		
		String todayStr = formatter.format(today);
		
		String year = todayStr.substring(0, 4);
				
		Map calMap = new HashMap();
		String ussNm = (String)params.get("uss_nm");
		calMap.put("cal_nm", ussNm + " 생일");
		calMap.put("cal_content_", year + " 년도 " + ussNm + " 생일");
		/*날짜 만들기(음력 시 양력 변화 필요) : BEGIN*/
		String birtdayType = (String)params.get("uss_birth_day_type");
		String birthdayMon = (String)params.get("uss_birth_day_mon");
		String birthdayDate = (String)params.get("uss_birth_day_date");
		String birthday = "";
		//양력일 경우
		if(StringUtils.equals(birtdayType, "S")) {
			birthday = year+"-"+birthdayMon+"-"+birthdayDate;
		}else if(StringUtils.equals(birtdayType, "L")) {
			//음력일 경우
			birthday = year+"-"+birthdayMon+"-"+birthdayDate;
			String birthdayConv = EgovDateUtil.toSolar(birthday, 0);
			String birthYear = birthdayConv.substring(0, 4);
			String birthMon = birthdayConv.substring(4, 6);
			String birthDate = birthdayConv.substring(6);
			
			birthday = birthYear + "-" + birthMon + "-" + birthDate;
		}
		calMap.put("cal_st_dt", birthday);
		calMap.put("cal_ed_dt", birthday);
		/*날짜 만들기(음력 시 양력 변화 필요) : END*/
		calMap.put("uss_id", (String)params.get("uss_id"));
		calMap.put("aprv_yn", "N");
		
		//캘린더 정보 추가
		int calSeq = calMngDAO.calInsert(calMap);
		
		params.put("bir_cal_seq", calSeq);
		
		//추가한 캘린더 시퀀스 번호 사용자 정보 등록
		ussMngDAO.ussUpdate(params);
		
		/*2022.01.19 생일을 캘린더에 등록 후 캘린더 번호 사원 테이블에 저장 : END*/
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
		
		Map orginUssView = null;
		
		if(params.get("uss_pwd") == null || params.get("uss_pwd").equals("")){
			orginUssView = ussMngDAO.getUssView(params);
		}else{
			// 비밀번호 수정할 경우 (비밀번호가 null값이 아닐경우)
			String uss_pwd = (String) params.get("uss_pwd");
			params.remove("uss_pwd");
			orginUssView = ussMngDAO.getUssView(params);
			String uss_id = (String) params.get("uss_id");
			String enpassword = EgovFileScrty.encryptPassword(uss_pwd, uss_id);
			params.put("uss_pwd", enpassword);
		}
		/*2022.01.19 사용자 생일 정보 수정 시 기존 자료 와 비교 후 다르면 캘린더 새로 추가 : BEGIN*/
		String orginBirthType = (String)orginUssView.get("USS_BIRTH_DAY_TYPE");
		String orginBirthday = (String)orginUssView.get("USS_BIRTH_DAY");
		
		String updBirthType = (String)params.get("uss_birth_day_type");
		String updBirthday = (String)params.get("uss_birth_day");
		
		if(!StringUtils.equals(updBirthType, orginBirthType) || !StringUtils.equals(updBirthday, orginBirthday)) {
			params.put("cal_seq", Integer.valueOf((String)orginUssView.get("BIR_CAL_SEQ")));
			
			calMngDAO.calDelete(params);
			
			
			/*2022.01.19 생일을 캘린더에 등록 후 캘린더 번호 사원 테이블에 저장 : BEGIN*/
			Date today = new Date();
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			
			String todayStr = formatter.format(today);
			
			String year = todayStr.substring(0, 4);
					
			Map calMap = new HashMap();
			String ussNm = (String)params.get("uss_nm");
			calMap.put("cal_nm", ussNm + " 생일");
			calMap.put("cal_content_", year + " 년도 " + ussNm + " 생일");
			/*날짜 만들기(음력 시 양력 변화 필요) : BEGIN*/
			String birtdayType = (String)params.get("uss_birth_day_type");
			String birthdayMon = (String)params.get("uss_birth_day_mon");
			String birthdayDate = (String)params.get("uss_birth_day_date");
			String birthday = "";
			//양력일 경우
			if(StringUtils.equals(birtdayType, "S")) {
				birthday = year+"-"+birthdayMon+"-"+birthdayDate;
			}else if(StringUtils.equals(birtdayType, "L")) {
				//음력일 경우
				birthday = year+"-"+birthdayMon+"-"+birthdayDate;
				String birthdayConv = EgovDateUtil.toSolar(birthday, 0);
				String birthYear = birthdayConv.substring(0, 4);
				String birthMon = birthdayConv.substring(4, 6);
				String birthDate = birthdayConv.substring(6);
				
				birthday = birthYear + "-" + birthMon + "-" + birthDate;
			}
			calMap.put("cal_st_dt", birthday);
			calMap.put("cal_ed_dt", birthday);
			/*날짜 만들기(음력 시 양력 변화 필요) : END*/
			calMap.put("uss_id", (String)params.get("uss_id"));
			calMap.put("aprv_yn", "N");
			
			//캘린더 정보 추가
			int calSeq = calMngDAO.calInsert(calMap);
			
			params.put("bir_cal_seq", calSeq);
			/*2022.01.19 생일을 캘린더에 등록 후 캘린더 번호 사원 테이블에 저장 : END*/
		}
		/*2022.01.19 사용자 생일 정보 수정 시 기존 자료 와 비교 후 다르면 캘린더 새로 추가 : END*/
		
		
		
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
		
		params.put("cal_seq", Integer.valueOf((String)params.get("bir_cal_seq")));
		
		calMngDAO.calDelete(params);
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

	/**
	* 결재라인 삭제 및 생성
	* @Method : insertAprvLine
	* @Author : JO MIN SOO
	* @Date : 2021. 1. 26.
	* @param params
	* @return
	* @throws Exception
	*/
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	@Override
	public void insertAprvLine(Map params) throws Exception {
		ussMngDAO.deleteAprvLine(params); // 사용자에 등록된 결재라인 모두 삭제
		
		List<HashMap<String, Object>> aprvLineList = new ArrayList<HashMap<String, Object>>(); // 결재라인 결재자 리스트 
		List<HashMap<String, Object>> aprvLineRefeList = new ArrayList<HashMap<String, Object>>(); // 결재라인 참조자 리스트
		
		for (Object key : params.keySet()) { // 파라미터로 넘어온 데이터 조회
			String strKey = String.valueOf(key);
			String strValue = String.valueOf(params.get(key));
			if(strKey.contains("aprv_ordr_")) { // aprv_ordr_***로 seq 정보가 저장됨
				HashMap<String, Object> map = new HashMap<String, Object>(); // 결재라인 결재자 리스트, 결재라인 참조자 리스트에 저장하기 위한 맵
				
				// 결재라인정보에 필요한 데이터 저장
				map.put("emp_no", params.get("uss_id"));
				map.put("aprv_emp_no", params.get("aprv_emp_no_" + strValue));
				map.put("aprv_ordr", params.get("aprv_ordr_" + strValue));
				
				String refeYn = String.valueOf(params.get("refe_yn_" + strValue));
				if("Y".equals(refeYn)) { // 참조자인경우
					map.put("refe_yn", "Y");
					aprvLineRefeList.add(map);
				} else { // 참조자 아닌경우
					map.put("refe_yn", "N");
					aprvLineList.add(map);
				}
			}
		}
		
		// 리스트를 aprv_ordr(순번)순으로 정렬
		Collections.sort(aprvLineList, new Comparator<HashMap<String, Object>>() {
			@Override
			public int compare(HashMap<String, Object> o1, HashMap<String, Object> o2) {
				String ordr1 = String.valueOf(o1.get("aprv_ordr"));
				String ordr2 = String.valueOf(o2.get("aprv_ordr"));
				return ordr1.compareTo(ordr2);
			}
		});
		Collections.sort(aprvLineRefeList, new Comparator<HashMap<String, Object>>() {
			@Override
			public int compare(HashMap<String, Object> o1, HashMap<String, Object> o2) {
				String ordr1 = String.valueOf(o1.get("aprv_ordr"));
				String ordr2 = String.valueOf(o2.get("aprv_ordr"));
				return ordr1.compareTo(ordr2);
			}
		});
		
		int count = 1; // 순번 새로 매기기(참조자가 중간에 껴있는 것을 없애기 위해)
		 // 결재라인 정보 등록
		for(int i = 0; i < aprvLineList.size(); i++) {
			HashMap<String, Object> map = aprvLineList.get(i);
			map.put("aprv_ordr", count++);
				ussMngDAO.insertAprvLine(map);
		}
		for(int i = 0; i < aprvLineRefeList.size(); i++) {
			HashMap<String, Object> map = aprvLineRefeList.get(i);
			map.put("aprv_ordr", count++);
			ussMngDAO.insertAprvLine(map);
		}
	}
}
