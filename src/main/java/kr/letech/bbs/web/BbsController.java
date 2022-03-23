package kr.letech.bbs.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.letech.bbs.service.BbsService;
import kr.letech.cmm.LoginVO;
import kr.letech.cmm.annotation.IncludedInfo;
import kr.letech.cmm.util.EgovFileMngUtil;
import kr.letech.cmm.util.ObjToConvert;
import kr.letech.cmm.util.ReqUtils;
import kr.letech.cmm.util.VarConsts;
import kr.letech.sys.bbs.service.BbsMngService;
import kr.letech.sys.cdm.service.CodeMngService;
import kr.letech.vct.service.impl.VctMngDAO;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

/**
 * 게시판 
 * @author jwchoi
 * @date 2015. 10. 22.
 */
/**
 * @author mskim
 *
 */
@Controller
public class BbsController {

	/**
	 * 게시판 서비스
	 */
	@Resource(name = "bbsService")
	private BbsService bbsService;

	/**
	 * 게시판 관리 서비스
	 */
	@Resource(name = "bbsMngService")
	private BbsMngService bbsMngService;

	/**
	 * 코드 데이터를 조회위한 서비스
	 */
	@Resource(name = "codeMngService")
	private CodeMngService codeMngService;

	/** 파일 업로드 */
	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;

	/** 휴가 관리 DAO */
	@Resource(name = "vctMngDAO")
	private VctMngDAO vctMngDAO;

	/**
	 * 게시판 리스트 조회
	 * 
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@IncludedInfo(name = "게시판", order = 470, gid = 50)
	@RequestMapping(value = "/bbs/bbs00List.do")
	public String bbs00List(HttpServletRequest request, ModelMap model) throws Exception {

		Map params = ReqUtils.getParameterMap(request);

		String bbs_id = "";

		if (ObjToConvert.isEmpty(params.get("bbs_id"))) {
			params.put("bbs_id", "BB0001");
			bbs_id = (String) params.get("bbs_id");
//			throw new NullPointerException("잘못된 접근 입니다.");
		}

		/* 탭구현을 위한 게시판 목록 조회 */
		List bbsTabList = bbsMngService.get00List(params);
		/* 해당 게시판의 속성 조회 */
		Map bbsInfo = bbsMngService.getView(params);
		String returnVal = "";
		Map bbsObject = new HashMap();
		if (bbsInfo.get("BBS_TY").equals("CD0004003")) {
			bbsObject = bbsService.getBbsImgList(params);
			params.put("listCnt", "16"); // 이미지게시판의 게시글 갯수지정
			returnVal = "letech/bbs/bbs01List"; // 이미지게시판
		} else {
			bbsObject = bbsService.getBbs00Object(params);
			returnVal = "letech/bbs/bbs00List"; // 공지사항 및 일반게시판
		}

		// 페이지 타이틀 네비를 위한 게시판이름 설정
		params.put("bbs_nm", bbsInfo.get("BBS_NM"));

		model.addAttribute("bbsTabList", bbsTabList);
		model.addAttribute("bbsInfo", bbsInfo);
		model.addAttribute("cPage", bbsObject.get("cPage"));
		model.addAttribute("totalCnt", bbsObject.get("totalCnt"));
		model.addAttribute("intListCnt", bbsObject.get("intListCnt"));
		model.addAttribute("resultList", bbsObject.get("resultList"));
		model.addAttribute("pageNavigator", bbsObject.get("pageNavigator"));
		model.addAttribute("params", params);

		return returnVal;
	}

	/**
	 * 게시물 등록 및 수정, 답변화면
	 * 
	 * @param request
	 * @param model
	 * @return 페이지 정보
	 * @throws Exception
	 */
	@IncludedInfo(name = "게시판관리", order = 470, gid = 50)
	@RequestMapping(value = "/bbs/bbs00Form.do")
	public String bbs00Form(HttpServletRequest request, ModelMap model) throws Exception {

		Map params = ReqUtils.getParameterMap(request);

		/* 탭구현을 위한 게시판 목록 조회 */
		List bbsTabList = bbsMngService.get00List(params);
		/* 해당 게시판의 속성 조회 */
		Map bbsInfo = bbsMngService.getView(params);
		String returnVal = "";
		Map bbsObject = new HashMap();
		if (bbsInfo.get("BBS_TY").equals("CD0004003")) {
			returnVal = "letech/bbs/bbs01Form"; // 이미지게시판
		} else {
			returnVal = "letech/bbs/bbs00Form"; // 공지사항 및 일반게시판
		}

		model.addAttribute("bbsTabList", bbsTabList);
		model.addAttribute("bbsInfo", bbsInfo);

		String mode = ReqUtils.getEmptyResult2((String) params.get("mode"), "I");

		if (mode.equals(VarConsts.MODE_U)) {
			Map resultView = bbsService.getBbsView(params);
			// 에디터에 의해서 '를 \'로 "를 \"로 변경
			resultView.put("CONTENT", ReqUtils.getEmptyResult2((String) resultView.get("CONTENT"), "")
					.replaceAll("\\'", "\\\\'").replaceAll("\\\"", "\\\\\""));
			List fileList = bbsService.getBbsFileList(params);

			model.addAttribute("resultView", resultView);
			model.addAttribute("fileList", fileList);
		}

		if (mode.equals(VarConsts.MODE_R)) {
			Map result = bbsService.getBbsView(params);
			Map resultView = new HashMap();
			resultView.put("TITLE", "답변 : " + result.get("TITLE"));
			model.addAttribute("resultView", resultView);
		}

		/* 게시판타이코드조회 */
		params.put("up_cd", VarConsts.SYS_BBS_TYPE_CODE);
		List codeList = codeMngService.getCodeList(params);

		model.addAttribute("bbsTyCodeList", codeList);
		model.addAttribute("params", params);

		return returnVal;
	}

	/**
	 * 게시판 등록
	 * 
	 * @param request
	 * @param model
	 * @return 성공결과 json
	 * @throws Exception
	 */
	@RequestMapping(value = "/bbs/bbs00Tran.do")
	public String bbs00Tran(final MultipartHttpServletRequest multiRequest, ModelMap model) throws Exception {

		Map params = ReqUtils.getParameterMap3(multiRequest);
		
		model.addAttribute("params", params);

		String mode = (String) params.get("mode");
		HttpSession session = multiRequest.getSession();
		LoginVO loginVO = (LoginVO) session.getAttribute("loginVO");

		params.put("reg_id", loginVO.getId());
		params.put("reg_nm", loginVO.getName());

		/* 첨부파일 정보 */
		List<Map<String, Object>> fileList = null;
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			fileList = fileUtil.parseFileInf(files, "BBS_", 0, "bbs"); // (업로드 파일 정보, 저장될파일명 앞자리, 저장될 파일명의 마지막 자리 값,
																		// 저장위치명)
		}

		if (mode.equals(VarConsts.MODE_I) || mode.equals(VarConsts.MODE_R)) { /* 코드추가 */
			bbsService.insertBbs(params, fileList); /* 상위코드추가 */
		} else if (mode.equals(VarConsts.MODE_U)) { /* 코드수정 */
			bbsService.updateBbs(params, fileList);
		}

		return "letech/bbs/bbs00Tran";
	}

	/**
	 * 댓글 등록 수정 삭제
	 * 
	 * @param request
	 * @param model
	 * @return 성공결과 json
	 * @throws Exception
	 */
	@RequestMapping(value = "/bbs/bbs00Tran01.do")
	public String bbs00Tran01(HttpServletRequest request, ModelMap model) throws Exception {

		Map params = ReqUtils.getParameterMap(request);
		model.addAttribute("params", params);

		String mode = (String) params.get("mode");
		HttpSession session = request.getSession();
		LoginVO loginVO = (LoginVO) session.getAttribute("loginVO");

		params.put("reg_id", loginVO.getId());
		params.put("reg_nm", loginVO.getName());

		if (mode.equals(VarConsts.MODE_I) || mode.equals(VarConsts.MODE_R)) {
			/* 댓글 등록 */
			bbsService.insertReply(params);
		} else if (mode.equals(VarConsts.MODE_U)) {
			/* 댓글 수정 */
			bbsService.updateReply(params);
		} else if (mode.equals(VarConsts.MODE_D)) {
			/* 댓글 삭제 */
			bbsService.deleteReply(params);
		}
		String viewName = "jsonView";
		return viewName;
	}

	/**
	 * 상세조회
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/bbs/bbs00View.do")
	public String bbsView(HttpServletRequest request, ModelMap model) throws Exception {

		Map params = ReqUtils.getParameterMap(request);

		/* 탭구현을 위한 게시판 목록 조회 */
		List bbsTabList = bbsMngService.get00List(params);
		/* 해당 게시판의 속성 조회 */
		Map bbsInfo = bbsMngService.getView(params);
		String returnVal = "";
		Map bbsObject = new HashMap();
		if (bbsInfo.get("BBS_TY").equals("CD0004003")) {
			returnVal = "letech/bbs/bbs01View"; // 이미지게시판
		} else {
			returnVal = "letech/bbs/bbs00View"; // 공지사항 및 일반게시판
		}

		model.addAttribute("bbsTabList", bbsTabList);
		model.addAttribute("bbsInfo", bbsInfo);

		/* 게시판타입코드조회 */
		params.put("up_cd", VarConsts.SYS_BBS_TYPE_CODE);
		List codeList = codeMngService.getCodeList(params);

		/* 게시글 상세조회 */
		Map resultView = bbsService.getBbsView(params);
		/* 첨부 파일 조회 */
		List fileList = bbsService.getBbsFileList(params);
		/* 댓글 목록 조회 */
		List repList = bbsService.getRepList(params);

		// 조회 수 증가
		bbsService.updateHitBbs(params);

		model.addAttribute("resultView", resultView);
		model.addAttribute("repList", repList);
		model.addAttribute("fileList", fileList);
		model.addAttribute("bbsTyCodeList", codeList);
		model.addAttribute("params", params);

		return returnVal;
	}

	/**
	 * 게시물 삭제
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/bbs/bbs01Tran.do")
	public String delTran(HttpServletRequest request, ModelMap model) throws Exception {

		Map params = ReqUtils.getParameterMap(request);

		String viewName = "jsonView";

		bbsService.deleteBbs(params);

		return viewName;
	}

	/**
	 * 게시물 첨부파일 삭제
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/bbs/bbs02Tran.do")
	public String delFileTran(HttpServletRequest request, ModelMap model) throws Exception {

		Map params = ReqUtils.getParameterMap(request);

		String viewName = "jsonView";

		bbsService.deleteBbsFile(params);

		return viewName;
	}

	/**
	 * 공지사항 정보 가져오기
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/bbs/bbs00Ajax.do")
	public String notiesList(HttpServletRequest request, ModelMap model) throws Exception {

		Map params = ReqUtils.getParameterMap(request);

		String viewName = "jsonView";

		/* 2022.01.24 휴가정보 조회 추가(연차 사용일 / 부여일) : BEGIN */
		HttpSession session = request.getSession();
		LoginVO loginVO = (LoginVO) session.getAttribute("loginVO");

		params.put("aprv_up_cd", VarConsts.EAM_MASTER_CODE);
		params.put("uss_id", loginVO.getId());

		Date today = new Date();

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

		String todayStr = formatter.format(today);

		String year = todayStr.substring(0, 4);

		params.put("stdd_yr", year);
		Map ussVctInfo = vctMngDAO.getUssVctInfo(params);
		model.addAttribute("ussVctInfo", ussVctInfo);
		/* 2022.01.24 휴가정보 조회 추가(연차 사용일 / 부여일) : END */

		List notiesList = bbsService.noticeList(params);

		model.addAttribute("notiesList", notiesList);

		return viewName;
	}

	/**
	 * 공지사항 팝업 화면
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/bbs/bbs01List.do")
	public String bbs01List(HttpServletRequest request, Model model) throws Exception {
		Map params = ReqUtils.getParameterMap(request);

		String bbs_id = "";

		if (ObjToConvert.isEmpty(params.get("bbs_id"))) {
			params.put("bbs_id", "BB0001");
			bbs_id = (String) params.get("bbs_id");
		}

		/* 탭구현을 위한 게시판 목록 조회 */
		List bbsTabList = bbsMngService.get00List(params);
		/* 해당 게시판의 속성 조회 */
		Map bbsInfo = bbsMngService.getView(params);
		String returnVal = "";
		Map bbsObject = new HashMap();
		bbsObject = bbsService.getBbs00Object(params);
		returnVal = "letech/bbs/bbs02List"; 

		// 페이지 타이틀 네비를 위한 게시판이름 설정
		params.put("bbs_nm", bbsInfo.get("BBS_NM"));

		model.addAttribute("bbsTabList", bbsTabList);
		model.addAttribute("bbsInfo", bbsInfo);
		model.addAttribute("cPage", bbsObject.get("cPage"));
		model.addAttribute("totalCnt", bbsObject.get("totalCnt"));
		model.addAttribute("intListCnt", bbsObject.get("intListCnt"));
		model.addAttribute("resultList", bbsObject.get("resultList"));
		model.addAttribute("pageNavigator", bbsObject.get("pageNavigator"));
		model.addAttribute("params", params);

		return returnVal;
	}
}
