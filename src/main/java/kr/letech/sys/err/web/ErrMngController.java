package kr.letech.sys.err.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.letech.cmm.LoginVO;
import kr.letech.cmm.annotation.IncludedInfo;
import kr.letech.cmm.util.ReqUtils;
import kr.letech.cmm.util.VarConsts;
import kr.letech.sys.cdm.service.CodeMngService;
import kr.letech.sys.err.service.ErrMngService;

/**
 * 에러 관리
 * @author jwchoi
 *
 */
@Controller
public class ErrMngController {
	
	@Resource(name = "errMngService")
	private ErrMngService errMngService;
	
	/**
	 * 코드 데이터를 조회위한 서비스
	 */
	@Resource(name = "codeMngService")
	private CodeMngService codeMngService;
	
	/**
	 * 발생에러 조회
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@IncludedInfo(name = "에러관리", order = 470, gid = 50)
	@RequestMapping(value = "/sys/err/err00List.do")
	public String get00List(HttpServletRequest request, ModelMap model) throws Exception {
		Map params = ReqUtils.getParameterMap(request);
		
		Map pageInfo = errMngService.get00PageInfo(params);
		
		model.addAttribute("params", params);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("cPage", pageInfo.get("cPage"));
		model.addAttribute("totalCnt", pageInfo.get("totalCnt"));
		model.addAttribute("intListCnt", pageInfo.get("intListCnt"));
		model.addAttribute("resultList", pageInfo.get("resultList"));
		model.addAttribute("pageNavigator", pageInfo.get("pageNavigator"));

		return "letech/sys/err/err00List";
	}
	
	/**
	 * 발생에러 상세조회
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/err/err00View.do")
	public String get00View(HttpServletRequest request, ModelMap model) throws Exception {
		Map params = ReqUtils.getParameterMap(request);
		
		if("1".equals(params.get("process_state"))){
			params.put("process_state", "2");	// 확인중으로 변경
			
			errMngService.updateProcessState(params);
		}

		Map resultView = errMngService.get00ErrView(params);
		
		model.addAttribute("resultView", resultView);
		model.addAttribute("params", params);
		
		return "letech/sys/err/err00View";
	}
	
	/**
	 * 저장 & 완료 처리 등록
	 * @param request
	 * @param model
	 * @return 성공결과 json
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/err/err00Tran.do")
	public String get00Tran(HttpServletRequest request, ModelMap model) throws Exception {

		Map params = ReqUtils.getParameterMap(request);
		model.addAttribute("params", params);
		
		Object mode = params.get("mode");
		HttpSession session = request.getSession();
		LoginVO loginVO = (LoginVO) session.getAttribute("loginVO");
		
		params.put("process_reg_nm", loginVO.getName());

		if(VarConsts.MODE_I.equals(mode)){
			//완료 처리
			params.put("process_state", "0");	// 완료로 변경
			errMngService.updateCompletion(params);
		}else if(VarConsts.MODE_U.equals(mode)){
			//저장
			params.put("process_state", "3");	// 처리중으로 변경
			errMngService.updateSave(params);
		}
		
		return "letech/sys/err/err00Tran";
	}
	
	/**
	 * 처리이력 조회
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@IncludedInfo(name = "에러관리", order = 470, gid = 50)
	@RequestMapping(value = "/sys/err/err01List.do")
	public String get01List(HttpServletRequest request, ModelMap model) throws Exception {
		Map params = ReqUtils.getParameterMap(request);
		
		Map pageInfo = errMngService.get01PageInfo(params);
		
		model.addAttribute("params", params);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("cPage", pageInfo.get("cPage"));
		model.addAttribute("totalCnt", pageInfo.get("totalCnt"));
		model.addAttribute("intListCnt", pageInfo.get("intListCnt"));
		model.addAttribute("resultList", pageInfo.get("resultList"));
		model.addAttribute("pageNavigator", pageInfo.get("pageNavigator"));

		return "letech/sys/err/err01List";
	}
	
	/**
	 * 발생에러 상세조회
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/err/err01View.do")
	public String get01View(HttpServletRequest request, ModelMap model) throws Exception {
		Map params = ReqUtils.getParameterMap(request);
		
		Map resultView = errMngService.get01ErrView(params);
		
		model.addAttribute("resultView", resultView);
		model.addAttribute("params", params);
		
		return "letech/sys/err/err01View";
	}
}
