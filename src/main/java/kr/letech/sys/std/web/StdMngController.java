package kr.letech.sys.std.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.letech.cmm.LoginVO;
import kr.letech.cmm.annotation.IncludedInfo;
import kr.letech.cmm.util.ObjToConvert;
import kr.letech.cmm.util.ReqUtils;
import kr.letech.cmm.util.VarConsts;
import kr.letech.sys.cdm.service.CodeMngService;
import kr.letech.sys.std.TrvctListVO;
import kr.letech.sys.std.service.StdMngService;

/**
 * 기준정보 관리
 * @author yhkim
 * @date 2021. 05. 06.
 */
@Controller
public class StdMngController {
	
	@Resource(name = "stdMngService")
	private StdMngService stdMngService;
	
	/**
	 * 코드 데이터를 조회위한 서비스
	 */
	@Resource(name = "codeMngService")
	private CodeMngService codeMngService;
	
	/**
	 * 여비정보 조회
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@IncludedInfo(name = "여비정보관리", order = 470, gid = 50)
	@RequestMapping(value = "/sys/std/std00List.do")
	public String std00List(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		List highList = stdMngService.get00List(params);
		
		model.addAttribute("highList", highList);
		model.addAttribute("params", params);

		return "letech/sys/std/std00List";
	}
	
	/**
	 * 여비정보 조회
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@IncludedInfo(name = "여비정보관리", order = 470, gid = 50)
	@RequestMapping(value = "/sys/std/std00Form.do")
	public String std00Form(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		
		/*게시판타입코드조회*/
		params.put("up_cd",VarConsts.TRVCT_GROUP);
		List codeList = codeMngService.getCodeList(params);
		

		if(ObjToConvert.isNotEmpty(params.get("group_cd"))){
			Map getView = stdMngService.getView(params);
			model.addAttribute("getView", getView);
		}
		
		model.addAttribute("groupCodeList", codeList);
		model.addAttribute("params", params);

		return "letech/sys/std/std00Form";
	}
	
	/**
	 * 여비정보 등록
	 * @param request
	 * @param model
	 * @return 성공결과 json
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/std/std00Tran.do")
	public String std00Tran(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		model.addAttribute("params", params);
		
		String mode = (String)params.get("mode");
		String viewName = "jsonView";
		HttpSession session = request.getSession();
		LoginVO loginVO = (LoginVO) session.getAttribute("loginVO");
		params.put("reg_id", loginVO.getId());
		if(mode.equals(VarConsts.MODE_I)){	/* 코드추가 */
			stdMngService.insertGrp(params);	/* 상위코드추가 */
		}else if(mode.equals(VarConsts.MODE_U)){		 /* 코드수정 */
			stdMngService.updateGrp(params);
		}else if(mode.equals(VarConsts.MODE_D)){		/* 하위코드삭제 */
			stdMngService.deleteGrp(params);
			viewName = "redirect:/sys/std/std00List.do";
		}
		
		return viewName;
	}
	
	/**
	 * 그룹별 급수 조회
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@IncludedInfo(name = "그룹별급수관리", order = 470, gid = 50)
	@RequestMapping(value = "/sys/std/std01List.do")
	public String std01List(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		List highList = stdMngService.get01List(params);
		
		model.addAttribute("highList", highList);
		model.addAttribute("params", params);
		
		return "letech/sys/std/std01List";
	}
	
	/**
	 * 그룹별급수 조회
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@IncludedInfo(name = "그룹별급수관리", order = 470, gid = 50)
	@RequestMapping(value = "/sys/std/std01Form.do")
	public String std01Form(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		
		/*권한그룹 조회*/
		params.put("author_code","ROLE_USER");
		List authorList = stdMngService.getAuthorList(params);
		/*급수 조회*/
		List groupList = stdMngService.get00List(params);
		
		if(ObjToConvert.isNotEmpty(params.get("aut_cd"))){
			Map getView = stdMngService.getView2(params);
			model.addAttribute("getView", getView);
		}
		
		model.addAttribute("authorCodeList", authorList);
		model.addAttribute("groupCodeList", groupList);
		model.addAttribute("params", params);
		
		return "letech/sys/std/std01Form";
	}
	
	/**
	 * 그룹별급수 등록
	 * @param request
	 * @param model
	 * @return 성공결과 json
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/std/std01Tran.do")
	public String std01Tran(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		
		String mode = (String)params.get("mode");
		String viewName = "jsonView";
		HttpSession session = request.getSession();
		LoginVO loginVO = (LoginVO) session.getAttribute("loginVO");
		params.put("reg_id", loginVO.getId());
		if(mode.equals(VarConsts.MODE_I)){	
			stdMngService.insertAut(params);	
		}else if(mode.equals(VarConsts.MODE_U)){		 
			stdMngService.updateAut(params);
		}else if(mode.equals(VarConsts.MODE_D)){		
			stdMngService.deleteAut(params);
			viewName = "redirect:/sys/std/std01List.do";
		}
		model.addAttribute("params", params);
		
		return viewName;
	}
	
	/**
	 * 교통비 조회
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@IncludedInfo(name = "교통비관리", order = 470, gid = 50)
	@RequestMapping(value = "/sys/std/std02List.do")
	public String std02List(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		params.put("up_cd", VarConsts.PLC_CODE);
		//List codeList = codeMngService.getCodeList(params);
		List codeList = stdMngService.getTrcsCdList(params);
		List highList = null;
		model.addAttribute("params", params);
		model.addAttribute("codeList", codeList);
		
		if(ObjToConvert.isNotEmpty(params.get("regnCd"))) {
			highList = stdMngService.get02List(params);
			model.addAttribute("highList", highList);
			return "jsonView";
		}
		
		return "letech/sys/std/std02List";
	}
	
	/**
	 * 교통비 조회
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@IncludedInfo(name = "교통비관리", order = 470, gid = 50)
	@RequestMapping(value = "/sys/std/std02Form.do")
	public String std02Form(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		String regnCd2 = (String)params.get("regn_cd2");
		params.put("up_cd", VarConsts.PLC_CODE);
		
		/*지역 조회*/
		//목록수정
		if(regnCd2 == null || "".equals(regnCd2)) {
			params.put("cd", params.get("regn_cd1"));
			params.put("regnCd", params.get("regn_cd1"));
			Map codeView = codeMngService.getCodeView(params);
			
			List highList = stdMngService.get02List(params);
			model.addAttribute("codeView", codeView);
			model.addAttribute("highList", highList);
			
			if(StringUtils.isNotEmpty((String)params.get("cd"))) {
				List addList = stdMngService.getAddList(params);
				model.addAttribute("addList", addList);
			}
				
		//개별수정
		}else if(!"".equals(regnCd2) && ObjToConvert.isNotEmpty(params.get("regn_cd1"))){
			Map getView = stdMngService.getView3(params);
			model.addAttribute("getView", getView);			
		}
		
		List regnList = codeMngService.getCodeList(params);
		
		
		
//		if(ObjToConvert.isNotEmpty(params.get("regn_cd1"))
//		 && ObjToConvert.isNotEmpty(params.get("regn_cd2"))){
//		}
		
		model.addAttribute("regnCodeList", regnList);
		model.addAttribute("params", params);
		
		return "letech/sys/std/std02Form";
	}
	
	/**
	 * 교통비 등록
	 * @param request
	 * @param model
	 * @return 성공결과 json
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/std/std02Tran.do")
	public String std02Tran(HttpServletRequest request, ModelMap model, TrvctListVO trcsList) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		if(trcsList != null && trcsList.getTrcsList() != null && !trcsList.getTrcsList().isEmpty()) {
			params.put("trcsList", trcsList.getTrcsList());
		}
		
		model.addAttribute("params", params);
		
		String mode = (String)params.get("mode");
		String viewName = "jsonView";
		HttpSession session = request.getSession();
		LoginVO loginVO = (LoginVO) session.getAttribute("loginVO");
		params.put("reg_id", loginVO.getId());
		if(mode.equals(VarConsts.MODE_I)){	/* 코드추가 */
			stdMngService.insertTrcs(params);	/* 상위코드추가 */
		}else if(mode.equals(VarConsts.MODE_U)){		 /* 코드수정 */
			stdMngService.updateTrcs(params);
		}else if(mode.equals(VarConsts.MODE_D)){		/* 하위코드삭제 */
			stdMngService.deleteTrcs(params);
			viewName = "redirect:/sys/std/std02List.do";
		}
		
		return viewName;
	}
	
	/**
	 * 중복 체크
	 * @param request
	 * @param model
	 * @return 성공결과 json
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/std/std02ovlap.do")
	public String std02Ovlap(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		model.addAttribute("params", params);
		
		String mode = (String)params.get("mode");
		String viewName = "jsonView";
		HttpSession session = request.getSession();
		LoginVO loginVO = (LoginVO) session.getAttribute("loginVO");
		params.put("reg_id", loginVO.getId());
		
		Map result = stdMngService.getRegnCnt(params);
		
		model.addAttribute("result", result);
		
		return "jsonView";
	}
	
	/**
	 * 중복 체크
	 * @param request
	 * @param model
	 * @return 성공결과 json
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/std/std01ovlap.do")
	public String std01Ovlap(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		model.addAttribute("params", params);
		
		String mode = (String)params.get("mode");
		String viewName = "jsonView";
		HttpSession session = request.getSession();
		LoginVO loginVO = (LoginVO) session.getAttribute("loginVO");
		params.put("reg_id", loginVO.getId());
		
		Map result = stdMngService.getCnt01(params);
		model.addAttribute("result", result);
		
		return "jsonView";
	}
	/**
	 * 중복 체크
	 * @param request
	 * @param model
	 * @return 성공결과 json
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/std/std00ovlap.do")
	public String std00Ovlap(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		model.addAttribute("params", params);
		
		String mode = (String)params.get("mode");
		String viewName = "jsonView";
		HttpSession session = request.getSession();
		LoginVO loginVO = (LoginVO) session.getAttribute("loginVO");
		params.put("reg_id", loginVO.getId());
		
		Map result = stdMngService.getCnt00(params);
		model.addAttribute("result", result);
		
		return "jsonView";
	}
	
}

