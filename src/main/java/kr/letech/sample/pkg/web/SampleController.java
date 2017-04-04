package kr.letech.sample.pkg.web;

import java.util.HashMap;
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
import kr.letech.sample.pkg.service.SampleService;
import kr.letech.sys.cdm.service.CodeMngService;
import kr.letech.sys.mnm.service.MenuMngService;

/**
 * 샘플 컨트롤러 클래스
 * @author jwchoi
 *
 */
@Controller
public class SampleController {
	
	
	/** sampleService */
	@Resource(name = "sampleService")
	private SampleService sampleService;
	
	
	/**
	 * 코드 데이터를 조회위한 서비스
	 */
	@Resource(name = "codeMngService")
	private CodeMngService codeMngService;
	
	
	/**
	 * 메뉴 관련 서비스
	 */
	@Resource(name = "menuMngService")
	private MenuMngService menuMngService;
	
	
	/**
	 * 샘플 리스트 조회
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@IncludedInfo(name = "샘플리스트", order = 470, gid = 50)
	@RequestMapping(value = "/sample/list.do")
	public String getList(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		String searchField = (String) params.get("searchField");
		Map pmap = new HashMap();
		
		pmap.put("t1", "test1");
		pmap.put("t2", "test2");
		if(ObjToConvert.isNotEmpty(searchField)){
			pmap.put("t3", searchField);
		}else{
			pmap.put("t3", "test3");
		}
		
		List list = sampleService.getlsit(params);
		
		
		/*코드리스트 조회를 위한 상위코드입력*/
		params.put("up_cd", VarConsts.EAM_MASTER_CODE);
		List codeList = codeMngService.getCodeList(params);
		model.addAttribute("codeList", codeList);
		
		model.addAttribute("resultList", pmap);
		model.addAttribute("getList", list);

		return "sample/sample00L";
	}
	
	/**
	 * 샘플 등록
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@RequestMapping(value = "/sample/insert.do")
	public String insert(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		Map pmap = new HashMap();
		
		sampleService.insert2(params);
		
		model.addAttribute("resultList", pmap);
		
//		return "forward:/sample/list.do";
		return "redirect:/sample/list.do";
	}
	
		/**
		 * 샘플 메뉴
		 * @param request
		 * @param model
		 * @return 페이지 정보
		 * @throws Exception
		 */
		@RequestMapping(value = "/sample/menu.do")
		public String frame(HttpServletRequest request, ModelMap model) throws Exception {
			
			Map params = ReqUtils.getParameterMap(request);
			
			params.put("use_yn", "Y");
			List mnList = menuMngService.getOneCodeList(params);
			model.addAttribute("mnList", mnList);
			
			return "sample/sampleMenu00List";
	}
}
