package kr.letech.sys.rol.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.letech.cmm.annotation.IncludedInfo;
import kr.letech.cmm.util.ObjToConvert;
import kr.letech.cmm.util.ReqUtils;
import kr.letech.cmm.util.VarConsts;
import kr.letech.sys.cdm.service.CodeMngService;
import kr.letech.sys.rol.service.RoleMngService;

/**
 * 권한 관리
 * @author jwchoi
 *
 */
@Controller
public class RoleMngController {
	
	@Resource(name = "roleMngService")
	private RoleMngService roleMngService;
	
	/**
	 * 코드 데이터를 조회위한 서비스
	 */
	@Resource(name = "codeMngService")
	private CodeMngService codeMngService;
	
	
	/**
	 * 롤 정책 조회
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@IncludedInfo(name = "롤관리", order = 470, gid = 50)
	@RequestMapping(value = "/sys/rol/rol00List.do")
	public String get00List(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		List highList = roleMngService.get00List(params);
		
		if(params.get("role_code")==null || params.get("role_code").equals("")){
			
		}else{
			List resultList = roleMngService.roleMenuUserList(params);
			model.addAttribute("resultList", resultList);
		}
		
		model.addAttribute("highList", highList);
		model.addAttribute("params", params);
		System.out.println("rol00List 이거 탓음~~~~~~~~~~~~~~");
		System.out.println("rol00List 이거 탓음~~~~~~~~~~~~~~");
		System.out.println("rol00List 이거 탓음~~~~~~~~~~~~~~");
		System.out.println("rol00List 이거 탓음~~~~~~~~~~~~~~");

//		return "letech/sys/rol/rol00List";
		return "letech/rol/rol00List";
	}
	
	/**
	 * 롤 정책 조회
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@IncludedInfo(name = "롤관리", order = 470, gid = 50)
	@RequestMapping(value = "/sys/rol/rol01List.do")
	public String get01List(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		params.put("auth_cd", VarConsts.SYS_AUTH_CODE);	// 권한구분코드
		params.put("user_cd", VarConsts.SYS_USER_CODE);	// 사용자구분코드
		List highList = roleMngService.get01List(params);
		
		model.addAttribute("highList", highList);
		model.addAttribute("params", params);
		
		return "letech/sys/rol/rol01List";
	}
	
	/**
	 * 롤 정책 조회
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@IncludedInfo(name = "롤관리", order = 470, gid = 50)
	@RequestMapping(value = "/sys/rol/rol02List.do")
	public String get02List(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		

		/*코드리스트 조회를 위한 상위코드입력*/
		
		List authList = roleMngService.get02List(params);
		
		model.addAttribute("authList", authList);
		model.addAttribute("params", params);
		
		return "letech/sys/rol/rol02List";
	}
	
	/**
	 * 롤 등록폼
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/sys/rol/rol00Form.do")
	public String form00(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);

		/*코드리스트 조회를 위한 상위코드입력*/
		params.put("up_cd", VarConsts.SYS_USER_CODE);
		List codeList = codeMngService.getCodeList(params);
		model.addAttribute("codeList", codeList);

		params.put("up_cd", VarConsts.SYS_AUTH_CODE);
		List codeList2 = codeMngService.getCodeList(params);
		model.addAttribute("codeList2", codeList2);
		
		Map getView = roleMngService.getView(params);
		model.addAttribute("getView", getView);
		model.addAttribute("params", params);
		
		return "letech/sys/rol/rol00Form";
	}
	
	/**
	 * 롤 매핑 등록폼
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/sys/rol/rol00Form2.do")
	public String rol00Form2(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		model.addAttribute("params", params);

		/*롤 권한 매핑을 위한 권한 코드 조회*/
//		params.put("up_cd", VarConsts.SYS_MNMTYPE_CODE);
		List authList = roleMngService.getAuthList(params);
		model.addAttribute("authList", authList);
		
		return "letech/sys/rol/rol00Form2";
	}
	
	/**
	 * 롤 매핑 등록폼
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/sys/rol/rol01Form.do")
	public String form01(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		model.addAttribute("params", params);

		List authList = roleMngService.getAuthList(params);
		model.addAttribute("authList", authList);
		
		return "letech/sys/rol/rol01Form";
	}
	
	/**
	 * 권한 등록폼
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/sys/rol/rol02Form.do")
	public String form02(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		model.addAttribute("params", params);

		Map getView = roleMngService.getAuthInfo(params);
		model.addAttribute("getView", getView);
		
		return "letech/sys/rol/rol02Form";
	}
	
	
	/**
	 * 롤 매핑 등록폼
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/sys/rol/rol01Form2.do")
	public String rol01Form2(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		model.addAttribute("params", params);

		/*롤 권한 매핑을 위한 권한 코드 조회*/
//		params.put("up_cd", VarConsts.SYS_MNMTYPE_CODE);
		List authList = roleMngService.getAuthList(params);
		model.addAttribute("authList", authList);
		
		return "letech/sys/rol/rol01Form2";
	}
	
	
	/**
	 * 롤등록
	 * @param request
	 * @param model
	 * @return 성공결과 json
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/rol/rol00Tran.do")
	public String tran00(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		model.addAttribute("params", params);
		
		String mode = (String)params.get("mode");
		String viewName = "jsonView";
		
		//고정값(패턴정의는 항상 url 기점으로)
		params.put("role_ty", "url");
		
		if(ObjToConvert.isEmpty(params.get("role_sort"))){
			params.put("role_sort","1");
		}
		
		if(mode.equals(VarConsts.MODE_I)){	/* 코드추가 */
			roleMngService.insert(params);	/* 상위코드추가 */
		}else if(mode.equals(VarConsts.MODE_U)){		 /* 코드수정 */
			roleMngService.updateNm(params);
		}else if(mode.equals(VarConsts.MODE_DA)){		/* 하위롤패턴포함삭제 */
			roleMngService.deleteAll(params);	
			viewName = "redirect:/sys/rol/rol00List.do?menu_id1=MN0001&menu_id2=MN0015&menu_id3=MN0016";
		}else if(mode.equals(VarConsts.MODE_D)){		/* 하위코드삭제 */
			roleMngService.delete(params);
			viewName = "redirect:/sys/rol/rol00List.do?menu_id1=MN0001&menu_id2=MN0015&menu_id3=MN0016";
		}
		
		return viewName;
	}
	
	/**
	 * 롤 권한 매핑 등록 수정 삭제
	 * @param request
	 * @param model
	 * @return 성공결과 json
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/rol/rol00Tran2.do")
	public String rol00Tran2(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		model.addAttribute("params", params);
		
		String mode = (String)params.get("mode");
		String viewName = "jsonView";
		
		if(mode.equals(VarConsts.MODE_I)){	/* 코드추가 */
			roleMngService.roleRelateInsert(params);	/* 상위코드추가 */
		}
		
		return viewName;
	}
	
	/**
	 * 권한 정보 등록 수정 삭제
	 * @param request
	 * @param model
	 * @return 성공결과 json
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/rol/rol01Tran.do")
	public String tran01(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		model.addAttribute("params", params);
		
		String mode = (String)params.get("mode");
		String viewName = "jsonView";
		
		if(mode.equals(VarConsts.MODE_I)){	/* 코드추가 */
			roleMngService.authRoleHicInsert(params);	/* 상위코드추가 */
		}else if(mode.equals(VarConsts.MODE_D)){		/* 하위코드삭제 */
			roleMngService.deleteRoleHic(params);
			viewName = "redirect:/sys/rol/rol01List.do?menu_id1=MN0001&menu_id2=MN0021&menu_id3=MN0023";
		}
		
		return viewName;
	}
	
	/**
	 * 권한 정보 등록 수정 삭제
	 * @param request
	 * @param model
	 * @return 성공결과 json
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/rol/rol02Tran.do")
	public String tran02(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		model.addAttribute("params", params);
		
		String mode = (String)params.get("mode");
		String viewName = "jsonView";
		
		if(mode.equals(VarConsts.MODE_I)){	/* 코드추가 */
			roleMngService.authInfoInsert(params);	
		}else if(mode.equals(VarConsts.MODE_U)){		 /* 코드수정 */
			roleMngService.updateAuthInfo(params);
		}else if(mode.equals(VarConsts.MODE_D)){		/* 하위코드삭제 */
			roleMngService.deleteAuthorInfo(params);	
//			viewName = "redirect:/sys/rol/rol02List.do?menu_id1=MN0001&menu_id2=MN0015&menu_id3=MN0018";
		}
		
		return viewName;
	}
}
