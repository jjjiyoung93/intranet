package kr.letech.uss.umt.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.letech.aprv.service.AprvMngService;
import kr.letech.cmm.annotation.IncludedInfo;
import kr.letech.cmm.util.ObjToConvert;
import kr.letech.cmm.util.ReqUtils;
import kr.letech.cmm.util.VarConsts;
import kr.letech.sys.cdm.service.CodeMngService;
import kr.letech.sys.rol.service.RoleMngService;
import kr.letech.uss.umt.service.UssMngService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UssMngController {

	/** ussMngService */
	@Resource(name = "ussMngService")
	private UssMngService ussMngService;
	
	/** 권한 관련 */
	@Resource(name = "roleMngService")
	private RoleMngService roleMngService;
	
	@Resource(name = "aprvMngService")
	private AprvMngService aprvMngService;
	
	/**
	 * 코드 데이터를 조회위한 서비스
	 */
	@Resource(name = "codeMngService")
	private CodeMngService codeMngService;
	
	@IncludedInfo(name = "사용자관리", order = 470, gid = 50)
	@RequestMapping(value = "/uss/umt/uss00List.do")
	public String getUssList(HttpServletRequest request, ModelMap model) throws Exception {

		Map params = ReqUtils.getParameterMap(request);

		// 목록 및 총건수, 페이징 
		Map bbsObject = ussMngService.getUssPageingList(params);
		
		model.addAttribute("cPage", bbsObject.get("cPage"));					// 페이지수
		model.addAttribute("totalCnt", bbsObject.get("totalCnt"));				// 총건수
		model.addAttribute("intListCnt", bbsObject.get("intListCnt"));			// 시작페이지 수
		model.addAttribute("resultList", bbsObject.get("resultList"));			// 목록정보
		model.addAttribute("pageNavigator", bbsObject.get("pageNavigator"));	// 페이징
		model.addAttribute("params", params);
		
		return "letech/uss/umt/uss00List";
	}
	
	/**
	 * ID 중복체크
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/umt/uss00Ajax.do")
	public String idCheckRepetition(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		model.addAttribute("params", params);
		String viewName = "jsonView";
		
		String id_check = ussMngService.checkRepetition(params);
		
		model.addAttribute("id_check", id_check);
		
		return viewName;
	}
	
	/**
	 * 사원번호 중복체크
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/umt/uss01Ajax.do")
	public String emNoCheckRepetition(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		model.addAttribute("params", params);
		String viewName = "jsonView";
		
		String emno_check = ussMngService.emNoCheckRepetition(params);
		
		model.addAttribute("emno_check", emno_check);
		
		return viewName;
	}

	/**
	 * 등록, 수정 폼
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/umt/uss00Form.do")
	public String insertFrom(HttpServletRequest request, ModelMap model) throws Exception {
		Map params = ReqUtils.getParameterMap(request);
		model.addAttribute("params", params);
		
		String mode = params.get("mode")==null?"":(String)params.get("mode");
		// 수정일경우
		if(mode.equals(VarConsts.MODE_U)){
			Map resultView = ussMngService.getUssView(params);
			model.addAttribute("resultView", resultView);
		}

		List authList = roleMngService.getAuthList(params);
		model.addAttribute("authList", authList);
		
		// 부서목록
		List departList = ussMngService.getUssDepartList(params);
		model.addAttribute("departList", departList);
		
		/* 결재 라인 정보 조회 */
		List lineInfoList = aprvMngService.aprvLineInfoList(params);
		model.addAttribute("lineInfoList", lineInfoList);
		
		return "letech/uss/umt/uss00Form";
	}
	
	/**
	 * 등록, 수정, 삭제 기능
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/umt/uss00Tran.do")
	public String tran(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		model.addAttribute("params", params);
		
		String mode = (String)params.get("mode");
		String viewName = "jsonView";
		
		if(mode.equals(VarConsts.MODE_D)){
			/* 사용자 삭제 */
			ussMngService.ussDelete(params);
		}else{
			// 전화번호 합치기
			String uss_tel1 = params.get("uss_tel1")==null?"":(String)params.get("uss_tel1");
			String uss_tel2 = params.get("uss_tel2")==null?"":(String)params.get("uss_tel2");
			String uss_tel3 = params.get("uss_tel3")==null?"":(String)params.get("uss_tel3");
			
			if(!uss_tel1.equals("") && !uss_tel2.equals("") && !uss_tel1.equals("")){
				params.put("uss_tel", uss_tel1+"-"+uss_tel2+"-"+uss_tel3);
			}
			
			if(mode.equals(VarConsts.MODE_I)){	
			/* 사용자 등록 */
				ussMngService.ussInsert(params);
			}else if(mode.equals(VarConsts.MODE_U)){
			/* 사용자 수정 */
				ussMngService.ussUpdate(params);
			}
		}
		
		return viewName;
//		return "letech/uss/umt/uss00tran";
	}
	
	/**
	 * 상세조회 화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/umt/uss00View.do")
	public String getUssView(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		model.addAttribute("params", params);
		
		Map resultView = ussMngService.getUssView(params);
		
		model.addAttribute("resultView", resultView);
		
		return "letech/uss/umt/uss00View";
	}

	/**
	 * 회원가입 폼
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/umt/uss02Form.do")
	public String joinFrom(HttpServletRequest request, ModelMap model) throws Exception {

		Map params = ReqUtils.getParameterMap(request);
		model.addAttribute("params", params);
		
		model.addAttribute("joinType", "Y");
		return "letech/uss/umt/uss00Form";
	}
	
	/**
	 * 사용자 검색 팝업
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/search/uss00Popup.do")
	public String getUssSearch(HttpServletRequest request, ModelMap model) throws Exception {

		Map params = ReqUtils.getParameterMap(request);

		// 목록 및 총건수, 페이징 
		Map bbsObject = ussMngService.getUssPageingListPopup(params);
		
		model.addAttribute("cPage", bbsObject.get("cPage"));					// 페이지수
		model.addAttribute("totalCnt", bbsObject.get("totalCnt"));				// 총건수
		model.addAttribute("intListCnt", bbsObject.get("intListCnt"));			// 시작페이지 수
		model.addAttribute("resultList", bbsObject.get("resultList"));			// 목록정보
		model.addAttribute("pageNavigator", bbsObject.get("pageNavigator"));	// 페이징
		model.addAttribute("params", params);
		
		return "letech/uss/umt/uss00Popup";
	}
}
