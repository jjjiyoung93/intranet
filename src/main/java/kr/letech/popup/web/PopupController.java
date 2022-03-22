package kr.letech.popup.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.core.config.plugins.validation.constraints.Required;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.letech.cmm.util.ReqUtils;
import kr.letech.cmm.util.VarConsts;
import kr.letech.popup.service.PopupService;

@Controller
@RequestMapping("/pop")
public class PopupController {
	
	String cron = "";
	
	@Resource(name = "popupService")
	private PopupService popupService;

	/**
	 * 팝업 관리 목록 화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/pop00List.do")
	public String getPopupList(HttpServletRequest request, Model model) throws Exception{
		Map params = ReqUtils.getParameterMap(request);
//		List<Map> popupList = popupService.getPopupList(paraMap);
//		
//		model.addAttribute(popupList);
		
		model.addAttribute("params",params);
		return "letech/pop/pop00List";
	}
	
	@RequestMapping(value = "/pop00Prnt.do")
	public String printPopup(HttpServletRequest request, Model model) throws Exception{
		Map params = ReqUtils.getParameterMap(request);
		
		String mode = (String) params.get("mode");
		
		/*
		 * 팝업창 미리보기
		 */
		if(mode != null && mode.equals("preview")) {
			model.addAttribute("params",params);
		}
		
		return "letech/pop/pop00Prnt";
	}
	
	/**
	 * 팝업관리 등록 수정 화면
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/pop00Form.do")
	public String popForm(HttpServletRequest request, Model model) {
		Map paraMap = ReqUtils.getParameterMap(request);
		
		String mode = (String) paraMap.get("mode");
		
		if(mode != null && mode.equals(VarConsts.MODE_U)) {
			model.addAttribute("mode", mode);
		} else if(mode != null && mode.equals("PROTO")) {
			Map dataMap = new HashMap();
			dataMap.put("TITLE", "[공지]테스트글입니다");
			dataMap.put("CONTENT", "팝업 출력 테스트 글입니다.");
			dataMap.put("REG_NM", "관리자4");
			dataMap.put("NOTICE_TITLE", "[공지]2022년 02월 직원명부 배포");
			dataMap.put("NOTICE_SEQ", "5");
			dataMap.put("POPUP_WIDTH", 400);
			dataMap.put("POPUP_HEIGHT", 500);
			dataMap.put("HIDE_POPUP", "oneDay");
			
			model.addAttribute("popInfo", dataMap);
		}
		
		model.addAttribute("params", paraMap);
		
		return "letech/pop/pop00Form";
	}

	/**
	 * 팝업창 출력
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/pop00View.do")
	public String pop00View(HttpServletRequest request, Model model) throws Exception{
		Map params = ReqUtils.getParameterMap(request);
		
		String popSeq = (String) params.get("pop_seq");
		if(popSeq.equals("proto")) {
			Map dataMap = new HashMap();
			dataMap.put("TITLE", "[공지]테스트글입니다");
			dataMap.put("CONTENT", "팝업 출력 테스트 글입니다.");
			dataMap.put("REG_NM", "관리자4");
			dataMap.put("NOTICE_TITLE", "[공지]2022년 02월 직원명부 배포");
			dataMap.put("NOTICE_SEQ", "5");
			dataMap.put("POPUP_WIDTH", 400);
			dataMap.put("POPUP_HEIGHT", 500);
			dataMap.put("HIDE_POPUP", "oneDay");
			
			model.addAttribute("resultView", dataMap);
		}
		
		model.addAttribute("params", params);
			
		return "letech/pop/pop00View";
	}
}
