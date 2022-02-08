package kr.letech.aprv.service.impl;

import java.net.URI;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.reflection.wrapper.MapWrapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.ibm.icu.util.ChineseCalendar;

import kr.letech.app.service.AppPushService;
import kr.letech.aprv.TmpPayItemVO;
import kr.letech.aprv.service.AprvMngService;
import kr.letech.cal.service.impl.CalMngDAO;
import kr.letech.cal.service.impl.HolidayMngDAO;
import kr.letech.cmm.util.EgovFileTool;
import kr.letech.cmm.util.ObjToConvert;
import kr.letech.cmm.util.PageNavigator;
import kr.letech.cmm.util.ReqUtils;
import kr.letech.cmm.util.VarConsts;
import kr.letech.doc.service.impl.DocDAO;
import kr.letech.sys.cdm.service.impl.CodeMngDAO;
import kr.letech.uss.umt.service.impl.UssMngDAO;
import kr.letech.vct.service.impl.VctMngDAO;
import net.sf.json.JSONArray;
import net.sf.json.JSONNull;
import net.sf.json.JSONObject;

@Service("aprvMngService")
public class AprvMngServiceImpl implements AprvMngService {

	/** aprvMngDAO */
	@Resource(name="aprvMngDAO")
	private AprvMngDAO aprvMngDAO;
	
	@Resource(name="appPushService")
	private AppPushService appPushService;
	
	/** calMngDAO */
	@Resource(name="calMngDAO")
	private CalMngDAO calMngDAO;
	
	/** codeMngDAO */
	@Resource(name="codeMngDAO")
	private CodeMngDAO codeMngDAO;
	
	/** docDAO */
	@Resource(name="docDAO")
	private DocDAO docDAO;
	
	
	/** ussMngDAO */
	@Resource(name="ussMngDAO")
	private UssMngDAO ussMngDAO;
	
	/** vctMngDAO */
	@Resource(name="vctMngDAO")
	private VctMngDAO vctMngDAO;
	
	/** holidayMngDAO */
	@Resource(name="holidayMngDAO")
	private HolidayMngDAO holidayMngDAO;
	
	
		
	
	/**
	 * 페이징 처리, 목록정보
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public Map getAprvPageingList(Map params) throws Exception {
		
		String cPage = ReqUtils.getEmptyResult2((String)params.get("cPage"), "1");
		String listCnt = ReqUtils.getEmptyResult2((String)params.get("listCnt"), "10");
		String searchGubun = ReqUtils.getEmptyResult2((String)params.get("searchGubun"), "");	
		String searchField = ReqUtils.getEmptyResult2((String)params.get("searchField"), "");

		String searchField2 = ReqUtils.getEmptyResult2((String)params.get("searchField2"), "");
		String searchField3 = ReqUtils.getEmptyResult2((String)params.get("searchField3"), "");
		String stDt = ReqUtils.getEmptyResult2((String)params.get("st_dt"), "");
		String edDt = ReqUtils.getEmptyResult2((String)params.get("ed_dt"), "");
		
		
		/*2022.01.12 검색 조건 추가 : BEGIN*/
		String yearStr = (String)params.get("stddYr");
		String idStr = (String)params.get("ussId");
		//유저아이디
		String ussId = ReqUtils.getEmptyResult2((String)params.get("uss_id"), idStr);
		//기준년도
		String stddYr = ReqUtils.getEmptyResult2((String)params.get("stddYr"), yearStr);
		//시작월
		String startMon = ReqUtils.getEmptyResult2((String)params.get("startMon"), "");
		//종료월
		String endMon = ReqUtils.getEmptyResult2((String)params.get("endMon"), "");
		//휴가구분
		String vctType = ReqUtils.getEmptyResult2((String)params.get("vctTypeCd"), "");
		//결재상태
		String arpvStat = ReqUtils.getEmptyResult2((String)params.get("aprvStatCd"), "");
		/*2022.01.12 검색 조건 추가 : END*/
		
		
		
		int intPage = Integer.parseInt(cPage);			/* 현재페이지 */
		int intListCnt = Integer.parseInt(listCnt);		/* 세로페이징(게시글수)*/
		int pageCnt = 10;								/* 가로페이징(페이지수) */
		int totalCnt = 0;								/* 총 건수  */
		
		params.put("aprv_up_cd", VarConsts.EAM_MASTER_CODE);
		params.put("uss_id", ussId);
		
		totalCnt = aprvMngDAO.getAprvTotalCount(params);
		
		int offSet = intListCnt * (ObjToConvert.strToint(cPage)-1);
		int limit = intListCnt;
		
		// 페이지 네비게이터 생성
		PageNavigator pageNavigator = new PageNavigator(
				intPage		
			   ,""
			   ,pageCnt		
			   ,intListCnt	
			   ,totalCnt	
			   ,""); // 검색 파라미터
		
		
		List list = aprvMngDAO.getAprvPageingList(params, offSet, limit);
		
		Map objectMap = new HashMap();
		
		objectMap.put("resultList", list);
		objectMap.put("cPage", cPage);
		objectMap.put("intListCnt", intListCnt);
		objectMap.put("totalCnt", totalCnt);
		objectMap.put("pageNavigator", pageNavigator.getMakePageScript());
		
		return objectMap;
	}
	
	/**
	 * 결재 정보 목록조회
	 */
	@Override
	public List getAprvList(Map params) throws Exception {
		return aprvMngDAO.getAprvList(params);
	}
	
	/**
	 * 결재 총건수
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public int getAprvTotalCount(Map params) throws Exception {
		return aprvMngDAO.getAprvTotalCount(params);
	}
	
	/**
	 * 결재 정보 상세조회
	 */
	@Override
	public Map getAprvView(Map params) throws Exception {
		
		if(params.get("line_chk") == null || params.get("conf_yn") == null){
			
		}else if(params.get("line_chk").equals("Y") && params.get("conf_yn").equals("N")){
			// 결재(line_chk -> Y) 이면서 미확인(conf_yn -> N) 일경우
			// 미확인을 확인으로 변경
			aprvMngDAO.updateConfYn(params);
		}
		
		return aprvMngDAO.getAprvView(params);
	}
	
	/**
	 * 결재 정보 등록
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public int aprvInsert(Map params, List fileList) throws Exception {
		
		int procResultVal = 0;
		String authCd = (String)params.get("auth_cd");
		
		// 결재 정보 등록
		if(StringUtils.equals(authCd, "ROLE_ADMIN")) {
			String loginUssId = (String)params.get("login_uss_id");
			params.put("crtn_emp_no", loginUssId);
			params.put("modi_emp_no", loginUssId);
			procResultVal = aprvMngDAO.aprvInsertAdmin(params);
		}else {
			procResultVal = aprvMngDAO.aprvInsert(params);
			
		}
		
		
		
		/*2022.01.18 휴가 등록 시 VCT_INF_MNG 휴가 정보 등록 : BEGIN*/
		String aprvTypeCd = (String)params.get("cdList1");
		
		if(StringUtils.equals(aprvTypeCd, VarConsts.EAM_VACATION_CODE)) {
			String termSt = (String)params.get("term_st");
			String termEd = (String)params.get("term_ed");
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat formatter2 = new SimpleDateFormat("yyyyMMdd");
			
			Date stDate = formatter.parse(termSt);
			Date edDate = formatter.parse(termEd);
			
			Calendar stCal = Calendar.getInstance();
			stCal.setTime(stDate);
			Calendar edCal = Calendar.getInstance();
			edCal.setTime(edDate);
			
			long diffDay = ( edCal.getTimeInMillis() - stCal.getTimeInMillis() ) / (1000 * 60 * 60 * 24);
			String vctDt = null;
			String dt = null;
			Map vctInfMap = null;
			
			params.put("uss_id", (String)params.get("rept_aprv_no"));
			
			Map ussInf = ussMngDAO.getUssView(params);
			
			Map codeMap = null; 
			String vctQrtr = "";
			String vctDayCnt = "";
			int dayOfWeek=0;
			int holCnt = 0;
			for(int i = 0; i <= diffDay; i++) {
				
				
				vctDt = formatter.format(stCal.getTime());
				dt = formatter2.format(stCal.getTime());
				
				vctInfMap = new HashMap();
				
				String vctTermType = "";
				
				vctInfMap.put("uss_id", (String)params.get("rept_aprv_no"));
				vctInfMap.put("vct_dt", vctDt);
				vctInfMap.put("aprv_no", (String)params.get("aprv_no"));
				vctInfMap.put("vct_type", (String)params.get("cdList2"));
				// 시작일자일 경우 : 시작일자반차구분코드
				if(i == 0) {
					vctTermType = (String)params.get("half_type_cd_st");
				}else if(i == diffDay) { //종료일자일 경우 : 종료일자반차구분코드
					vctTermType = (String)params.get("half_type_cd_ed");
				}else { // 그 외 : 종일 코드
					vctTermType = "CD0021001";
				}
				
				params.put("cd", vctTermType);
				codeMap = codeMngDAO.getCodeView(params);
				
				vctDayCnt = (String)codeMap.get("CD_VAL");
				
				vctInfMap.put("vct_trm_type", vctTermType);
				
				vctInfMap.put("vct_day_cnt", vctDayCnt);
				//휴가일자의 월로 계산
				String month = vctDt.substring(5, 7);
				if(StringUtils.equals(month, "01") ||
				   StringUtils.equals(month, "02") ||
				   StringUtils.equals(month, "03")  ) {
					vctQrtr = "1";
					
				}else if(StringUtils.equals(month, "04") ||
						 StringUtils.equals(month, "05") ||
						 StringUtils.equals(month, "06")  ) {
					vctQrtr = "2";
					
				}else if(StringUtils.equals(month, "07") ||
						 StringUtils.equals(month, "08") ||
						 StringUtils.equals(month, "09")  ) {
					vctQrtr = "3";
					
				}else {
					vctQrtr = "4";
				}
				vctInfMap.put("vct_qrtr", vctQrtr);
				
				vctInfMap.put("vct_yr", vctDt.substring(0, 4));
				vctInfMap.put("proj_cd", (String)params.get("proj_cd"));
				vctInfMap.put("emp_type", ussInf.get("EMP_TYPE"));
				vctInfMap.put("rtr_yn", ussInf.get("RTR_YN"));
				vctInfMap.put("aut_cd", (String)params.get("rept_auth_cd"));
				vctInfMap.put("use_yn", "Y");
				//공휴일, 주말 체크 로직
				dayOfWeek = stCal.get(Calendar.DAY_OF_WEEK);
				if(dayOfWeek == 1 || dayOfWeek == 7) {
					vctInfMap.put("use_yn", "N");
				}
				
				Map holMap = new HashMap();
				
				holMap.put("cal_hol_dt", dt);
				
				holCnt = holidayMngDAO.getHolidayCnt(holMap);
				
				if(holCnt > 0) {
					vctInfMap.put("use_yn", "N");
				}
				
				//등록
				
				int result = vctMngDAO.insertVctInf(vctInfMap);
				
				stCal.add(Calendar.DATE, 1);
			}
		}
		/*2022.01.18 휴가 등록 시 VCT_INF_MNG 휴가 정보 등록 : END*/
		
		
		// 결재 대상 등록
		if (procResultVal > 0) {
			
			Map aprvLineMap = null;
			
			int aprvLineCnt = 0;
			if (params.get("aprv_line_cnt") != null) {
				aprvLineCnt = Integer.parseInt((String)params.get("aprv_line_cnt"));
			}
			
			for (int i = 1; i <= aprvLineCnt; i++) {
				// 결재라인 맵 초기화
				aprvLineMap = null;
				
				// 파라메터 맵 복사
				aprvLineMap = params;
				
				aprvLineMap.put("aprv_emp_no", params.get("aprv_emp_no"+i));
				aprvLineMap.put("aprv_ordr", params.get("aprv_ordr"+i));
				aprvLineMap.put("aprv_ym", params.get("aprv_ym"+i));
				aprvLineMap.put("aprv_yn_cd", params.get("aprv_yn_cd"+i));
				aprvLineMap.put("refe_yn", params.get("refe_yn"+i)==null?'N':params.get("refe_yn"+i));
				aprvLineMap.put("conf_yn", 'N');
				
				procResultVal = aprvMngDAO.aprvLineInsert(aprvLineMap);	// 결재라인 등록
			}
		}
		
		//  결재 첨부파일 등록 
		int fileCnt = fileList.size();
		Map fileParams = new HashMap();
		for(int i=0; i < fileCnt; i++){
			Map file = (Map)fileList.get(i);
			fileParams = new HashMap();
			fileParams = params;
			fileParams.put("file_nm", file.get("OrignlFileNm"));		// 원문파일명
			fileParams.put("file_stre_nm", file.get("StreFileNm"));		// 저장파일명
			fileParams.put("file_path", file.get("FileStreCours"));		// 저장위치
			fileParams.put("file_size", file.get("FileMg"));			// 파일크기
			fileParams.put("file_ext", file.get("FileExtsn"));			// 파일확장자
			
			aprvMngDAO.aprvFileInsert(fileParams);
		}
		
		String cd1 = (String) params.get("cdList1");
		String cd2 = (String) params.get("cdList2");
		
		// 캘린더에 등록
		// CD0001011(휴가), CD0001012(휴직), CD0001009(출장)
		if ("CD0001011".equals(cd1) || "CD0001012".equals(cd1) || "CD0001009".equals(cd1)) {
			Map calAprvMap = null;
			calAprvMap = params;
			String aprv_nm = String.valueOf(params.get("aprv_nm"));	// 결재자 이름
			if(StringUtils.equals(authCd, "ROLE_ADMIN")) {
				aprv_nm = String.valueOf(params.get("rept_aprv_no_nm")); // 관리자가 선택한 결재자 이름
			}
			calAprvMap.put("cd", params.get("cdList2"));
			
			Map codeView = codeMngDAO.getCodeView(calAprvMap);	// 코드 조회
			
			String cd_nm = String.valueOf(codeView.get("CD_NM"));	// 코드 이름
			calAprvMap.put("cal_nm", aprv_nm + " " +cd_nm);
			calAprvMap.put("cal_content", params.get("rept_cont"));
			calAprvMap.put("cal_st_dt", params.get("term_st_ym"));
			calAprvMap.put("cal_ed_dt", params.get("term_ed_ym"));
			calAprvMap.put("cal_st_time", params.get("term_st_hm"));
			calAprvMap.put("cal_ed_time", params.get("term_ed_hm"));
			calAprvMap.put("uss_id", params.get("rept_aprv_no"));
			calAprvMap.put("aprv_yn", 'Y');
			
			
			int cal_seq = calMngDAO.calInsert(calAprvMap);
			params.put("cal_no", cal_seq);
			
			if(StringUtils.equals(authCd, "ROLE_ADMIN")) {
				aprvMngDAO.aprvUpdateAdmin(params);
			}else {
				aprvMngDAO.aprvUpdate(params);	// 캘린더 번호 저장
			}
		}
		
		// 결재문서에 등록
		if("CD0001011".equals(cd1)) { // 휴가신청
			docDAO.insertFrogh(params);
		} else if("CD0001013".equals(cd1)) { // 유연근무제신청
			if("CD0001013001".equals(cd2)) { // 시차출퇴근제
				docDAO.insertFlexWrkSyst(params);
			}
		} else if("CD0001008".equals(cd1)) { // 품의서
			docDAO.insertPttn(params);
		} else if("CD0001009".equals(cd1)) { // 출장
			if("CD0001009001".equals(cd2) || "CD0001009002".equals(cd2)) { // 출장정산(국내)-법인,일반
				docDAO.insertBztrpAdjs(params);
				for(Object i : params.keySet()) {
					String key = String.valueOf(i);
					String value = String.valueOf(params.get(key));
					if(key.contains("bztrp_item_div_")) {
						String num = key.replace("bztrp_item_div_", "");
						Map itemMap = new HashMap();
						itemMap.put("aprv_no", params.get("aprv_no"));
						itemMap.put("bztrp_item_seq", num);
						itemMap.put("bztrp_item_div", params.get("bztrp_item_div_" + num));
						itemMap.put("bztrp_item_ctnt", params.get("bztrp_item_ctnt_" + num));
						itemMap.put("bztrp_item_amt", params.get("bztrp_item_amt_" + num));
						itemMap.put("bztrp_item_rmrk", params.get("bztrp_item_rmrk_" + num));
						itemMap.put("bztrp_item_st_plc", params.get("bztrp_item_st_plc_" + num));
						itemMap.put("bztrp_item_ed_plc", params.get("bztrp_item_ed_plc_" + num));
						docDAO.insertBztrpAdjsItem(itemMap);
					} 
				}
			}
		} else if("CD0001015".equals(cd1)) { // 도서구매신청
			docDAO.insertBksBuyAplf(params);
		} else if("CD0001016".equals(cd1)) { // 교육훈련신청
			docDAO.insertEducTrain(params);
		} else if("CD0001010".equals(cd1)) { // 가지급금
			//가지급금 공통부
			docDAO.insertTmpPay(params);
			//가지급금 상세
			List<TmpPayItemVO> tmpPayItemList = (List<TmpPayItemVO> )params.get("tmpPayItemList");
			
			for (TmpPayItemVO tmpPayItemVO : tmpPayItemList) {
				if(tmpPayItemVO.getCd1() != null && !"".equals(tmpPayItemVO.getCd1())) {
					tmpPayItemVO.setAprvNo((String) params.get("aprv_no"));
					docDAO.insertTmpPayItem(tmpPayItemVO);									
				}
			}
		}

		return procResultVal;
	}
	
	/**
	 * 결재 정보 등록
	 */
	@Override
	public void aprvInsert2(Map params) throws Exception {

		Map aprvLineMap = null;

		int aprvLineCnt = 0;
		if (params.get("aprv_line_cnt") != null) {
			aprvLineCnt = Integer
					.parseInt((String) params.get("aprv_line_cnt"));
		}

		for (int i = 1; i <= aprvLineCnt; i++) {
			// 결재라인 맵 초기화
			aprvLineMap = null;

			// 파라메터 맵 복사
			aprvLineMap = params;

			aprvLineMap.put("aprv_emp_no", params.get("aprv_emp_no" + i));
			aprvLineMap.put("aprv_ordr", params.get("aprv_ordr" + i));
			aprvLineMap.put("aprv_ym", params.get("aprv_ym" + i));
			aprvLineMap.put("aprv_yn_cd", params.get("aprv_yn_cd" + i));
			aprvLineMap.put("refe_yn", params.get("refe_yn" + i) == null ? "N" : params.get("refe_yn" + i));
			aprvLineMap.put("conf_yn", "N");
			aprvLineMap.put("line_chk", "Y");

			String order = params.get("aprv_ordr" + i).toString();
			if (Integer.parseInt(order) == 1 || Integer.parseInt(order) == 0) {

				// 푸시 서비스 실행
				try{
					appPushService.googlePushSendPayment(aprvLineMap);
				}catch(Exception e){
					e.printStackTrace();
				}

			}

		}

	}
	
	/**
	 * 결재 정보 수정
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public int aprvUpdate(Map params, List fileList) throws Exception {
		
		int procResultVal = 0;
		
		String authCd = (String)params.get("auth_cd");
		
		// 결재 정보 수정
		if(StringUtils.equals(authCd, "ROLE_ADMIN")) {
			String loginUssId = (String)params.get("login_uss_id");
			params.put("crtn_emp_no", loginUssId);
			params.put("modi_emp_no", loginUssId);
			procResultVal = aprvMngDAO.aprvUpdateAdmin(params);
		}else {
			procResultVal = aprvMngDAO.aprvUpdate(params);
		}
		
		/*2022.01.18 휴가 수정 시 VCT_INF_MNG 휴가 정보 기존 정보 삭제 후 등록 : BEGIN*/
		String aprvTypeCd = (String)params.get("cdList1");
		
		if(StringUtils.equals(aprvTypeCd, VarConsts.EAM_VACATION_CODE)) {
			//기존 정보 삭제 후 재등록
			int result = vctMngDAO.deleteVctInf(params);
			
			
			String termSt = (String)params.get("term_st");
			String termEd = (String)params.get("term_ed");
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat formatter2 = new SimpleDateFormat("yyyyMMdd");
			
			Date stDate = formatter.parse(termSt);
			Date edDate = formatter.parse(termEd);
			
			Calendar stCal = Calendar.getInstance();
			stCal.setTime(stDate);
			Calendar edCal = Calendar.getInstance();
			edCal.setTime(edDate);
			
			long diffDay = ( edCal.getTimeInMillis() - stCal.getTimeInMillis() ) / (1000 * 60 * 60 * 24);
			String vctDt = null;
			String dt = null;
			Map vctInfMap = null;
			
			params.put("uss_id", (String)params.get("rept_aprv_no"));
			
			Map ussInf = ussMngDAO.getUssView(params);
			
			Map codeMap = null; 
			String vctQrtr = "";
			String vctDayCnt = "";
			int dayOfWeek = 0;
			int holCnt = 0;
			for(int i = 0; i <= diffDay; i++) {
				
				
				vctDt = formatter.format(stCal.getTime());
				dt = formatter2.format(stCal.getTime());
				vctInfMap = new HashMap();
				
				String vctTermType = "";
				
				vctInfMap.put("uss_id", (String)params.get("rept_aprv_no"));
				vctInfMap.put("vct_dt", vctDt);
				vctInfMap.put("aprv_no", (String)params.get("aprv_no"));
				vctInfMap.put("vct_type", (String)params.get("cdList2"));
				// 시작일자일 경우 : 시작일자반차구분코드
				if(i == 0) {
					vctTermType = (String)params.get("half_type_cd_st");
				}else if(i == diffDay) { //종료일자일 경우 : 종료일자반차구분코드
					vctTermType = (String)params.get("half_type_cd_ed");
				}else { // 그 외 : 종일 코드
					vctTermType = "CD0021001";
				}
				
				params.put("cd", vctTermType);
				codeMap = codeMngDAO.getCodeView(params);
				
				vctDayCnt = (String)codeMap.get("CD_VAL");
				
				vctInfMap.put("vct_trm_type", vctTermType);
				
				vctInfMap.put("vct_day_cnt", vctDayCnt);
				//휴가일자의 월로 계산
				String month = vctDt.substring(5, 7);
				if(StringUtils.equals(month, "01") ||
				   StringUtils.equals(month, "02") ||
				   StringUtils.equals(month, "03")  ) {
					vctQrtr = "1";
					
				}else if(StringUtils.equals(month, "04") ||
						 StringUtils.equals(month, "05") ||
						 StringUtils.equals(month, "06")  ) {
					vctQrtr = "2";
					
				}else if(StringUtils.equals(month, "07") ||
						 StringUtils.equals(month, "08") ||
						 StringUtils.equals(month, "09")  ) {
					vctQrtr = "3";
					
				}else {
					vctQrtr = "4";
				}
				vctInfMap.put("vct_qrtr", vctQrtr);
				
				vctInfMap.put("vct_yr", vctDt.substring(0, 4));
				vctInfMap.put("proj_cd", (String)params.get("proj_cd"));
				vctInfMap.put("emp_type", (String)ussInf.get("EMP_TYPE"));
				vctInfMap.put("rtr_yn", (String)ussInf.get("RTR_YN"));
				vctInfMap.put("aut_cd", (String)params.get("rept_auth_cd"));
				vctInfMap.put("use_yn", "Y");
				//공휴일, 주말 체크 로직
				dayOfWeek = stCal.get(Calendar.DAY_OF_WEEK);
				if(dayOfWeek == 1 || dayOfWeek == 7) {
					vctInfMap.put("use_yn", "N");
				}
				
				Map holMap = new HashMap();
				
				holMap.put("cal_hol_dt", dt);
				
				holCnt = holidayMngDAO.getHolidayCnt(holMap);
				
				if(holCnt > 0) {
					vctInfMap.put("use_yn", "N");
				}
				
				//등록
				
				result = vctMngDAO.insertVctInf(vctInfMap);
				
				stCal.add(Calendar.DATE, 1);
			}
		}
		/*2022.01.18 휴가 수정 시 VCT_INF_MNG 휴가 정보 기존 정보 삭제 후 등록 : END*/
		
		
		
		
		// 결재 라인 수정
		if (procResultVal > 0 && params.get("aprv_line_cd").equals("0")) {
			aprvMngDAO.aprvLineDelete(params);	// 결재라인 삭제
			
			Map aprvLineMap = null;
			
			int aprvLineCnt = 0;
			if (params.get("aprv_line_cnt") != null) {
				aprvLineCnt = Integer.parseInt((String)params.get("aprv_line_cnt"));
			}
			
			for (int i = 1; i <= aprvLineCnt; i++) {
				// 결재라인 맵 초기화
				aprvLineMap = null;
				
				// 파라메터 맵 복사
				aprvLineMap = params;
				
				aprvLineMap.put("aprv_emp_no", params.get("aprv_emp_no"+i));
				aprvLineMap.put("aprv_ordr", params.get("aprv_ordr"+i));
				aprvLineMap.put("aprv_ym", params.get("aprv_ym"+i));
				aprvLineMap.put("aprv_yn_cd", params.get("aprv_yn_cd"+i));
				aprvLineMap.put("refe_yn", params.get("refe_yn"+i));
				
				procResultVal = aprvMngDAO.aprvLineInsert(aprvLineMap);	// 결재라인 등록
			}
		}else if(procResultVal > 0 && (params.get("aprv_line_cd").equals("2") || params.get("aprv_line_cd").equals("3")) ){
			/* 반려나 보류일경우 해당 결재라인의 정보를 대기로 변경 */
			aprvMngDAO.aprvLineUpdateYncd(params);
		}

		int fileCnt = fileList.size();
		if(fileCnt > 0){
			//  결재 첨부파일 등록 
			Map fileParams = new HashMap();
			for(int i=0; i < fileCnt; i++){
				Map file = (Map)fileList.get(i);
				fileParams = new HashMap();
				fileParams = params;
				fileParams.put("file_nm", file.get("OrignlFileNm"));		// 원문파일명
				fileParams.put("file_stre_nm", file.get("StreFileNm"));		// 저장파일명
				fileParams.put("file_path", file.get("FileStreCours"));		// 저장위치
				fileParams.put("file_size", file.get("FileMg"));			// 파일크기
				fileParams.put("file_ext", file.get("FileExtsn"));			// 파일확장자
				
				aprvMngDAO.aprvFileInsert(fileParams);
			}
		}
		
		String cd1 = (String) params.get("cdList1");
		String cd2 = (String) params.get("cdList2");
		// 캘린더 수정
		// CD0001011(휴가), CD0001012(휴직), CD0001009(출장)
		if ("CD0001011".equals(cd1) || "CD0001012".equals(cd1) || "CD0001009".equals(cd1)) {
			Map calAprvMap = null;
			calAprvMap = params;
			
			String aprv_nm = String.valueOf(params.get("aprv_nm"));	// 결재자 이름
			if(StringUtils.equals(authCd, "ROLE_ADMIN")) {
				aprv_nm = String.valueOf(params.get("rept_aprv_no_nm")); // 관리자가 선택한 결재자 이름
			}
			calAprvMap.put("cd", params.get("cdList2"));	// 코드 조회용
			
			Map codeView = codeMngDAO.getCodeView(calAprvMap);	// 코드 조회
			
			String cd_nm = String.valueOf(codeView.get("CD_NM"));	// 코드 이름
			
			calAprvMap.put("cal_nm", aprv_nm + " " +cd_nm);
			calAprvMap.put("cal_content", params.get("rept_cont"));
			calAprvMap.put("cal_st_dt", params.get("term_st_ym"));
			calAprvMap.put("cal_ed_dt", params.get("term_ed_ym"));
			calAprvMap.put("cal_st_time", params.get("term_st_hm"));
			calAprvMap.put("cal_ed_time", params.get("term_ed_hm"));
			calAprvMap.put("aprv_yn", 'Y');
			
			// 생성된 캘린더가 있을 때 캘린더 수정
			if(!"".equals(params.get("cal_no"))){
				calAprvMap.put("cal_seq", params.get("cal_no"));
				calMngDAO.calUpdate(calAprvMap);	// 캘린더 수정
				
			// 생성된 캘린더가 없을 때 캘린더 생성
			}else if("".equals(params.get("cal_no"))){
				calAprvMap.put("uss_id", params.get("rept_aprv_no"));
				
				int cal_seq = calMngDAO.calInsert(calAprvMap);	// 캘린더 삭제
				params.put("cal_no", cal_seq);
				
				if(StringUtils.equals(authCd, "ROLE_ADMIN")) {
					aprvMngDAO.aprvUpdateAdmin(params);
				}else {
					aprvMngDAO.aprvUpdate(params);	// 캘린더 번호 저장
				}
			}
		}
		
		// 결재문서에 수정
		if("CD0001011".equals(cd1)) { // 휴가신청
			docDAO.updateFrogh(params);
		} else if("CD0001013".equals(cd1)) { // 유연근무제신청
			if("CD0001013001".equals(cd2)) { // 시차출퇴근제
				docDAO.updateFlexWrkSyst(params);
			}
		} else if("CD0001008".equals(cd1)) { // 품의서
			docDAO.updatePttn(params);
		} else if("CD0001009".equals(cd1)) { // 출장
			if("CD0001009001".equals(cd2) || "CD0001009002".equals(cd2)) { // 출장정산(국내)-법인,일반
				docDAO.deleteBztrpAdjsItem(params);
				for(Object i : params.keySet()) {
					String key = String.valueOf(i);
					String value = String.valueOf(params.get(key));
					if(key.contains("bztrp_item_div_")) {
						String num = key.replace("bztrp_item_div_", "");
						Map itemMap = new HashMap();
						itemMap.put("aprv_no", params.get("aprv_no"));
						itemMap.put("bztrp_item_seq", num);
						itemMap.put("bztrp_item_div", params.get("bztrp_item_div_" + num));
						itemMap.put("bztrp_item_ctnt", params.get("bztrp_item_ctnt_" + num));
						itemMap.put("bztrp_item_amt", params.get("bztrp_item_amt_" + num));
						itemMap.put("bztrp_item_rmrk", params.get("bztrp_item_rmrk_" + num));
						itemMap.put("bztrp_item_st_plc", params.get("bztrp_item_st_plc_" + num));
						itemMap.put("bztrp_item_ed_plc", params.get("bztrp_item_ed_plc_" + num));
						docDAO.insertBztrpAdjsItem(itemMap);
					} 
				}
				docDAO.updateBztrpAdjs(params);
			}
		} else if("CD0001015".equals(cd1)) { // 도서구매신청
			docDAO.updateBksBuyAplf(params);
		} else if("CD0001016".equals(cd1)) { // 교육훈련신청
			docDAO.updateEducTrain(params);
		} else if("CD0001010".equals(cd1)) { // 가지급금
			//가지급금 공통부
			docDAO.updateTmpPay(params);
			//가지급금 상세
			List<TmpPayItemVO> tmpPayItemList = (List<TmpPayItemVO> )params.get("tmpPayItemList");
			String delList = (String)params.get("delList");
			String[] delArr = delList.split(",");

			//기존 정보 삭제
			for(String delNo : delArr) {
				if(StringUtils.isNotEmpty(delNo)) {
					params.put("item_no", delNo);
					docDAO.deleteTmpPayItem(params);					
				}
			}
			// 기존 정보 : 수정 / 신규 정보 : 추가
			for (TmpPayItemVO tmpPayItemVO : tmpPayItemList) {
				if(tmpPayItemVO.getCd1() != null && !"".equals(tmpPayItemVO.getCd1())) {
					tmpPayItemVO.setAprvNo((String) params.get("aprv_no"));
					docDAO.insertTmpPayItem(tmpPayItemVO);									
				}
			}
			
		}
		
		return procResultVal;
	}
	
	/**
	 * 결재 정보 삭제
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public int aprvDelete(Map params) throws Exception {
		
		int procResultVal = 0;
		
		String cd1 = (String) params.get("cdList1");
		String cd2 = (String) params.get("cdList2");
		
		
		// 결재문서 삭제
		if("CD0001011".equals(cd1)) { // 휴가신청
			docDAO.deleteFrogh(params);
			vctMngDAO.deleteVctInf(params);
		} else if("CD0001013".equals(cd1)) { // 유연근무제신청
			if("CD0001013001".equals(cd2)) { // 시차출퇴근제
				docDAO.deleteFlexWrkSyst(params);
			}
		} else if("CD0001008".equals(cd1)) { // 품의서
			docDAO.deletePttn(params);
		} else if("CD0001009".equals(cd1)) { // 출장
			if("CD0001009001".equals(cd2) || "CD0001009002".equals(cd2)) { // 출장정산(국내)
				docDAO.deleteBztrpAdjsItem(params);
				docDAO.deleteBztrpAdjs(params);
			}
		} else if("CD0001015".equals(cd1)) { // 도서구매신청
			docDAO.deleteBksBuyAplf(params);
		} else if("CD0001016".equals(cd1)) { // 교육훈련신청
			docDAO.deleteEducTrain(params);
		} else if("CD0001010".equals(cd1)) { // 가지급금
			//가지급금 상세 정보 삭제
			docDAO.deleteTmpPayItem(params);
			//가지급금 공통 정보 삭제
			docDAO.deleteTmpPay(params);
		}
		
		// 결재 라인 삭제
		procResultVal = aprvMngDAO.aprvLineDelete(params);
		
		// 결재 첨부파일 삭제
		if (procResultVal > 0) {
			aprvMngDAO.aprvFileDelete(params);
		}
		
		// 결재 정보 삭제
		if (procResultVal > 0) {
			procResultVal = aprvMngDAO.aprvDelete(params);
		}
		
		// 캘린더 삭제
		if(procResultVal > 0 && !"".equals(params.get("cal_seq"))) {
			calMngDAO.calDelete(params);
		}
		
		return procResultVal;
	}
	
	/**
	 * 결재라인 등록
	 */
	@Override
	public int aprvLineInsert(Map params) throws Exception {
		return aprvMngDAO.aprvLineInsert(params);
	}
	
	/**
	 * 결재라인 삭제
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public int aprvLineDelete(Map params) throws Exception {
		return aprvMngDAO.aprvLineDelete(params);
	}
	
	/**
	 * 결재라인 목록조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public List aprvLineList(Map params) throws Exception {
		return aprvMngDAO.aprvLineList(params);
	}
	
	/**
	 * 결재승인 (완료, 보류, 반려)
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public void aprvLineUpdate(Map params) throws Exception {
		String aprv_emp_no = (String) params.get("aprv_emp_no");
		String aprv_no = "";
		String line_chk = "";
		String conf_yn = "";
		
		if(params.get("aprv_yn_cd") == null){
		}else if(params.get("aprv_yn_cd").equals("3")){
			// 반려시 이전 결재자정보를 반려로 변경
			aprvMngDAO.updateCompanion(params);
		}
		// 결제정보 승인
		aprvMngDAO.aprvLineUpdate(params);
		
		if(params.get("aprv_yn_cd").equals("1")){
			List list = aprvMngDAO.aprvLineList(params);
			
			String emp_no_next = "";
			int ordr_next = 0;

			// 다음결제자 번호 read
			for (int i = 0; i < list.size(); i++) {
				HashMap map = (HashMap) list.get(i);
				String emp_no = map.get("APRV_EMP_NO").toString();
				String ordr = map.get("APRV_ORDR").toString();
				if (emp_no.equals(aprv_emp_no)) {
					ordr_next = Integer.parseInt(ordr) + 1;
				}
			}

		
			// 다음결제자 정보 read
			for (int i = 0; i < list.size(); i++) {
				HashMap map = (HashMap) list.get(i);
				String emp_no = map.get("APRV_EMP_NO").toString();
				int  ordr = Integer.parseInt(map.get("APRV_ORDR").toString());
				if (ordr_next == ordr) {
					aprv_no = map.get("APRV_NO").toString();
					emp_no_next = emp_no;
					conf_yn = map.get("CONF_YN").toString();
				}
			}
			
			// 다음결제자에 대한 push
			if (!"".equals(emp_no_next)) {
				//TODO push logic
				params.put("title", "[LETECH] 확인할 정보가 있습니다.");
				params.put("aprv_emp_no", emp_no_next);
				if(aprv_no.isEmpty()){
					line_chk = "N";
				}else{
					line_chk = "Y";
				}
				params.put("line_chk", line_chk);
				params.put("aprv_no", aprv_no);
				params.put("conf_yn", conf_yn);
				appPushService.googlePushSendPayment(params);
			}
			
			
		}else if(params.get("aprv_yn_cd").equals("3")){
			List list = aprvMngDAO.aprvLineList(params);
			
			String emp_no_next = "";
			int ordr_next = 0;

			// 반려자 번호 read
			for (int i = 0; i < list.size(); i++) {
				HashMap map = (HashMap) list.get(i);
				if (i == 0) {
					//TODO push logic
					params.put("title", "[LETECH] 확인할 정보가 있습니다.");
					String test = (String) map.get("CRTN_EMP_NO");
					params.put("aprv_emp_no", test);
					if(aprv_no.isEmpty()){
						line_chk = "N";
					}else{
						line_chk = "Y";
					}
					params.put("line_chk", line_chk);
					params.put("aprv_no", aprv_no);
					params.put("conf_yn", conf_yn);
					appPushService.googlePushSendPayment(params);
				}
			}
		}
	}
	
	/**
	 * 결재 첨부파일정보 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public List aprvFileList(Map params) throws Exception {
		return aprvMngDAO.aprvFileList(params);
	}
	
	/**
	 * 파일 삭제
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public void aprvFileDelete(Map params) throws Exception {
		/* 일정 파일 삭제 */
		aprvMngDAO.aprvFileOneDelete(params);
		
		/* 물리적 파일 삭제 */
		String file_stre_nm = (String)params.get("file_stre_nm");		// 저장파일명
		String file_path = (String)params.get("file_path");			// 저장위치
		// 파일 삭제
		EgovFileTool.deleteFile(file_path+file_stre_nm);
	}
	
	/**
	 * 결제중, 반려, 보류인 정보 조회(aprv_yn_cd = 0:결재중, 3:반려, 2:보류 )
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public List layerAprvInfo(Map params) throws Exception {
		return aprvMngDAO.layerAprvInfo(params);
	}
	
	/**
	 * 결제중, 반려, 보류인 정보 건수조회(aprv_yn_cd = 0:결재중, 3:반려, 2:보류 )
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public int layerAprvInfoCount(Map params) throws Exception {
		return aprvMngDAO.layerAprvInfoCount(params);
	}

	/**
	 * 결재자가 결재할 정보를 확인한 경우
	 * @param params
	 * @throws Exception
	 */
	@Override
	public void updateConfYn(Map params) throws Exception {
		aprvMngDAO.updateConfYn(params);
	}

	/**
	* 로그인한 사용자의 결재라인을 반환
	* 작성자 : JO MIN SOO
	* @param params
	* @return
	* @throws Exception
	*/
	@Override
	public List aprvLineInfoList(Map params) throws Exception {
		return aprvMngDAO.aprvLineInfoList(params);
	}
	
	/**
	* BIZPLAY API를 호출하여 받아온 데이터를 적재하고 결재완료된 건을 인트라넷에 추가
	* @param request
	* @param model
	* @return
	* @throws Exception
	*/
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public void insertBizplayData(Map params) throws Exception {
		JSONArray receiptArray = new JSONArray(); // 영수증이 저장될 리스트
		
		// 입력부 데이터 입력 시작 
		JSONObject jsonData = new JSONObject();
		jsonData.put("API_ID", "0411A");
		jsonData.put("API_KEY", "b10b7fb2-dccc-1657-bde8-b580cbc48355");
		jsonData.put("ORG_CD", "6298800134");
		
		JSONObject reqData = new JSONObject();
		reqData.put("BIZ_NO", "6298800134");
		reqData.put("CARD_NO", "");
		reqData.put("START_DATE", params.get("START_DATE"));
		reqData.put("START_TIME", "");
		reqData.put("END_DATE", params.get("END_DATE"));
		reqData.put("END_TIME", "");
		reqData.put("RCV_STS", "");
		reqData.put("REQ_CNT", "");
		reqData.put("NEXT_KEY", "");
		reqData.put("REQ_ATTIMG_YN", "Y"); // 첨부이미지포함여부
				
		jsonData.put("REQ_DATA", reqData);
		// 입력부 데이터 입력 끝 
		
		// 비즈플레이 API에서는 한번에 50건의 영수증만 반환하며 50건을 초과하면 NEXTKEY를 반환
		// NEXTKEY를 입력부에 추가하여 다시 API를 호출하여야 됨
		while(true) {
			// BIZPLAY API의 URL에 입력부 데이터를 추가하여 인코딩한 URL 생성
			URI targetUrl = UriComponentsBuilder.fromUriString("https://webankapi.appplay.co.kr/")	// Build the base link
				.path("gateway.do")					// Add path
				.queryParam("JSONData", jsonData)	// Add one or more query params
				.build()							// Build the URL
				.encode()							// Encode any URI items that need to be encoded
				.toUri();							// Convert to URI
			
			// RestTemplate을 이용하여 API 호출 및 데이터 반환
			RestTemplate rest = new RestTemplate();
			String result = rest.getForObject(targetUrl, String.class);
			
			// 받아온 데이터를 Map 데이터로 변환
			Map rtnData = JSONObject.fromObject(result);
			JSONArray resData = (JSONArray) rtnData.get("RES_DATA");
			receiptArray.addAll(resData);
			
			String nextKey = rtnData.get("NEXT_KEY") + "";
			if("".equals(nextKey)) { // NEXTKEY가 없으면 API호출을 중단
				break;
			} else {
				reqData.put("NEXT_KEY", nextKey);
				jsonData.put("REQ_DATA", reqData);
			}
		}
			
		for(int i = 0; i < receiptArray.size(); i++) {
			Map tempMap = (Map) receiptArray.get(i);
			Map paramMap = new HashMap();
			
			for(Object key : tempMap.keySet()) {
				// jsonarray에는 null이 JSONNull타입임.. 따라서 그대로 사용하면 mybatis에서 에러가 발생했음. JSONNull인 경우 저장하지 않아 null로 처리
				if(!(JSONNull.class == tempMap.get(key).getClass())) {
					paramMap.put(key, tempMap.get(key));
				}
			}
			
			// BP_0411A 테이블에 모든 결재건 적재
			aprvMngDAO.insertBizplayData(paramMap);
			
			// BP_0411A_FILE 테이블에 결재건에 대한 첨부파일들 등록
			aprvMngDAO.deleteBizplayFile(paramMap);
			JSONArray fileList = (JSONArray) tempMap.get("ATT_IMG_LIST");
			for(int j = 0; j < fileList.size(); j++) {
				Map tempMap2 = (Map) fileList.get(j);
				paramMap.put("IMG_SEQ_NO", tempMap2.get("IMG_SEQ_NO"));
				paramMap.put("REG_DTM", tempMap2.get("REG_DTM"));
				paramMap.put("RCPT_IMG_URL", tempMap2.get("RCPT_IMG_URL"));
				paramMap.put("ORG_IMG_URL", tempMap2.get("ORG_IMG_URL"));
				paramMap.put("IMG_NM", (String)paramMap.get("APV_DT") + "_" + paramMap.get("MEST_NM") + "_" + tempMap2.get("IMG_SEQ_NO"));
				
				aprvMngDAO.insertBizplayFile(paramMap);
			}
			
			// BP_0411A_LINE 테이블에 결재건에 대한 결재라인들 등록
			JSONArray lineList = (JSONArray) tempMap.get("CD_PPP_APPR_REC");
			for(int j = 0; j < lineList.size(); j++) {
				Map tempMap2 = (Map) lineList.get(j);
				if((JSONNull.class == tempMap2.get("APRV_EMP_CD").getClass())) {
					continue;
				}
				paramMap.put("APPV_SEQ_NO", tempMap2.get("APPV_SEQ_NO"));
				paramMap.put("APRV_LINE_NM", tempMap2.get("APRV_LINE_NM"));
				paramMap.put("APPR_KIND", tempMap2.get("APPR_KIND"));
				paramMap.put("APRV_DATE", tempMap2.get("APRV_DATE"));
				paramMap.put("APRV_EMP_CD",  tempMap2.get("APRV_EMP_CD"));
				paramMap.put("APRV_USER_GB", tempMap2.get("APRV_USER_GB"));
				paramMap.put("APRV_USER_DEPT_NM", tempMap2.get("APRV_USER_DEPT_NM"));
				
				aprvMngDAO.insertBizplayLine(paramMap);
			}
		}
	}

	/**
	* 데이터베이스에 적재된 비즈플레이 영수증들을 조합하여 인트라넷에 결재 데이터 추가
	* 작성자 : JO MIN SOO
	* @param params
	* @return
	* @throws Exception
	*/
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public void insertBizplayAprv(Map params) throws Exception {
		List<Map> rtnList = aprvMngDAO.getBizplayAprvData(params); // 비즈플레이 영수증 리스트 반환
		
		Map<String, Object> sortedMap = new HashMap<String, Object>();
		
		for(int i = 0; i < rtnList.size(); i++) { // 같은 결의서 번호끼리 묶어서 맵에 리스트로 넣어줌
			Map rtnMap = (Map) rtnList.get(i);
			
			if(sortedMap.get(rtnMap.get("PPP_APPR_SEQ_NO")) == null) { // list가 있는지
				List list = new ArrayList<Object>();
				list.add(rtnMap);
				sortedMap.put((String) rtnMap.get("PPP_APPR_SEQ_NO"), list);
			} else {
				List list = (List) sortedMap.get(rtnMap.get("PPP_APPR_SEQ_NO"));
				list.add(rtnMap);
			}
		}
		
		for(String key : sortedMap.keySet()) { // 맵의 요소를 모두 조회하며 각 리스트 반복(리스트는 영수증 1건) 
			List sortedList = (List) sortedMap.get(key);
			Map paramMap = null;
			paramMap = (Map) sortedList.get(0);
			
			// 모든 데이터 중 결재완료(9)인 데이터는 지출결의 완료 등록
			// 저장될 데이터 정제 시작 
			paramMap.put("REPT_APRV_NO", paramMap.get("LST_USER_EMP_CD")); // 작성자
			paramMap.put("APRV_TYPE_CD", "CD0001007"); // 지출결의의 코드
			paramMap.put("APRV_TYPE_DTIL_CD", "CD000100700" + paramMap.get("CARD_TYPE")); // 결재구분상세코드 [법인은 1, 일반(개인)은 2, 송금은 3]
			
			paramMap.put("TITLE", paramMap.get("APPR_SUBJ")); // 제목
			
			paramMap.put("PROJ_CD", paramMap.get("BIZ_UNIT_ERP_CD")); // 프로젝트 코드
			
			paramMap.put("REPT_CONT", paramMap.get("APPR_CONT")); // 보고내용 
			paramMap.put("HALF_TYPE_CD", "0"); // 반차구분코드

			// 시작 ~ 종료 기간 설정
			int startDate = Integer.parseInt(paramMap.get("APV_DT") + "");
			int endDate = Integer.parseInt(paramMap.get("APV_DT") + "");
			for(int i = 0; i < sortedList.size(); i++) {
				Map paramMap2 = (Map) sortedList.get(i);
				int date = Integer.parseInt(paramMap2.get("APV_DT") + "");
				if(date < startDate) {
					startDate = date;
				} else if(date > endDate) {
					endDate = date;
				}
			}
			String termStYm = String.valueOf(startDate).substring(0, 4) + "-" + 
								String.valueOf(startDate).substring(4, 6) + "-" + 
								String.valueOf(startDate).substring(6, 8);
			String termEdYm = String.valueOf(endDate).substring(0, 4) + "-" + 
								String.valueOf(endDate).substring(4, 6) + "-" + 
								String.valueOf(endDate).substring(6, 8);
			paramMap.put("TERM_ST_YM", termStYm);
			paramMap.put("TERM_ED_YM", termEdYm);
			// 저장될 데이터 정제 끝
			
			aprvMngDAO.insertBizplayAprv(paramMap); // 결재정보 등록
			
			// 결재 대상(결재 라인) 등록
			List aprvLineList = aprvMngDAO.getBizplayLine(paramMap.get("PPP_APPR_SEQ_NO") + "");
			for (int j = 0; j < aprvLineList.size(); j++) {
				Map aprvLineMap = (Map) aprvLineList.get(j);
				
				if(("1").equals(aprvLineMap.get("APPR_KIND"))) { // 기안자(작성자)일 때 스킵
					continue;
				}
					
				aprvLineMap.put("PPP_APPR_SEQ_NO", paramMap.get("PPP_APPR_SEQ_NO"));
				aprvLineMap.put("APRV_ORDR", Integer.parseInt((String) aprvLineMap.get("APPV_SEQ_NO")));
				aprvLineMap.put("APRV_YN_CD", 1);
				aprvLineMap.put("CRTN_EMP_NO", paramMap.get("USER_EMP_CD"));
				aprvLineMap.put("CRTN_DT", paramMap.get("DRAFT_DATE"));
				aprvLineMap.put("MODI_DT", aprvLineMap.get("APRV_DATE"));
				aprvLineMap.put("CONF_YN", 'Y');
				if(("4").equals(aprvLineMap.get("APPR_KIND"))) { // 참조인
					aprvLineMap.put("REFE_YN", "Y");
				} else {
					aprvLineMap.put("REFE_YN", "N");
				}
				
				aprvMngDAO.insertBizplayAprvLine(aprvLineMap);	// 결재라인 등록
			}
		}
	}

	/**
	* BIZPLAY에서 받아온 영수증과 첨부파일이미지를 반환
	* 작성자 : JO MIN SOO
	* @param params
	* @return
	* @throws Exception
	*/
	@Override
	public Map getAprvRecList(Map params) throws Exception {
		List recList = aprvMngDAO.getBizplayData(params);
		params.put("recList", recList);
		
		List<Map> fileList = new ArrayList<Map>();
		for(int i = 0; i < recList.size(); i++) {
			List tempList = aprvMngDAO.getBizplayFile((Map)recList.get(i));
			for(int j = 0; j < tempList.size(); j++) {
				fileList.add((Map) tempList.get(j));
			}
		}
		params.put("recFileList", fileList);
		
		return params;
	}

	/**
	* 지역별 출장비 리스트 반환
	* 작성자 : JO MIN SOO
	* @return
	* @throws Exception
	*/
	@Override
	public List getTrcsList() throws Exception {
		return aprvMngDAO.getTrcsList();
	}

	/**
	* 유저의 여비 정보를 반환
	* 작성자 : JO MIN SOO
	* @param params
	* @return
	* @throws Exception
	*/
	@Override
	public List getTrvctInfo(Map params) throws Exception {
		return aprvMngDAO.getTrvctInfo(params);
	}
	
	/**
	 * 결재문서 관리자 취소/취소해제
	 * 작성자 : yhkim
	 * @param params
	 * @throws Exception
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public void updateAprvCancelAdmin(Map params) throws Exception {
		
		String cancelYn = (String)params.get("cancel_yn");
		
		//전달받은 취소여부가 'Y' 일경우 'N'으로 변경 (취소해제)
		if(StringUtils.equals(cancelYn, "Y")) {
			params.put("cancel_yn", "N");
		}else {
			//전달받은 취소여부가 'Y'가 아닌 경우 'Y'로 변경(취소)
			params.put("cancel_yn", "Y");
		}
		
		aprvMngDAO.updateAprvCancelAdmin(params);
		
	}

	@Override
	public Map getVctLeftDay(Map params) throws Exception {
		return aprvMngDAO.getVctLeftDay(params);
	}

	

}
