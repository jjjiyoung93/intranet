package kr.letech.cal.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.letech.cal.service.CalMngService;
import kr.letech.cmm.LoginVO;
import kr.letech.cmm.annotation.IncludedInfo;
import kr.letech.cmm.util.DateUtil;
import kr.letech.cmm.util.EgovFileMngUtil;
import kr.letech.cmm.util.EgovFileTool;
import kr.letech.cmm.util.ReqUtils;
import kr.letech.cmm.util.VarConsts;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class CalMngController {

	/** calMngService */
	@Resource(name = "calMngService")
	private CalMngService calMngService;
	
	/** 파일 업로드 */
    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;

	/**
	 * 일정 관리 화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@IncludedInfo(name = "일정관리", order = 470, gid = 50)
	@RequestMapping(value = "/cal/cal00List.do")
	public String getCalList(HttpServletRequest request, ModelMap model) throws Exception {
		HttpSession session = request.getSession();
		LoginVO loginVO = (LoginVO) session.getAttribute("loginVO");
		
		Map params = ReqUtils.getParameterMap(request);
		model.addAttribute("params", params);
		
		//Map resultView = calMngService.getCalView(params);
		//resultView.put("session_uss_id", loginVO.getId());
		
		// 현재 날짜 구하기
		DateUtil dt = new DateUtil();
		if(params.get("now_date") == null || "".equals(params.get("now_date")) ){
			model.addAttribute("now_date", dt.nowDate());
		}else{
			model.addAttribute("now_date", params.get("now_date"));
		}
		
		if(params.get("view_type") == null || params.get("view_type").equals("")){
			model.addAttribute("view_type", "month");
		}else{
			model.addAttribute("view_type", params.get("view_type"));
		}
		
		return "letech/cal/cal00List";
	}
	
	/**
	 * 일정 정보 조회
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cal/cal00Ajax.do")
	public String getCalAjax(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		model.addAttribute("params", params);
		
		String flag = (String)params.get("flag");

/*		 일정관리 화면일경우 (flag이 값이 1일경우는 메인화면일경우) */		
		if(flag==null || flag.equals("")){
			// 로그인 세션 정보
			HttpSession session = request.getSession();
			LoginVO loginVO = (LoginVO) session.getAttribute("loginVO");
			params.put("uss_id", loginVO.getId());
		}
		
		String viewName = "jsonView";
		
		calMngService.getCalList(params, model);
		
		return viewName;
	}
	
	/**
	 * 일정 등록 및 수정 화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cal/cal00Form.do")
	public String insertFrom(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		model.addAttribute("params", params);
		
		String mode = params.get("mode")==null?"":(String)params.get("mode");
		
		// 시 
		List hourList = new ArrayList();
		for(int i=0 ; i<=24 ; i++){
			String hour = "";
			if(i<10){
				hour = "0"+""+i;
			}else{
				hour = ""+i;
			}
			hourList.add(hour);
		}
		// 분
		List minuteList = new ArrayList();
		for(int i=0 ; i<=60 ; i++){
			String minute = "";
			if(i<10){
				minute = "0"+""+i;
			}else{
				minute = ""+i;
			}
			minuteList.add(minute);
		}
		
		
		/* 수정일경우 */
		if(mode.equals(VarConsts.MODE_U)){
			// 첨부파일 정보
			List fileList = calMngService.getCalFileList(params);
			model.addAttribute("fileList", fileList);
			// 일정 정보
			Map resultView = calMngService.getCalView(params);
			
			model.addAttribute("resultView", resultView);
		}else{
			Map<String, Object> resultView = new HashMap<String, Object>();
			if(!"".equals(params.get("CAL_ST_DT")) || null != params.get("CAL_ST_DT")){
				resultView.put("CAL_ST_DT", params.get("CAL_ST_DT"));
			}
			if(!"".equals(params.get("CAL_ED_DT")) || null != params.get("CAL_ED_DT")){
				resultView.put("CAL_ED_DT", params.get("CAL_ED_DT"));
			}
			model.addAttribute("resultView", resultView);
		}
		model.addAttribute("hourList", hourList);
		model.addAttribute("minuteList", minuteList);
		
		return "letech/cal/cal00Form";
	}
	
	/**
	 * 등록, 수정 기능
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cal/cal00Tran.do")
	public String tran(final MultipartHttpServletRequest multiRequest, ModelMap model) throws Exception {
		
//		MultipartHttpServletRequest multipartRequest =  (MultipartHttpServletRequest)request;
		Map params = ReqUtils.getParameterMap3(multiRequest);
		model.addAttribute("params", params);
		
		String mode = (String)params.get("mode");
		String viewName = "jsonView";
		
		String errorMsg = "N";
		try{

			/* 첨부파일 정보 */
			List<Map<String, Object>> fileList = null;
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
		    if (!files.isEmpty()) {
		    	fileList = fileUtil.parseFileInf(files, "CAL_", 0, "cal");	// (업로드 파일 정보, 저장될파일명 앞자리, 저장될 파일명의 마지막 자리 값, 저장위치명)
		    }
		    
			if(mode.equals(VarConsts.MODE_I)){
				calMngService.calInsert(params, fileList);	// 일정 및 파일 등록
			}else if(mode.equals(VarConsts.MODE_U)){
				calMngService.calUpdate(params, fileList);	// 일정 및 파일 수정 및 추가, 삭제
			}
			
		}catch (Exception e){
			e.printStackTrace();
			errorMsg = "Y";
		}
		model.addAttribute("errorMsg", errorMsg);
		
		return "letech/cal/cal00Tran";
	}
	
	/**
	 * 일정 상세조회 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cal/cal00View.do")
	public String getCalView(HttpServletRequest request, ModelMap model) throws Exception {
		// 사용자 정보 넣기
		HttpSession session = request.getSession();
		LoginVO loginVO = (LoginVO) session.getAttribute("loginVO");
		
		Map params = ReqUtils.getParameterMap(request);
		model.addAttribute("params", params);
		
		Map resultView = calMngService.getCalView(params);
		resultView.put("session_uss_id", loginVO.getId());
		
		List fileList = calMngService.getCalFileList(params);
		
		model.addAttribute("resultView", resultView);
		model.addAttribute("fileList", fileList);
		
		return "letech/cal/cal00View";
	}
	
	/**
	 * 일정 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cal/cal01Tran.do")
	public String delTran(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		String viewName = "jsonView";
		
		calMngService.calDelete(params);
		
		return viewName;
	}
	
	/**
	 * 일정 첨부파일 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cal/cal01Ajax.do")
	public String delFileAjax(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		String viewName = "jsonView";
		
		calMngService.calFileDelete(params);
		
		return viewName;
	}
}
