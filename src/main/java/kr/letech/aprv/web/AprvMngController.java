package kr.letech.aprv.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.letech.aprv.TmpPayItemListVO;
import kr.letech.aprv.TmpPayItemVO;
import kr.letech.aprv.service.AprvMngService;
import kr.letech.cmm.LoginVO;
import kr.letech.cmm.annotation.IncludedInfo;
import kr.letech.cmm.util.DateUtil;
import kr.letech.cmm.util.EgovFileMngUtil;
import kr.letech.cmm.util.ReqUtils;
import kr.letech.cmm.util.VarConsts;
import kr.letech.doc.service.DocService;
import kr.letech.sys.cdm.service.CodeMngService;
import kr.letech.sys.mail.service.MailAprvService;
import kr.letech.uss.umt.service.impl.UssMngDAO;
import net.sf.json.JSONObject;

@Controller
public class AprvMngController {

	/** calMngService */
	@Resource(name = "aprvMngService")
	private AprvMngService aprvMngService;
	
	/**
	 * 코드 데이터를 조회위한 서비스
	 */
	@Resource(name = "codeMngService")
	private CodeMngService codeMngService;
	
	/** 파일 업로드 */
    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;
    
    /* 메일 발송을 위한 서비스 */
	@Resource(name="mailAprvService")
	private MailAprvService mailAprvService;
	
	/** ussMngDAO */
	@Resource(name="ussMngDAO")
	private UssMngDAO ussMngDAO;
	
	@Resource(name="docService")
	private DocService docService;

	/**
	 * 결재관리 화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@IncludedInfo(name = "결재관리", order = 470, gid = 50)
	@RequestMapping(value = "/aprv/aprv00List.do")
	public String getAprvList(HttpServletRequest request, ModelMap model) throws Exception {

		Map params = ReqUtils.getParameterMap(request);

		// 사용자 정보 넣기
		HttpSession session = request.getSession();
		LoginVO loginVO = (LoginVO) session.getAttribute("loginVO");
		params.put("uss_id", loginVO.getId());
		
		Map ussView = ussMngDAO.getUssView(params);
		params.put("uss_auth_cd", ussView.get("USS_AUTH_CD"));
		
		// 상태 검색 코드 추가
		String searchCdList3 = null;
		if (params.get("searchCdList3") != null) {
			searchCdList3 = String.valueOf(params.get("searchCdList3"));
			params.put("searchCdList3", searchCdList3);
		}
		
		// admin일 경우 default로 반려 리스트 출력
		if(ussView.get("USS_AUTH_CD").equals("ROLE_ADMIN") && searchCdList3 == null) {
			params.put("searchCdList3", "3");
		}

		// 목록 및 총건수, 페이징 
		Map bbsObject = aprvMngService.getAprvPageingList(params);
		
		model.addAttribute("cPage", bbsObject.get("cPage"));					// 페이지수
		model.addAttribute("totalCnt", bbsObject.get("totalCnt"));				// 총건수
		model.addAttribute("intListCnt", bbsObject.get("intListCnt"));			// 시작페이지 수
		model.addAttribute("resultList", bbsObject.get("resultList"));			// 목록정보
		model.addAttribute("pageNavigator", bbsObject.get("pageNavigator"));	// 페이징
		model.addAttribute("params", params);
		
		/*코드리스트 조회를 위한 상위코드입력*/
		params.put("up_cd", VarConsts.EAM_MASTER_CODE);
		List codeList = codeMngService.getCodeList(params);
		model.addAttribute("codeList", codeList);
		
		//소속 리스트 가져오기
		params.put("code", VarConsts.DP_CODE);
		params.put("up_cd", VarConsts.DP_CODE);
		List dpList = codeMngService.getCodeList(params);
		model.addAttribute("dpList", dpList);
		
		// 현재 날짜 구하기
		DateUtil dt = new DateUtil();
		model.addAttribute("now_date", dt.nowDate());
		
		return "letech/aprv/aprv00List";
	}
	
	/**
	 * 결재 정보 조회
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/aprv/aprv00View.do")
	public String getAprvView(HttpServletRequest request, ModelMap model) throws Exception {
		Map params = ReqUtils.getParameterMap(request);

		// 사용자 정보 넣기
		HttpSession session = request.getSession();
		LoginVO loginVO = (LoginVO) session.getAttribute("loginVO");
		params.put("uss_id", loginVO.getId());
		
		// 권한 넣기
		Map ussView = ussMngDAO.getUssView(params);
		params.put("uss_auth_cd", ussView.get("USS_AUTH_CD"));

		model.addAttribute("params", params);

		params.put("aprv_emp_no", loginVO.getId());
		
		
		/* 상세 정보 조회 */
		Map viewMap = aprvMngService.getAprvView(params);
		/* 결재 라인 정보 조회 */
		List lineList = aprvMngService.aprvLineList(params);
		/* 결재 첨부파일정보 조회 */
		List fileList = aprvMngService.aprvFileList(params);
		/* 지출결의서 조회 */
		Map recMap = (Map) aprvMngService.getAprvRecList(params);
		
		model.addAttribute("viewMap", viewMap);
		model.addAttribute("lineList", lineList);
		model.addAttribute("fileList", fileList);
		model.addAttribute("recList", recMap.get("recList"));
		model.addAttribute("recFileList", recMap.get("recFileList"));
		

		/*코드리스트 조회를 위한 상위코드입력*/
		params.put("up_cd", VarConsts.EAM_MASTER_CODE);
		List codeList = codeMngService.getCodeList(params);
		model.addAttribute("codeList", codeList);
		
		params.put("up_cd", VarConsts.EAM_PROJECT_CODE);
		List projList = codeMngService.getCodeList(params);
		model.addAttribute("projList", projList);
		
		/*상세 코드리스트 조회를 위한 상위코드입력*/
		params.put("up_cd", viewMap.get("APRV_TYPE_CD"));
		List codeList2 = codeMngService.getCodeList(params);
		model.addAttribute("codeList2", codeList2);
		
		return "letech/aprv/aprv00View";
	}
	
	/**
	 * 결재 등록 및 수정 화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/aprv/aprv00Form.do")
	public String insertFrom(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		model.addAttribute("params", params);
		
		/*코드리스트 조회를 위한 상위코드입력*/
		params.put("up_cd", VarConsts.EAM_MASTER_CODE); // 결재상위코드
		List codeList = codeMngService.getCodeList(params);
		model.addAttribute("codeList", codeList);
		
		params.put("up_cd", VarConsts.EAM_PROJECT_CODE); // 프로젝트코드
		List projList = codeMngService.getCodeList(params);
		model.addAttribute("projList", projList);
		
		// 로그인한 사용자의 결재라인을 가져옴
		HttpSession session = request.getSession();
		LoginVO loginVO = (LoginVO) session.getAttribute("loginVO");
		params.put("EMP_NO", loginVO.getId());
		List lineInfoList = aprvMngService.aprvLineInfoList(params);
		model.addAttribute("lineInfoList", lineInfoList);
		
		// js 컴파일 에러 방지를 위해 update가 아닌 insert에는 빈값을 전송
		model.addAttribute("docJson", "{}");
		model.addAttribute("viewJson", "{}");
		
		Map viewMap = null;
		if (params.get("mode") != null && params.get("mode").equals(VarConsts.MODE_U)) {

			/* 상세 정보 조회 */
			viewMap = aprvMngService.getAprvView(params);
			/* 결재 라인 정보 조회 */
			List lineList = aprvMngService.aprvLineList(params);
			/* 결재 첨부파일정보 조회 */
			List fileList = aprvMngService.aprvFileList(params);
			
			String aprvTypeCd = (String)viewMap.get("APRV_TYPE_CD");
			
			//가지급금 목적 코드 로드
			params.put("up_cd", VarConsts.TMP_PAY_PRPS);
			List tmpPrpsList = codeMngService.getCodeList(params);
			model.addAttribute("tmpPrpsList", tmpPrpsList);
				
			model.addAttribute("viewMap", viewMap);
			model.addAttribute("lineList", lineList);
			model.addAttribute("fileList", fileList);
			
			/*상세 코드리스트 조회를 위한 상위코드입력*/
			params.put("up_cd", viewMap.get("APRV_TYPE_CD"));
			List codeList2 = codeMngService.getCodeList(params);
			model.addAttribute("codeList2", codeList2);
			
			/* 문서 데이터 조회 */
			Map docMap = docService.getDocData(viewMap);
			JSONObject docJson = JSONObject.fromObject(docMap);
			JSONObject viewJson = JSONObject.fromObject(viewMap);
			model.addAttribute("docJson", docJson);
			model.addAttribute("viewJson", viewJson);
		}
				
		return "letech/aprv/aprv00Form";
	}
	
	/**
	 * 삭제 기능
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/aprv/aprv01Tran.do")
	public String deleteTran(HttpServletRequest request, ModelMap model) throws Exception {
		
//		MultipartHttpServletRequest multipartRequest =  (MultipartHttpServletRequest)request;
//		Map params = ReqUtils.getParameterMap3(multipartRequest);

		Map params = ReqUtils.getParameterMap(request);
		
//		String mode = VarConsts.MODE_I;
//		if (params.get("mode") != null) {
//			mode = String.valueOf(params.get("mode"));
//		}
		
		String viewName = "jsonView";
		aprvMngService.aprvDelete(params);	// 결재정보 삭제
		
		//메일 발송 내용 등록
		//mailAprvService.aprvMailSendInsert(params);
		
		return viewName;
	}
	
	/**
	 * 등록 수정 삭제 기능 (Multipart, 파일 업로드시)
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/aprv/aprv00Tran.do")
	public String basicTran(final MultipartHttpServletRequest multiRequest, ModelMap model, HttpServletRequest request 
			, TmpPayItemListVO tmpPayItemList) throws Exception {
		
		Map params = ReqUtils.getParameterMap3(multiRequest);
		if(tmpPayItemList != null && !tmpPayItemList.getTmpPayItemList().isEmpty()) {
			params.put("tmpPayItemList", tmpPayItemList.getTmpPayItemList());
		}
		model.addAttribute("params", params);
		
		// 사용자 정보 넣기
		HttpSession session = request.getSession();
		LoginVO loginVO = (LoginVO) session.getAttribute("loginVO");
		params.put("aprv_nm", loginVO.getName());
		
		String mode = VarConsts.MODE_I;
		if (params.get("mode") != null) {
			mode = String.valueOf(params.get("mode"));
		}
		String errorMsg = "N";
		try{

			/* 첨부파일 정보 */
			List<Map<String, Object>> fileList = null;
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
		    if (!files.isEmpty()) {
		    	fileList = fileUtil.parseFileInf(files, "APRV_", 0, "aprv");
		    }
		    
			if(mode.equals(VarConsts.MODE_I)){
				int procResult = aprvMngService.aprvInsert(params, fileList);	// 결재정보 등록
				
				if (procResult > 0 ) {
					aprvMngService.aprvInsert2(params);	// push 등록
				}
			}else if(mode.equals(VarConsts.MODE_U)){
				aprvMngService.aprvUpdate(params, fileList);	// 결재정보 수정
			}
		}catch (Exception e){
			e.printStackTrace();
			errorMsg = "Y";
		}
		
		model.addAttribute("errorMsg", errorMsg);
		model.addAttribute("mode", mode);
		
		//메일 발송 내용 등록
		//mailAprvService.aprvMailSendInsert(params);
		
		return "letech/aprv/aprv00Tran";
	}
	

	/**
	 * 결재 승인(완료, 보류, 반려)
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/aprv/aprv02Tran.do")
	public String aprvOkTran(HttpServletRequest request, ModelMap model) throws Exception {

		Map params = ReqUtils.getParameterMap(request);
		
		String sAprvNo = String.valueOf(params.get("aprv_no"));
		String sAprvEmpNo = String.valueOf(params.get("aprv_emp_no"));
		
		String viewName = "jsonView";
		try {
			aprvMngService.aprvLineUpdate(params);	// 결재승인(완료, 보류, 반려)
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		params.put("aprv_no", sAprvNo);
		params.put("aprv_emp_no", sAprvEmpNo);
		
		//메일 발송 내용 등록
		//mailAprvService.aprvMailSendInsert(params);
		
		return viewName;
	}

	/**
	 * 첨부파일 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/aprv/aprv01Ajax.do")
	public String delFileAjax(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		String viewName = "jsonView";
		
		aprvMngService.aprvFileDelete(params);
		
		return viewName;
	}

	/**
	 * 결재기능 진행정보 조회
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/aprv/aprv02Ajax.do")
	public String aprvListInfo(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		String viewName = "jsonView";
		
		HttpSession session = request.getSession();
		LoginVO loginVO = (LoginVO) session.getAttribute("loginVO");

		params.put("aprv_up_cd", VarConsts.EAM_MASTER_CODE);
		params.put("uss_id", loginVO.getId());
		// 결재중
		params.put("aprv_yn_cd", "0");
		List aprvList0 = aprvMngService.layerAprvInfo(params);
		int aprvCount0 = aprvMngService.layerAprvInfoCount(params);
		// 보류
		params.put("aprv_yn_cd", "2");
		List aprvList2 = aprvMngService.layerAprvInfo(params);
		int aprvCount2 = aprvMngService.layerAprvInfoCount(params);
		// 반려
		params.put("aprv_yn_cd", "3");
		List aprvList3 = aprvMngService.layerAprvInfo(params);
		int aprvCount3 = aprvMngService.layerAprvInfoCount(params);
		
		model.addAttribute("aprvList0", aprvList0);
		model.addAttribute("aprvList2", aprvList2);
		model.addAttribute("aprvList3", aprvList3);
		model.addAttribute("aprvCount0", aprvCount0);
		model.addAttribute("aprvCount2", aprvCount2);
		model.addAttribute("aprvCount3", aprvCount3);
		
		return viewName;
	}
	
	/**
	 * 지역코드, 출장구분코드, 여비 불러오기
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "aprv/aprv03Ajax.do")
	public String getBztrpCodeList(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		model.addAttribute("params", params);
		
		HttpSession session = request.getSession();
		LoginVO loginVO = (LoginVO) session.getAttribute("loginVO");
		params.put("auth_cd", loginVO.getAuthCd());
		
		// 지역코드
		params.put("up_cd", VarConsts.PLC_CODE); // 결재상위코드
		List plcCodeList = codeMngService.getCodeList(params);
		model.addAttribute("plcCodeList", plcCodeList);
		// 출장구분코드
		if("CD0001009001".equals(params.get("cdList2"))) { // 법인 
			params.put("up_cd", VarConsts.BZTRP_DIV_CODE_CPR); // 결재상위코드
		} else if("CD0001009002".equals(params.get("cdList2"))) { // 일반
			params.put("up_cd", VarConsts.BZTRP_DIV_CODE_GNRL); // 결재상위코드
		}
		List bztrpDivCodeList = codeMngService.getCodeList(params);
		model.addAttribute("bztrpDivCodeList", bztrpDivCodeList);
		// 출장비
		List trcsList = aprvMngService.getTrcsList();
		model.addAttribute("trcsList", trcsList);
		// 여비
		List trvctInfo = aprvMngService.getTrvctInfo(params);
		model.addAttribute("trvctInfo", trvctInfo);
		
		return "jsonView";
	}
	
	/**
	* BIZPLAY API를 호출하여 받아온 데이터를 적재하고 결재완료된 건을 인트라넷에 추가
	* 작성자 : JO MIN SOO
	* @param request
	* @param model
	* @return
	* @throws Exception
	*/
	@RequestMapping(value = "/aprv/loadBizplay.do")
	public String loadBizplay(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		String viewName = "jsonView";

		// BIZPLAY 데이터 호출하여 DB에 저장
		aprvMngService.insertBizplayData(params);
		// 저장된 BIZPLAY 데이터를 이용하여 결재 데이터 생성
		aprvMngService.insertBizplayAprv(params);
		
		return viewName;
	}
}
