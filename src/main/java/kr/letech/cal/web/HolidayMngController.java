package kr.letech.cal.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.letech.cal.service.HolidayMngService;
import kr.letech.cmm.LoginVO;
import kr.letech.cmm.annotation.IncludedInfo;
import kr.letech.cmm.util.EgovFileScrty;
import kr.letech.cmm.util.ReqUtils;
import kr.letech.cmm.util.VarConsts;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
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
	
	
	
	/**
	 * 휴일 목록 가져오기
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@IncludedInfo(name = "휴일관리", order = 470, gid = 50)
	@RequestMapping(value = "sys/cal/hol00List.do")
	public String getHolMngList(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		
		String stddYr = (String) params.get("stdd_yr");
		
		Date today = null;
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy");
		
		//기준년도 파라미터가 없을 시 금년도 값을 파라미터 기본값으로 설정
		if(StringUtils.isEmpty(stddYr)) {
			
			today = new Date();
			
			stddYr = formatter.format(today);
			
			params.put("stdd_yr", stddYr);
		}
		
		List list = holidayMngService.getHolMngList(params);
		JSONArray jsonList = JSONArray.fromObject(list);
		
		int maxSeq = 0;
		maxSeq = holidayMngService.getHolMngMaxSeq(params);
		
		model.addAttribute("maxSeq", maxSeq);
		model.addAttribute("params", params);
		model.addAttribute("resultList", list);
		model.addAttribute("jsonList", jsonList);
		return "letech/cal/hol/holMng00List";
	}
	
	/**
	 * 휴일 목록 json 가져오기
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@IncludedInfo(name = "휴일관리", order = 470, gid = 50)
	@RequestMapping(value = "/cal/hol00Ajax.do")
	public String getHolMngAjaxList(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		
		String stddYr = (String) params.get("stdd_yr");
		
		Date today = null;
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy");
		String viewName = "jsonView";
		//기준년도 파라미터가 없을 시 금년도 값을 파라미터 기본값으로 설정
		if(StringUtils.isEmpty(stddYr)) {
			
			today = new Date();
			
			stddYr = formatter.format(today);
			
			params.put("stdd_yr", stddYr);
		}
		
		List list = holidayMngService.getHolMngList(params);
		JSONArray jsonList = JSONArray.fromObject(list);
		
		model.addAttribute("params", params);
		model.addAttribute("resultList", list);
		model.addAttribute("jsonList", jsonList);
		return viewName;
	}
	
	
	
	/**
	 * 휴일 등록, 수정, 삭제 기능
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "sys/cal/hol00Tran.do")
	public String getHolMngTran(HttpServletRequest request, ModelMap model) throws Exception {

		Map params = ReqUtils.getParameterMap(request);

		String mode = (String)params.get("mode");
		
		HttpSession session = request.getSession();
		LoginVO loginVO = (LoginVO) session.getAttribute("loginVO");
		
		params.put("uss_id", loginVO.getId());
		
		int resultCnt = 0;
		String msg = null;
		Map resultMap = null;
		try {
//			if(mode.equals(VarConsts.MODE_I)){
//				/* 사용자 등록 */
//				holidayMngService.holidayInsert(params);
//			}else if(mode.equals(VarConsts.MODE_U)){
//				/* 사용자 수정 */
//				holidayMngService.holidayUpdate(params);
//			}
//			
			if(mode.equals(VarConsts.MODE_D)){
				/* 사용자 삭제 */
				//holidayMngService.holidayDelete(params);
				resultCnt = holidayMngService.holMngDelete(params);
			}else {
				resultMap = holidayMngService.mergeHolMng(params);
			}
			msg = "0000"; // 성공 메세지
			
		} catch (Exception e) {
			msg = "9999";
		}
		JSONObject jsonMap = JSONObject.fromObject(resultMap);
		model.addAttribute("resultMap", resultMap);
		model.addAttribute("jsonMap", jsonMap);
		model.addAttribute("resultCnt", resultCnt);
		model.addAttribute("resultMsg", msg);
		model.addAttribute("params", params);
		
		return "letech/cal/hol/holMng00Tran";
	}
	
	/**
	 * 휴일 업데이트 : 공공데이터포털 특일정보 api 동기화
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "sys/cal/hol00Upd.do")
	public String getHolMngUpd(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		//String mode = (String)params.get("mode");
		
		int resultCnt = 0;
		String msg = null;
		Map resultMap = null;
		try {
			resultCnt = holidayMngService.holMngUpdateBySys(params);
			msg = "0000"; // 성공 메세지
			
		} catch (Exception e) {
			msg = "9999";
		}
		params.put("mode", "UPDATE_SYS");
		JSONObject jsonMap = JSONObject.fromObject(resultMap);
		model.addAttribute("resultMap", resultMap);
		model.addAttribute("jsonMap", jsonMap);
		
		model.addAttribute("resultCnt", resultCnt);
		model.addAttribute("resultMsg", msg);
		model.addAttribute("params", params);
		
		return "letech/cal/hol/holMng00Tran";
	}
	

}
