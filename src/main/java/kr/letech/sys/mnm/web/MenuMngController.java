package kr.letech.sys.mnm.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.letech.cmm.annotation.IncludedInfo;
import kr.letech.cmm.util.ReqUtils;
import kr.letech.cmm.util.VarConsts;
import kr.letech.sys.cdm.service.CodeMngService;
import kr.letech.sys.mnm.service.MenuMngService;

/**
 * 메뉴 관리
 * @author jwchoi
 *
 */
@Controller
public class MenuMngController {
	
	@Resource(name = "menuMngService")
	private MenuMngService menuMngService;
	
	/**
	 * 코드 데이터를 조회위한 서비스
	 */
	@Resource(name = "codeMngService")
	private CodeMngService codeMngService;
	
	
	/**
	 * 메뉴조회
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@IncludedInfo(name = "메뉴관리", order = 470, gid = 50)
	@RequestMapping(value = "/sys/mnm/mnm00List.do")
	public String getList(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		//1depth
		String up_mn = (String)params.get("up_mn");
		//2depth
		String up_mn2 = (String)params.get("up_mn2");
		//3depth
		String up_mn3 = (String)params.get("up_mn3");
		//상위코드 목록
		params.put("levl",1);
		List highList = menuMngService.getOneCodeList(params);
		
		List lowList  = new ArrayList();
		List lowList2 = new ArrayList();
		List lowList3 = new ArrayList();
		
		if("3dep".equals((String)params.get("m_mn"))){
			
			params.put("up_mn", up_mn);
			lowList = menuMngService.getCodeList(params);
			
			params.put("up_mn", up_mn2);
			lowList2 = menuMngService.getCodeList(params);
		
		}else if("4dep".equals((String)params.get("m_mn"))){
			params.put("up_mn", up_mn);
			lowList2 = menuMngService.getCodeList(params);
			
			params.put("up_mn", up_mn2);
			lowList = menuMngService.getCodeList(params);
			
			params.put("up_mn", up_mn3);
			lowList3 = menuMngService.getCodeList(params);
			
		}else{
			lowList = menuMngService.getCodeList(params);
		}
		//하위코드 목록
		
		model.addAttribute("highList", highList);
		model.addAttribute("lowList", lowList);
		model.addAttribute("lowList2", lowList2);
		model.addAttribute("lowList3", lowList3);
		model.addAttribute("params", params);
		

		return "letech/sys/mnm/mnm00List";
	}
	
	/**
	 * 메뉴 등록폼
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/sys/mnm/mnm00Form.do")
	public String form(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		Map getCodeView = menuMngService.getCodeView(params);
		model.addAttribute("getCodeView", getCodeView);
		model.addAttribute("params", params);
		
		/*코드리스트 조회를 위한 상위코드입력*/
		params.put("up_cd", VarConsts.SYS_MNMTYPE_CODE);
		List codeList = codeMngService.getCodeList(params);
		model.addAttribute("codeList", codeList);
		
		return "letech/sys/mnm/mnm00Form";
	}
	
	/**
	 * 코드등록
	 * @param request
	 * @param model
	 * @return 성공결과 json
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/mnm/mnm00Tran.do")
	public String tran(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		model.addAttribute("params", params);
		
		String mode = (String)params.get("mode");
		String viewName = "jsonView";
		
		if(mode.equals(VarConsts.MODE_I)){	/* 코드추가 */
			params.put("use_yn", "Y");
			if("1".equals((String)params.get("flag"))){
				params.put("levl", 1);
				params.put("up_mn", "MN0000");
				params.put("mn_ord", 1);
				menuMngService.insert(params);	/* 상위코드추가 */
			}else{
				Map getCodeView = menuMngService.getCodeView(params);
				Map getMaxOrdr = menuMngService.getMaxOrdr(params);	/* 정렬최대값 */
				try{
					if(getMaxOrdr == null){
						params.put("mn_ord", "1");
					}else{
						int max_ordr = Integer.parseInt((String)getMaxOrdr.get("MAX_ORDR"));
						params.put("mn_ord", max_ordr+1);
					}
					
				}catch(Exception e){
					e.getMessage();
					throw new Exception(e.getMessage());
				}
				/* 상위코드정보 */
				if(getCodeView != null){
					int cd_levl = Integer.parseInt((String)getCodeView.get("LEVL"));
					params.put("up_mn", (String)getCodeView.get("MN"));
					params.put("levl", cd_levl+1);
				}
				menuMngService.insert(params);	/* 하위코드추가 */
			}
		}else if(mode.equals(VarConsts.MODE_U)){		 /* 코드수정 */
			menuMngService.updateNm(params);
		}else if(mode.equals(VarConsts.MODE_D)){		/* 하위코드삭제 */
			menuMngService.delete(params);	
			viewName = "redirect:/sys/mnm/mnm00List.do";
		}else if(mode.equals(VarConsts.MODE_DA)){	
			menuMngService.delete(params);		/* 상위코드삭제 */	
			menuMngService.deleteAll(params);	/* 하위코드전체삭제 */
			viewName = "redirect:/sys/mnm/mnm00List.do";
		}
		
		
		return viewName;
	}
	
	/**
	 * Tree화면, 메뉴 Tree 목록화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/mnm/mnm01List.do")
	public String getTreeList(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		model.addAttribute("params", params);
		
		params.put("up_mn", "MN0000");
		List resultList = menuMngService.getMenuTreeList(params);
		
		model.addAttribute("resultList", resultList);

		/*코드리스트 조회를 위한 상위코드입력*/
		params.put("up_cd", VarConsts.SYS_MNMTYPE_CODE);
		List codeList = codeMngService.getCodeList(params);
		model.addAttribute("codeList", codeList);
		
		return "letech/sys/mnm/mnm01List";
	}
	
	/**
	 * Tree화면, 메뉴 상세정보 조회
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/sys/mnm/mnm00Ajax.do")
	public String treeViewAjax(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		String viewName = "jsonView";
		
		Map getCodeView = menuMngService.getCodeView(params);
		model.addAttribute("getCodeView", getCodeView);
		
		return viewName;
	}
	
	/**
	 * Tree화면, 메뉴 등록, 수정, 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/mnm/mnm01Tran.do")
	public String treeTran(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		model.addAttribute("params", params);
		
		String mode = (String)params.get("mode");
		String viewName = "jsonView";
		
		if(mode.equals(VarConsts.MODE_I)){	/* 코드추가 */
			params.put("use_yn", "Y");
			if("1".equals((String)params.get("flag"))){
				params.put("levl", 1);
				params.put("up_mn", "MN0000");
				params.put("mn_ord", 1);
				menuMngService.insert(params);	/* 상위메뉴추가 */
			}else{
				Map getCodeView = menuMngService.getCodeView(params);
				Map getMaxOrdr = menuMngService.getMaxOrdr(params);	/* 정렬최대값 */
				try{
					if(getMaxOrdr == null){
						params.put("mn_ord", "1");
					}else{
						int max_ordr = Integer.parseInt((String)getMaxOrdr.get("MAX_ORDR"));
						params.put("mn_ord", max_ordr+1);
					}
					
				}catch(Exception e){
					e.getMessage();
					throw new Exception(e.getMessage());
				}
				/* 상위코드정보 */
				if(getCodeView != null){
					int cd_levl = Integer.parseInt((String)getCodeView.get("LEVL"));
					params.put("up_mn", (String)getCodeView.get("MN"));
					params.put("levl", cd_levl+1);
				}
				menuMngService.insert(params);	/* 하위메뉴 추가 */
			}
		}else if(mode.equals(VarConsts.MODE_U)){		 /* 수정 */
			menuMngService.updateNm(params);
		}else if(mode.equals(VarConsts.MODE_D)){		/* 삭제 */
			menuMngService.mnAllDelete(params);	
		}
		
		return viewName;
	}
}
