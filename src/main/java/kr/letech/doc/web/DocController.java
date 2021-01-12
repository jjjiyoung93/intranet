package kr.letech.doc.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.letech.cmm.util.ReqUtils;
import kr.letech.doc.service.DocService;

/**
 * 2021-01-12
 * 전자결재 문서양식 관련 컨트롤러
 * @author JO MIN SOO
 */
@Controller
public class DocController {

	@Resource(name = "docService")
	private DocService docService;
	
	@RequestMapping(value = "/doc/doc00View.do")
	public String getDocView(HttpServletRequest request, ModelMap model) throws Exception {
		
		return "";
	}
	
	@RequestMapping(value = "/doc/doc00Ajax.do")
	public String aprvCode(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		String viewName = "jsonView";
		
		// 상위코드, 하위코드에 해당하는 문서코드(소스코드)
		Map docCode = docService.getDocCode(params);
		model.addAttribute("DOC_INST_CODE", docCode.get("DOC_INST_CODE"));
		model.addAttribute("DOC_MODI_CODE", docCode.get("DOC_MODI_CODE"));
		
		return viewName;
	}
}
