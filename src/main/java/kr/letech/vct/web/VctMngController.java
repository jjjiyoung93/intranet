package kr.letech.vct.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.letech.aprv.service.AprvMngService;
import kr.letech.cmm.LoginVO;
import kr.letech.cmm.util.ReqUtils;
import kr.letech.cmm.util.VarConsts;
import kr.letech.sys.cdm.service.CodeMngService;
import kr.letech.sys.rol.service.RoleMngService;
import kr.letech.uss.umt.service.impl.UssMngDAO;
import kr.letech.vct.service.VctMngService;

@Controller
public class VctMngController {
	
	/** vctMngService */
	@Resource(name = "vctMngService")
	private VctMngService vctMngService;
	
	/**
	 * 코드 데이터를 조회위한 서비스
	 */
	@Resource(name = "codeMngService")
	private CodeMngService codeMngService;
	
	/** 권한 관련 */
	@Resource(name = "roleMngService")
	private RoleMngService roleMngService;
	
	/** 결재 관련 */
	@Resource(name = "aprvMngService")
	private AprvMngService aprvMngService;
	
	/** ussMngDAO */
	@Resource(name="ussMngDAO")
	private UssMngDAO ussMngDAO;
	
	/**
	 * 휴가부여일수 조회
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "sys/vct/vctDay00List.do")
	public String getVctDayList(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		// searchGubun2 파라미터 값이 없으면 기본값으로 빈 값 추가
		if(StringUtils.isEmpty((String)params.get("searchGubun2"))) {
			params.put("searchGubun2", "");
		}
		
		//목록 및 총건수, 페이징
		Map vctDayObject = vctMngService.getVctDayPageingList(params);
		
		
		model.addAttribute("cPage", vctDayObject.get("cPage"));					// 페이지수
		model.addAttribute("totalCnt", vctDayObject.get("totalCnt"));				// 총건수
		model.addAttribute("intListCnt", vctDayObject.get("intListCnt"));			// 시작페이지 수
		model.addAttribute("resultList", vctDayObject.get("resultList"));			// 목록정보
		model.addAttribute("pageNavigator", vctDayObject.get("pageNavigator"));	// 페이징
		model.addAttribute("params", params);
		
		
		
		
		return "letech/vct/day/vctDay00List";
	}

	@RequestMapping(value = "sys/vct/vct00Tran.do")
	public String tran(HttpServletRequest request, ModelMap model) throws Exception {
		Map params = ReqUtils.getParameterMap(request);
		List<Map> vctMapList = new ArrayList<Map>();
		
		Set  keySet =  params.keySet();
		Iterator itr = keySet.iterator();
		String key = null;
		String ussId = null;
		String stddYr = (String)params.get("searchGubun2");
		while(itr.hasNext()) {
			key = itr.next().toString();
			if(StringUtils.contains(key, "vct_grnt_day")) {
				int separIdx = key.indexOf("-");
				ussId = StringUtils.substring(key, separIdx+1);
				Map vctMap = new HashMap();
				vctMap.put("uss_id", ussId);
				vctMap.put("vct_grnt_day", Integer.valueOf((String)params.get(key)));
				vctMap.put("stdd_yr", stddYr);
				vctMapList.add(vctMap);
			}
		}
		params.put("vctMapList", vctMapList);
		
		int resultCnt = 0;
		String msg = null;
		try {
			resultCnt = vctMngService.mergeVctDay(params);
			msg = "0000";
			
		} catch (Exception e) {
			msg = "9999";
		}

		model.addAttribute("resultCnt", resultCnt);
		model.addAttribute("resultMsg", msg);
		model.addAttribute("params", params);
		
		return "letech/vct/day/vctDay00Tran";
	}
	
	/**
	 * 휴가현황조회 목록 조회
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "vct/vctInf00List.do")
	public String getVctInfList(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		// searchGubun2 파라미터 값이 없으면 기본값으로 빈 값 추가
		if(StringUtils.isEmpty((String)params.get("searchGubun2"))) {
			Date now = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy");
			String yearStr = formatter.format(now);
			params.put("searchGubun2", yearStr);
		}
		
		HttpSession session =  request.getSession();
		LoginVO loginVO = (LoginVO)session.getAttribute("loginVO");
		String auth_cd = loginVO.getAuthCd();
		
		//접속자가 관리자 권한이 없는 경우
		if(!StringUtils.equals("ROLE_ADMIN", auth_cd)) {
			params.put("uss_id", loginVO.getId());
			Map user =  ussMngDAO.getUssView(params);
			params.put("uss_nm", user.get("USS_NM"));
		}else {
			//접속자가 관리자 권한이 있는 경우
			//목록 및 총건수, 페이징
			Map vctDayObject = vctMngService.getVctInfPageingList(params);
			
			
			model.addAttribute("cPage", vctDayObject.get("cPage"));					// 페이지수
			model.addAttribute("totalCnt", vctDayObject.get("totalCnt"));				// 총건수
			model.addAttribute("intListCnt", vctDayObject.get("intListCnt"));			// 시작페이지 수
			model.addAttribute("resultList", vctDayObject.get("resultList"));			// 목록정보
			//model.addAttribute("pageNavigator", vctDayObject.get("pageNavigator"));	// 페이징
			
			//고용구분 코드 목록 조회
			params.put("up_cd", (String)VarConsts.EMP_TYPE_CODE);
			List empTypeList = codeMngService.getCodeList(params);
			model.addAttribute("empTypeList", empTypeList);
			
			//직급(권한) 코드 목록 조회
			List authList = roleMngService.getAuthList(params);
			model.addAttribute("authList", authList);
			
			//프로젝트 목록 조회
			params.put("up_cd", VarConsts.EAM_PROJECT_CODE); // 프로젝트코드
			List projList = codeMngService.getCodeList(params);
			model.addAttribute("projList", projList);
			
		}
		
		model.addAttribute("params", params);
		
		
		
		return "letech/vct/inf/vctInf00List";
	}
	
	/**
	 * 휴가현황조회 상세 조회
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value =  "vct/vct00View.do")
	public String getVctDtilView(HttpServletRequest request, ModelMap model) throws Exception {
		Map params = ReqUtils.getParameterMap(request);
		
		String viewName = "jsonView";
		
		List resultList = vctMngService.getVctViewList(params);
		model.addAttribute("params", params);
		model.addAttribute("resultList", resultList);
		return viewName;
	}
	
	/**
	 * 휴가현황조회 상세보기 팝업 조회
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/vct/vct00Popup.do")
	public String getVctPopup(HttpServletRequest request, ModelMap model) throws Exception {
		Map params = ReqUtils.getParameterMap(request);
		//파라미터 - 기준년도, 사용자
		
		//결재 리스트 정보 가져올 것
		// 목록 및 총건수, 페이징 
		Map bbsObject = aprvMngService.getAprvPageingList(params);
		
		model.addAttribute("cPage", bbsObject.get("cPage"));					// 페이지수
		model.addAttribute("totalCnt", bbsObject.get("totalCnt"));				// 총건수
		model.addAttribute("intListCnt", bbsObject.get("intListCnt"));			// 시작페이지 수
		model.addAttribute("resultList", bbsObject.get("resultList"));			// 목록정보
		model.addAttribute("pageNavigator", bbsObject.get("pageNavigator"));	// 페이징
		model.addAttribute("params", params);
			
		
		params.put("up_cd", VarConsts.EAM_VACATION_CODE);
		List vctTypeList = codeMngService.getCodeList(params);
		model.addAttribute("vctTypeList", vctTypeList);
		
		return "letech/vct/inf/vctInf00Popup";
	}
	
	/**
	 * 휴가현황조회 상세보기 결재문서 조회
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/vct/vct00PopupDtil.do")
	public String getVctPopupDtil(HttpServletRequest request, ModelMap model) throws Exception {
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
		
		return "letech/vct/inf/vctInf00Dtil";
	}
	
	/**
	 * 휴가현황집계 목록 조회
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "sys/vct/vctStat00List.do")
	public String getVctStatList(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		// searchGubun2 파라미터 값이 없으면 기본값으로 빈 값 추가
		if(StringUtils.isEmpty((String)params.get("searchGubun2"))) {
			params.put("searchGubun2", "");
		}
		
		//목록 및 총건수, 페이징
		Map vctDayObject = vctMngService.getVctStatPageingList(params);
		
		
		model.addAttribute("cPage", vctDayObject.get("cPage"));					// 페이지수
		model.addAttribute("totalCnt", vctDayObject.get("totalCnt"));				// 총건수
		model.addAttribute("intListCnt", vctDayObject.get("intListCnt"));			// 시작페이지 수
		model.addAttribute("resultList", vctDayObject.get("resultList"));			// 목록정보
		//model.addAttribute("pageNavigator", vctDayObject.get("pageNavigator"));	// 페이징
		model.addAttribute("params", params);
		
		//고용구분 코드 목록 조회
		params.put("up_cd", (String)VarConsts.EMP_TYPE_CODE);
		List empTypeList = codeMngService.getCodeList(params);
		model.addAttribute("empTypeList", empTypeList);
		
		//직급(권한) 코드 목록 조회
		List authList = roleMngService.getAuthList(params);
		model.addAttribute("authList", authList);
		
		//프로젝트 목록 조회
		params.put("up_cd", VarConsts.EAM_PROJECT_CODE); // 프로젝트코드
		List projList = codeMngService.getCodeList(params);
		model.addAttribute("projList", projList);
		
		//휴가구분 목록 조회
		params.put("up_cd", VarConsts.EAM_VACATION_CODE); // 휴가구분코드
		List vctTypeList = codeMngService.getCodeList(params);
		model.addAttribute("vctTypeList", vctTypeList);
		
		
		return "letech/vct/stat/vctStat00List";
	}
	
	/**
	 * 휴가현황 엑셀 조회
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "vct/vctInf00Excl.do")
	public String getVctInfExclList(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		String viewName = "jsonView";
		
		// searchGubun2 파라미터 값이 없으면 기본값으로 빈 값 추가
		if(StringUtils.isEmpty((String)params.get("searchGubun2"))) {
			params.put("searchGubun2", "");
		}
		
		//목록 및 총건수, 페이징
		Map vctDayObject = vctMngService.getVctStatPageingList(params);
		
		params.put("up_cd", VarConsts.EAM_VACATION_CODE); // 휴가구분코드
		List vctTypeList = codeMngService.getCodeList(params);
		model.addAttribute("vctTypeList", vctTypeList);
		
		model.addAttribute("params", params);
		model.addAttribute("map", vctDayObject);
		//model.addAttribute("resultList", resultList);
		
		
		return viewName;
	}
}
