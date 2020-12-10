package kr.letech.aprv.service.impl;

import java.net.URI;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.ibatis.reflection.wrapper.MapWrapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import kr.letech.app.service.AppPushService;
import kr.letech.aprv.service.AprvMngService;
import kr.letech.cal.service.impl.CalMngDAO;
import kr.letech.cmm.util.EgovFileTool;
import kr.letech.cmm.util.ObjToConvert;
import kr.letech.cmm.util.PageNavigator;
import kr.letech.cmm.util.ReqUtils;
import kr.letech.cmm.util.VarConsts;
import kr.letech.sys.cdm.service.impl.CodeMngDAO;
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
		
		
		int intPage = Integer.parseInt(cPage);			/* 현재페이지 */
		int intListCnt = Integer.parseInt(listCnt);		/* 세로페이징(게시글수)*/
		int pageCnt = 10;								/* 가로페이징(페이지수) */
		int totalCnt = 0;								/* 총 건수  */
		
		params.put("aprv_up_cd", VarConsts.EAM_MASTER_CODE);
		
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

		// 결재 정보 등록
		procResultVal = aprvMngDAO.aprvInsert(params);
		
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
		
		// 캘린더에 등록
		// CD0001011(휴가), CD0001012(휴직), CD0001009(출장)
		if (params.get("cdList1").equals("CD0001011") || params.get("cdList1").equals("CD0001012") || params.get("cdList1").equals("CD0001009")) {
			Map calAprvMap = null;
			calAprvMap = params;
			String aprv_nm = String.valueOf(params.get("aprv_nm"));	// 결재자 이름
			calAprvMap.put("cd", params.get("cdList2"));
			
			Map codeView = codeMngDAO.getCodeView(calAprvMap);	// 코드 조회
			
			String cd_nm = String.valueOf(codeView.get("CD_NM"));	// 코드 이름
			calAprvMap.put("cal_nm", aprv_nm + " " +cd_nm);
			calAprvMap.put("cal_content", params.get("rept_cont"));
			calAprvMap.put("cal_st_dt", params.get("term_st_ym"));
			calAprvMap.put("cal_ed_dt", params.get("term_ed_ym"));
			calAprvMap.put("cal_st_time", String.valueOf(params.get("term_st_h")) + String.valueOf(params.get("term_st_m")));
			calAprvMap.put("cal_ed_time", String.valueOf(params.get("term_ed_h")) + String.valueOf(params.get("term_ed_m")));
			calAprvMap.put("uss_id", params.get("rept_aprv_no"));
			calAprvMap.put("aprv_yn", 'Y');
			
			
			int cal_seq = calMngDAO.calInsert(calAprvMap);
			params.put("cal_no", cal_seq);
			aprvMngDAO.aprvUpdate(params);	// 캘린더 번호 저장
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
			aprvLineMap.put("refe_yn", params.get("refe_yn" + i) == null ? "N"
					: params.get("refe_yn" + i));
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
		
		// 결재 정보 수정
		procResultVal = aprvMngDAO.aprvUpdate(params);
		
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
		// 캘린더 수정
		// CD0001011(휴가), CD0001012(휴직), CD0001009(출장)
		if (params.get("cdList1").equals("CD0001011") || params.get("cdList1").equals("CD0001012") || params.get("cdList1").equals("CD0001009")) {
			Map calAprvMap = null;
			calAprvMap = params;
			
			String aprv_nm = String.valueOf(params.get("aprv_nm"));	// 결재자 이름
			calAprvMap.put("cd", params.get("cdList2"));	// 코드 조회용
			
			Map codeView = codeMngDAO.getCodeView(calAprvMap);	// 코드 조회
			
			String cd_nm = String.valueOf(codeView.get("CD_NM"));	// 코드 이름
			
			calAprvMap.put("cal_nm", aprv_nm + " " +cd_nm);
			calAprvMap.put("cal_content", params.get("rept_cont"));
			calAprvMap.put("cal_st_dt", params.get("term_st_ym"));
			calAprvMap.put("cal_ed_dt", params.get("term_ed_ym"));
			calAprvMap.put("cal_st_time", String.valueOf(params.get("term_st_h")) + String.valueOf(params.get("term_st_m")));
			calAprvMap.put("cal_ed_time", String.valueOf(params.get("term_ed_h")) + String.valueOf(params.get("term_ed_m")));
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
				
				aprvMngDAO.aprvUpdate(params);	// 캘린더 번호 저장
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
	* BIZPLAY API를 호출하여 받아온 데이터를 적재하고 결재완료된 건을 인트라넷에 추가
	* @param request
	* @param model
	* @return
	* @throws Exception
	*/
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public Object loadBizplay(Map params) throws Exception {
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
		
		for(int i = 0; i < resData.size(); i++) {
			Map tempMap = (Map) resData.get(i);
			Map paramMap = new HashMap();
			
			// 공통 코드 추가
			paramMap.put("RESULT_MG", rtnData.get("RESULT_MG"));
			paramMap.put("RESULT_CD", rtnData.get("RESULT_CD"));
			paramMap.put("NEXT_KEY", rtnData.get("NEXT_KEY"));
			
			for(Object key : tempMap.keySet()) {
				// jsonarray에는 null이 JSONNull타입임.. 따라서 그대로 사용하면 mybatis에서 에러가 발생했음. JSONNull인 경우 저장하지 않아 null로 처리
				if(!(tempMap.get(key).getClass() == JSONNull.class)) {
					paramMap.put(key, tempMap.get(key));
				}
			}
			
			// BIZPLAY_0411A 테이블에 모든 결재건 적재
			aprvMngDAO.insertBizplayData(paramMap);
			
			// BIZPLAY_0411A_FILE 테이블에 결재건에 대한 첨부파일들 등록
			aprvMngDAO.deleteBizplayFile(paramMap);
			JSONArray fileList = (JSONArray) tempMap.get("ATT_IMG_LIST");
			for(int j = 0; j < fileList.size(); j++) {
				Map tempMap2 = (Map) fileList.get(j);
				paramMap.put("IMG_SEQ_NO", tempMap2.get("IMG_SEQ_NO"));
				paramMap.put("REG_DTM", tempMap2.get("REG_DTM"));
				paramMap.put("RCPT_IMG_URL", tempMap2.get("RCPT_IMG_URL"));
				paramMap.put("ORG_IMG_URL", tempMap2.get("ORG_IMG_URL"));
				
				aprvMngDAO.insertBizplayFile(paramMap);
			}
			
			
			// 모든 데이터 중 결재완료(9)인 데이터는 지출결의 완료 등록
			if(("9").equals(paramMap.get("APPR_STS"))) {
				// 저장될 데이터 정제 시작 
//				paramMap.put("REPT_APRV_NO", paramMap.get("USER_ID"));
				paramMap.put("REPT_APRV_NO", "msjo");
				paramMap.put("APRV_TYPE_CD", "CD0001007"); // 지출결의의 코드
				paramMap.put("APRV_TYPE_DTIL_CD", "CD000100700" + paramMap.get("CARD_TYPE")); // [법인은 1, 일반(개인)은 2, 송금은 3]
				
				String title = String.valueOf(paramMap.get("APV_DT")).substring(4, 6);
				title += "월_지출결의_" + "";
				title += (paramMap.get("CARD_TYPE").equals("1")) ? "법인_" : "개인_";
				title += String.valueOf(paramMap.get("SUMMARY")).substring(0, 2) + "_";
				title += paramMap.get("DRAFT_DATE");
				paramMap.put("TITLE", title);
				
				paramMap.put("PROJ_CD", paramMap.get("BIZ_UNIT_ERP_CD"));
				
				String date = String.valueOf(paramMap.get("DRAFT_DATE"));
				String convertDate = date.substring(0, 4) + "-" + date.substring(4, 6) + "-" + date.substring(6, 8);
				paramMap.put("TERM_ST_YM", convertDate);
				paramMap.put("TERM_ED_YM", convertDate);

				paramMap.put("REPT_CONT", paramMap.get("APPR_CONT"));
				paramMap.put("HALF_TYPE_CD", "0");
//				paramMap.put("PLACE", "-");
				// 저장될 데이터 정제 끝
				
				aprvMngDAO.insertBizplayAprv(paramMap);
				
				// 결재 대상(결재 라인) 등록
				JSONArray aprvLineArray = (JSONArray) tempMap.get("CD_PPP_APPR_REC");
				aprvMngDAO.deleteBizplayAprvLine(paramMap);	// 결재라인 지우기
				for (int j = 0; j < aprvLineArray.size(); j++) {
					// 결재라인 맵 초기화
					Map aprvLineMap = (Map) aprvLineArray.get(j);
					
					aprvLineMap.put("PPP_APPR_SEQ_NO", paramMap.get("PPP_APPR_SEQ_NO"));
					aprvLineMap.put("APRV_NO", paramMap.get("APRV_NO"));
					aprvLineMap.put("APRV_ORDR", Integer.parseInt((String) aprvLineMap.get("APPV_SEQ_NO")) + 1);
					aprvLineMap.put("APRV_YN_CD", 1);
//					aprvLineMap.put("CRTN_EMP_NO", paramMap.get("USER_ID"));
					aprvLineMap.put("CRTN_EMP_NO", "msjo");
					aprvLineMap.put("CRTN_DT", paramMap.get("DRAFT_DATE"));
					aprvLineMap.put("MODI_DT", aprvLineMap.get("APRV_DATE"));
					aprvLineMap.put("REFE_YN", 'N');
					aprvLineMap.put("CONF_YN", 'Y');
					
					aprvMngDAO.insertBizplayAprvLine(aprvLineMap);	// 결재라인 등록
				}
				
			}
		}
		return null;
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

}
