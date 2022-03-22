package kr.letech.sys.cdm.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.letech.cmm.annotation.IncludedInfo;
import kr.letech.cmm.util.ReqUtils;
import kr.letech.cmm.util.VarConsts;
import kr.letech.sys.cdm.service.CodeMngService;

/**
 * 코드 관리
 * @author jwchoi
 *
 */
@Controller
public class CodeMngController {
	
	@Resource(name = "codeMngService")
	private CodeMngService codeMngService;
	
	
	/**
	 * 코드조회
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
//	@IncludedInfo(name = "코드관리", order = 470, gid = 50)
//	@RequestMapping(value = "/sys/cdm/list.do")
//	public String getList(HttpServletRequest request, ModelMap model) throws Exception {
//		
//		Map params = ReqUtils.getParameterMap(request);
//		
//		//1depth
//		String up_cd = (String)params.get("up_cd");
//		//2depth
//		String up_cd2 = (String)params.get("up_cd2");
//		//3depth
//		String up_cd3 = (String)params.get("up_cd3");
//		
//		//상위코드 목록
//		List highList = codeMngService.getOneCodeList(params);
//		
//		List lowList  = new ArrayList();
//		List lowList2 = new ArrayList();
//		List lowList3 = new ArrayList();
//		
//		if("3dep".equals((String)params.get("m_cd"))){
//			
//			params.put("up_cd", up_cd);
//			lowList = codeMngService.getCodeList(params);
//			
//			params.put("up_cd", up_cd2);
//			lowList2 = codeMngService.getCodeList(params);
//		
//		}else if("4dep".equals((String)params.get("m_cd"))){
//			params.put("up_cd", up_cd);
//			lowList2 = codeMngService.getCodeList(params);
//			
//			params.put("up_cd", up_cd2);
//			lowList = codeMngService.getCodeList(params);
//			
//			params.put("up_cd", up_cd3);
//			lowList3 = codeMngService.getCodeList(params);
//			
//		}else{
//			lowList = codeMngService.getCodeList(params);
//		}
//		//하위코드 목록
//		
//		model.addAttribute("highList", highList);
//		model.addAttribute("lowList", lowList);
//		model.addAttribute("lowList2", lowList2);
//		model.addAttribute("lowList3", lowList3);
//		model.addAttribute("params", params);
//		
//
//		return "letech/sys/cdm/list";
//	}
	
	/**
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 * @Method : getList
	 * @Author : KIM JI YOUNG
	 * @Date   : 2022.03.21
	 */
	@RequestMapping(value = "/sys/cdm/list.do")
	public String getList(HttpServletRequest request, ModelMap model) throws Exception {
		
		return "letech/sys/cdm/cmd01List";
	}
	
	/**
	 * 코드 전체 조회
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 * @Method : getCdList
	 * @Author : KIM JI YOUNG
	 * @Date   : 2022.03.21
	 */
	@RequestMapping(value= "/sys/cdm/jstreeList.do")
	public String getCdList(ModelMap model) throws Exception{
		
		List codeList = codeMngService.getAllCodeList();
		
		System.out.println("????"+codeList);
		model.addAttribute("codeList", codeList);
		
		return "jsonView";
	}
	
	/**
	 * 코드 상세보기 폼
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 * @Method : codeForm
	 * @Author : KIM JI YOUNG
	 * @Date   : 2022.03.21
	 */
	@RequestMapping(value="/sys/cdm/getCodeForm.do")
	public String codeForm(HttpServletRequest request, ModelMap model) throws Exception{
		
		Map params = ReqUtils.getParameterMap(request);
		
		Map getCodeView = codeMngService.getCodeView(params);
		model.addAttribute("getCodeView", getCodeView);
		model.addAttribute("params", params);
		
		return "letech/sys/cdm/code01Form";
	}
	/**
	 * 코드 등록폼
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/cdm/form.do")
	public String form(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		Map getCodeView = codeMngService.getCodeView(params);
		model.addAttribute("getCodeView", getCodeView);
		model.addAttribute("params", params);
		
		return "letech/sys/cdm/form";
	}
	
	/**
	 * 코드등록
	 * @param request
	 * @param model
	 * @return 성공결과 json
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/cdm/tran.do")
	public String tran(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		model.addAttribute("params", params);
		
		String mode = (String)params.get("mode");
		String viewName = "jsonView";
		
		if(mode.equals(VarConsts.MODE_I)){	/* 코드추가 */
			if("1".equals((String)params.get("flag"))){
				params.put("levl", 1);
				params.put("up_cd", "CD0000");
				params.put("cd_ord", 1);
				codeMngService.insert(params);	/* 상위코드추가 */
			}else{
				Map getCodeView = codeMngService.getCodeView(params);
				Map getMaxOrdr = codeMngService.getMaxOrdr(params);	/* 정렬최대값 */
				try{
					if(getMaxOrdr == null){
						params.put("cd_ord", "1");
					}else{
						int max_ordr = Integer.parseInt((String)getMaxOrdr.get("MAX_ORDR"));
						params.put("cd_ord", max_ordr+1);
					}
					
				}catch(Exception e){
					e.getMessage();
					throw new Exception(e.getMessage());
				}
				/* 상위코드정보 */
				if(getCodeView != null){
					int cd_levl = Integer.parseInt((String)getCodeView.get("LEVL"));
					params.put("up_cd", (String)getCodeView.get("CD"));
					params.put("levl", cd_levl+1);
				}
				codeMngService.insertLow(params);	/* 하위코드추가 */
			}
		}else if(mode.equals(VarConsts.MODE_U)){		 /* 코드수정 */
			codeMngService.updateNm(params);
		}else if(mode.equals(VarConsts.MODE_D)){		/* 하위코드삭제 */
			codeMngService.delete(params);	
			viewName = "redirect:/sys/cdm/list.do";
		}else if(mode.equals(VarConsts.MODE_DA)){	
			codeMngService.delete(params);		/* 상위코드삭제 */	
			codeMngService.deleteAll(params);	/* 하위코드전체삭제 */
			viewName = "redirect:/sys/cdm/list.do";
		}
		
		return viewName;
	}
	
	/**
	 * 코드 리스트 반환
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/cdm/getCodeList.do")
	public String getCodeList(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		String up_cd = (String)params.get("cd");
		String cd_val = (String)params.get("cd_val");
				
		Map pamMap = new HashMap<String, String>();
		pamMap.put("up_cd", up_cd);
		pamMap.put("cd_val", cd_val);
		
		List codeList = codeMngService.getCodeList(pamMap);
		System.out.println("codelist : "+ codeList.toString());
		model.addAttribute("codeList", codeList);
		
		return "jsonView";
	}
	
	
	/**
	 * 코드 상세 반환
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/cdm/getCode.do")
	public String getCode(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		Map getCodeView = codeMngService.getCodeView(params);
		model.addAttribute("getCodeView", getCodeView);
		model.addAttribute("params", params);
		
		return "jsonView";
	}
	
	/**
	 * 코드 상세 반환
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@RequestMapping(value = "/option/getCode.do")
	public String getCodeOption(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		Map getCodeView = codeMngService.getCodeView(params);
		model.addAttribute("getCodeView", getCodeView);
		model.addAttribute("params", params);
		
		return "jsonView";
	}
	

	
	/**
	 * 코드 리스트 반환
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@RequestMapping(value = "/option/getCodeList.do")
	public String getCodeListOption(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		String up_cd = (String)params.get("cd");
		String cd_val = (String)params.get("cd_val");
				
		Map pamMap = new HashMap<String, String>();
		pamMap.put("up_cd", up_cd);
		pamMap.put("cd_val", cd_val);
		
		List codeList = codeMngService.getCodeList(pamMap);
		model.addAttribute("codeList", codeList);
		
		return "jsonView";
	}
	
}
