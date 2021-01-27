package kr.letech.doc.web;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.letech.aprv.service.AprvMngService;
import kr.letech.cmm.util.EgovProperties;
import kr.letech.cmm.util.ReqUtils;
import kr.letech.doc.service.DocService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 2021-01-12
 * 전자결재 문서양식 관련 컨트롤러
 * @author JO MIN SOO
 */
@Controller
public class DocController {

	@Resource(name = "docService")
	private DocService docService;
	
	@Resource(name = "aprvMngService")
	private AprvMngService aprvMngService;
	
	/**
	* 보고서 팝업 출력 및 보고서 양식 반환
	* 작성자 : JO MIN SOO
	* 변경이력 :
	* @param request
	* @param model
	* @return
	* @throws Exception
	*/
	@RequestMapping(value = "/doc/doc00Popup.do")
	public String getDocView(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		/* 상세 정보 조회 */
		Map viewMap = aprvMngService.getAprvView(params);
		
		/* 결재 라인 정보 조회 */
		List lineList = aprvMngService.aprvLineList(params);
		
		/* 문서 코드 조회 */
		Map codeMap = docService.getDocCode(viewMap);
		
		/* 문서 데이터 조회 */
		Map docMap = docService.getDocData(viewMap);
		
		/* 첨부파일 리스트 조회 */
		List fileList = aprvMngService.aprvFileList(params);
		
		// viewMap(결재정보 데이터), docMap(보고서 데이터), fileList(첨부파일 리스트)는 jsp에서 json형태로 사용하기 위해 파싱하여 Model에 저장
		JSONObject docJson = JSONObject.fromObject(docMap);
		JSONObject viewJson = JSONObject.fromObject(viewMap);
		JSONArray fileJson = JSONArray.fromObject(fileList);
		
		model.addAttribute("viewMap", viewMap);
		model.addAttribute("lineList", lineList);
		model.addAttribute("docReport", codeMap.get("DOC_REPORT"));
		model.addAttribute("docJson", docJson);
		model.addAttribute("viewJson", viewJson);
		model.addAttribute("fileJson", fileJson);
		
		return "letech/doc/doc00Popup";
	}
	
	/**
	* 서버에 저장된 sign.png파일을 이미지로 반환한다. 
	* 작성자 : JO MIN SOO
	* 변경이력 :
	* @param request
	* @param response
	* @param model
	* @throws Exception
	*/
	@RequestMapping(value = "/doc/sign.do")
	public void test(HttpServletRequest request, HttpServletResponse  response, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		String filePath = EgovProperties.getProperty("Globals.fileStorePath") + "sign/";	// 기본 저장 위치
		
		response.setContentType("image/png");
		File file = new File(filePath + params.get("emp_no") + ".png");
		
		if(file.exists() == false) {
			file = new File(filePath + "nosign.png");
		}
		
		response.setContentLength((int) file.length());

		FileInputStream in = new FileInputStream(file);
		OutputStream out = response.getOutputStream();

		byte[] buf = new byte[1024];
		int count = 0;
		while ((count = in.read(buf)) >= 0) {
			out.write(buf, 0, count);
		}
		out.close();
		in.close();
	}
	
	
	/**
	* 문서의 코드를 반환
	* 작성자 : JO MIN SOO
	* 변경이력 :
	* @param request
	* @param model
	* @return
	* @throws Exception
	*/
	@RequestMapping(value = "/doc/doc00Ajax.do")
	public String getDocCode(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		String viewName = "jsonView";
		
		// 상위코드, 하위코드에 해당하는 문서코드(소스코드)
		Map docCode = docService.getDocCode(params);
		model.addAttribute("DOC_CODE", docCode.get("DOC_CODE"));
		
		return viewName;
	}
}
