package kr.letech.cal.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.letech.cal.service.HolidayMngService;
import kr.letech.cmm.annotation.IncludedInfo;
import kr.letech.cmm.util.EgovFileScrty;
import kr.letech.cmm.util.ReqUtils;
import kr.letech.cmm.util.VarConsts;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HolidayMngController {

	/** calMngService */
	@Resource(name = "holidayMngService")
	private HolidayMngService holidayMngService;
	
	/**
	 * 휴일 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@IncludedInfo(name = "휴일관리", order = 470, gid = 50)
	@RequestMapping(value = "/cal/hol00List.do")
	public String getHolidayList(HttpServletRequest request, ModelMap model) throws Exception {

		Map params = ReqUtils.getParameterMap(request);
		
		List list = holidayMngService.getHolidyList(params);
		
		model.addAttribute("resultList", list);
		return "letech/cal/hol00List";
	}
	
	/**
	 * 휴일 삭제조회
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cal/hol00View.do")
	public String getHolidayView(HttpServletRequest request, ModelMap model) throws Exception {

		Map params = ReqUtils.getParameterMap(request);
		
		Map result = holidayMngService.getHolidyView(params);
		
		model.addAttribute("params", result);
		return "letech/cal/hol00View";
	}
	
	/**
	 * 휴일 등록 및 수정 폼화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cal/hol00Form.do")
	public String getHolidayForm(HttpServletRequest request, ModelMap model) throws Exception {

		Map params = ReqUtils.getParameterMap(request);
		
		String mode = params.get("mode")==null?"":(String)params.get("mode");
		if(mode.equals(VarConsts.MODE_U)){
			Map result = holidayMngService.getHolidyView(params);
			model.addAttribute("params", result);
		}
		
		return "letech/cal/hol00Form";
	}
	
	/**
	 * 휴일 등록, 수정, 삭제 기능
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cal/hol00Tran.do")
	public String getHolidayTran(HttpServletRequest request, ModelMap model) throws Exception {

		Map params = ReqUtils.getParameterMap(request);

		String mode = (String)params.get("mode");
		String viewName = "jsonView";
		
		if(mode.equals(VarConsts.MODE_I)){
			/* 사용자 등록 */
			holidayMngService.holidayInsert(params);
		}else if(mode.equals(VarConsts.MODE_U)){
			/* 사용자 수정 */
			holidayMngService.holidayUpdate(params);
		}else if(mode.equals(VarConsts.MODE_D)){
			/* 사용자 삭제 */
			holidayMngService.holidayDelete(params);
		}
		return viewName;
	}

}
