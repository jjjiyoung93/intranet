package kr.letech.aprv.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.letech.app.service.AppPushService;
import kr.letech.aprv.service.AprvMngService;
import kr.letech.cal.service.impl.CalMngDAO;
import kr.letech.cmm.util.EgovFileTool;
import kr.letech.cmm.util.ObjToConvert;
import kr.letech.cmm.util.PageNavigator;
import kr.letech.cmm.util.ReqUtils;
import kr.letech.cmm.util.VarConsts;
import kr.letech.sys.cdm.service.impl.CodeMngDAO;

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
			
			calAprvMap.put("cal_content", calAprvMap.get("cal_nm"));
			calAprvMap.put("cal_st_dt", params.get("term_st_ym"));
			calAprvMap.put("cal_ed_dt", params.get("term_ed_ym"));
			calAprvMap.put("uss_id", params.get("rept_aprv_no"));
			
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
//		if(procResultVal > 0) {
//			calMngDAO.calDelete(params);
//		}
//		
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
}
