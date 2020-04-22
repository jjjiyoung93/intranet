package kr.letech.app.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.letech.app.service.AppBbsService;
import kr.letech.aprv.service.AprvMngService;
import kr.letech.cmm.util.EgovMapUtil;
import kr.letech.cmm.util.EgovProperties;
import kr.letech.cmm.util.ReqUtils;
import kr.letech.sys.cdm.service.CodeMngService;

@Controller
public class AppBbsController {


	@Resource(name = "appBbsService")
	private AppBbsService appBbsService;
	
	/** calMngService */
	@Resource(name = "aprvMngService")
	private AprvMngService aprvMngService;
	/**
	 * 코드 데이터를 조회위한 서비스
	 */
	@Resource(name = "codeMngService")
	private CodeMngService codeMngService;
	


	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/sample/appBbs01List.json")
	public String appBbs01List(HttpServletRequest request, ModelMap model) throws Exception {
		//공지사항 리스트 출력
		
		Map<String, Object> params = ReqUtils.getParameterMap(request);
		
		String viewName = "jsonView";
		model.addAttribute("bbsList", appBbsService.getSelectBbsPageInfo(params));
		
		return viewName;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/sample/appBbs01View.json")
	public String appBbs01View(HttpServletRequest request, ModelMap model) throws Exception {
		//공지사항 상세보기 출력
		
		Map<String, Object> params = ReqUtils.getParameterMap(request);
				
		String viewName = "jsonView";
		model.addAllAttributes(appBbsService.getSelectAppBbsView(params));
		return viewName;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/sample/appPayment01List.json")
	public String appPayment01List(HttpServletRequest request, ModelMap model) throws Exception {
		//커뮤니티 리스트 출력
		
		Map<String, Object> params = ReqUtils.getParameterMap(request);
		
		String viewName = "jsonView";
		model.addAttribute("bbsList", appBbsService.getSelectPaymentPageInfo(params));
		model.addAttribute("totalCnt", appBbsService.getSelectPaymentPageInfoCnt(params));
		
		return viewName;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/sample/appPayment01View.json")
	public String appPayment01View(HttpServletRequest request, ModelMap model) throws Exception {
		//결제관리 상세보기 출력
		
		Map<String, Object> params = ReqUtils.getParameterMap(request);
				
		String viewName = "jsonView";
		model.addAllAttributes(appBbsService.getSelectAppPaymnentView(params));
		
/*		코드리스트 조회를 위한 상위코드입력
		params.put("up_cd", VarConsts.EAM_MASTER_CODE);
		List codeList = codeMngService.getCodeList(params);
		model.addAttribute(codeList);
		
		params.put("up_cd", VarConsts.EAM_PROJECT_CODE);
		List projList = codeMngService.getCodeList(params);
		model.addAttribute(projList);

		상세 코드리스트 조회를 위한 상위코드입력
		List codeList2 = codeMngService.getCodeList(params);
		model.addAttribute(codeList2);
*/		
		return viewName;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/sample/appPaymentLine01View.json")
	public String appPaymentLine01View(HttpServletRequest request, ModelMap model) throws Exception {
		//결제관리 상세보기 출력
		
		Map<String, Object> params = ReqUtils.getParameterMap(request);
				
		String viewName = "jsonView";
		model.addAttribute("bbsList", appBbsService.getSelectAppPaymnentLineView(params));
		
		return viewName;
	}
	
	/**
	 * 결재 승인(완료, 보류, 반려)
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sample/appPaymentComplate.json")
	public String appPaymentComplate(HttpServletRequest request, ModelMap model) throws Exception {

		Map<String, Object> params = ReqUtils.getParameterMap(request);
		
		
		params.put("aprv_no", params.get("aprvNo"));
		String viewName = "jsonView";
		
		try{
			aprvMngService.aprvLineUpdate(params);	// 결재승인(완료, 보류, 반려)
			model.addAttribute("success", "0");
		}catch(SQLException e){
			e.printStackTrace();
			model.addAttribute("success", "1");
		}catch(Exception e){
			e.printStackTrace();
			model.addAttribute("success", "1");
		}
		
		
		
		
		return viewName;
	}

	//프로젝트 정보
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/sample/appCdNm.json")
	public String appCdNm(HttpServletRequest request, ModelMap model) throws Exception {
		String viewName = "jsonView";
		Map<String, Object> params = ReqUtils.getParameterMap(request);

		// 코드목록조회
		List<HashMap<?, ?>> codeList = codeMngService.getCodeList(params);

		// Convert ListHashMap to ListEgovMap
		model.addAttribute("bbsList", EgovMapUtil.convertListHashMap2ListEgovMap(codeList));

		return viewName;
	}
	
	//프로젝트 정보
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/sample/appFileInfo.json")
	public String appFileInfo(HttpServletRequest request, ModelMap model) throws Exception {
		//결제관리 파일정보 출력
		String viewName = "jsonView";
		Map<String, Object> params = ReqUtils.getParameterMap(request);

		//파일목록조회
		List<HashMap<?, ?>> codeList = aprvMngService.aprvFileList(params);
		// Convert ListHashMap to ListEgovMap
		model.addAttribute("bbsList", EgovMapUtil.convertListHashMap2ListEgovMap(codeList));
		return viewName;
		
	}
	
	
	
	
	/**
	 * 첨부파일로 등록된 파일에 대하여 다운로드를 제공한다.
	 *
	 * @param commandMap
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/sample/FileDown.do")
	public void cvplFileDownload(HttpServletRequest request, HttpServletResponse response) throws Exception {

		Map params = ReqUtils.getParameterMap(request);
		
		String file_path = (String)params.get("file_path");			// 저장위치
		String file_nm = (String)params.get("file_nm");				// 원문파일명
		String file_stre_nm = (String)params.get("file_stre_nm");	// 저장파일명
		
		if(file_path==null || file_path.equals("")){
			file_path = EgovProperties.getProperty("Globals.fileStorePath");	// 기본 저장 위치
		}else{
			file_path = EgovProperties.getProperty("Globals.fileStorePath") + file_path + File.separator;	// 기본 저장 위치
		}
		
		File uFile = new File(file_path, file_stre_nm);
		long fSize = uFile.length();

		if (fSize > 0) {
			String mimetype = "application/x-msdownload";

			//response.setBufferSize(fSize);	// OutOfMemeory 발생
			response.setContentType(mimetype);
			//response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(fvo.getOrignlFileNm(), "utf-8") + "\"");
			setDisposition(file_nm, request, response);
			//response.setContentLength(fSize);

			/*
			 * FileCopyUtils.copy(in, response.getOutputStream());
			 * in.close();
			 * response.getOutputStream().flush();
			 * response.getOutputStream().close();
			 */
			BufferedInputStream in = null;
			BufferedOutputStream out = null;

			try {
				in = new BufferedInputStream(new FileInputStream(uFile));
				out = new BufferedOutputStream(response.getOutputStream());

				FileCopyUtils.copy(in, out);
				out.flush();
			} catch (IOException ex) {
				// 다음 Exception 무시 처리
				// Connection reset by peer: socket write error
//				EgovBasicLogger.ignore("IO Exception", ex);
			} finally {
//				EgovResourceCloseHelper.close(in, out);
			}

		} else {
			
			response.setContentType("application/x-msdownload");

			PrintWriter printwriter = response.getWriter();
			
			printwriter.println("<html>");
			printwriter.println("<br><br><br><h2>Could not get file name:<br>" + file_nm + "</h2>");
			printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
			printwriter.println("<br><br><br>&copy; webAccess");
			printwriter.println("</html>");
			
			printwriter.flush();
			printwriter.close();
		}
	}
	
	
	
	/**
	 * Disposition 지정하기.
	 *
	 * @param filename
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	private void setDisposition(String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String browser = getBrowser(request);

		String dispositionPrefix = "attachment; filename=";
		String encodedFilename = null;

		if (browser.equals("MSIE")) {
			encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		} else if (browser.equals("Trident")) { // IE11 문자열 깨짐 방지
			encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		} else if (browser.equals("Firefox")) {
			encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.equals("Opera")) {
			encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.equals("Chrome")) {
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < filename.length(); i++) {
				char c = filename.charAt(i);
				if (c > '~') {
					sb.append(URLEncoder.encode("" + c, "UTF-8"));
				} else {
					sb.append(c);
				}
			}
			encodedFilename = sb.toString();
		} else {
			throw new IOException("Not supported browser");
		}

		response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename);

		if ("Opera".equals(browser)) {
			response.setContentType("application/octet-stream;charset=UTF-8");
		}
	}
	
	
	/**
	 * 브라우저 구분 얻기.
	 *
	 * @param request
	 * @return
	 */
	private String getBrowser(HttpServletRequest request) {
		String header = request.getHeader("User-Agent");
		if (header.indexOf("MSIE") > -1) {
			return "MSIE";
		} else if (header.indexOf("Trident") > -1) { // IE11 문자열 깨짐 방지
			return "Trident";
		} else if (header.indexOf("Chrome") > -1) {
			return "Chrome";
		} else if (header.indexOf("Opera") > -1) {
			return "Opera";
		}
		return "Firefox";
	}

	
	

}
