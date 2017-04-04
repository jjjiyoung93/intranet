package kr.letech.sys.bbs.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.letech.cmm.LoginVO;
import kr.letech.cmm.annotation.IncludedInfo;
import kr.letech.cmm.util.ObjToConvert;
import kr.letech.cmm.util.ReqUtils;
import kr.letech.cmm.util.VarConsts;
import kr.letech.sys.bbs.service.BbsMngService;
import kr.letech.sys.cdm.service.CodeMngService;
import kr.letech.sys.rol.service.RoleMngService;

/**
 * 게시판 관리
 * @author jwchoi
 * @date 2015. 10. 22.
 */
@Controller
public class BbsMngController {
	
	@Resource(name = "bbsMngService")
	private BbsMngService bbsMngService;
	
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
	@IncludedInfo(name = "게시판관리", order = 470, gid = 50)
	@RequestMapping(value = "/sys/bbs/bbs00List.do")
	public String bbs00List(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		List highList = bbsMngService.get00List(params);
		
		model.addAttribute("highList", highList);
		model.addAttribute("params", params);

		return "letech/sys/bbs/bbs00List";
	}
	
	/**
	 * 롤 정책 조회
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@IncludedInfo(name = "게시판관리", order = 470, gid = 50)
	@RequestMapping(value = "/sys/bbs/bbs00Form.do")
	public String bbs00Form(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		
		/*게시판타입코드조회*/
		params.put("up_cd",VarConsts.SYS_BBS_TYPE_CODE);
		List codeList = codeMngService.getCodeList(params);
		
		/*게시판레이아웃코드조회*/
		params.put("up_cd",VarConsts.SYS_BBS_LAYOUT_TY);
		List codeList2 = codeMngService.getCodeList(params);

		if(ObjToConvert.isNotEmpty(params.get("bbs_id"))){
			Map getView = bbsMngService.getView(params);
			model.addAttribute("getView", getView);
		}
		
		model.addAttribute("bbsTyCodeList", codeList);
		model.addAttribute("bbsLayoutTyCodeList", codeList2);
		model.addAttribute("params", params);

		return "letech/sys/bbs/bbs00Form";
	}
	
	/**
	 * 게시판 등록
	 * @param request
	 * @param model
	 * @return 성공결과 json
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/bbs/bbs00Tran.do")
	public String bbs00Tran(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		model.addAttribute("params", params);
		
		String mode = (String)params.get("mode");
		String viewName = "jsonView";
		HttpSession session = request.getSession();
		LoginVO loginVO = (LoginVO) session.getAttribute("loginVO");
		params.put("reg_id", loginVO.getId());
		if(mode.equals(VarConsts.MODE_I)){	/* 코드추가 */
			bbsMngService.insertBbs(params);	/* 상위코드추가 */
		}else if(mode.equals(VarConsts.MODE_U)){		 /* 코드수정 */
			bbsMngService.updateBbs(params);
		}else if(mode.equals(VarConsts.MODE_D)){		/* 하위코드삭제 */
			bbsMngService.deleteBbs(params);
			viewName = "redirect:/sys/bbs/bbs00List.do";
		}
		
		return viewName;
	}
}

