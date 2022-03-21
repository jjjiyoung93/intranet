package kr.letech.sys.sch.web;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.letech.cmm.util.EgovProperties;
import kr.letech.cmm.util.ReqUtils;

/** 
 * 배치관리
 * @packageName : kr.letech.sys.sch.web
 * @fileName 	: SchMngController.java
 * @author		: KIM JI YOUNG
 * @date 		: 2022.03.21
 * @description :
 * ===========================================================
 *    DATE         AUTHOR        NOTE
 * -----------------------------------------------------------
 * 2022.03.21   KIM JI YOUNG     최초 생성
 */
@Controller
public class SchMngController {

	private static final Logger log = LoggerFactory.getLogger(EgovProperties.class);

	/**
	 * 배치프로그램 조회
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 * @Method : getSch00List
	 * @Author : KIM JI YOUNG
	 * @Date   : 2022.03.21
	 */
	@RequestMapping(value="/sys/sch/sch00List.do")
	public String getSch00List(HttpServletRequest request, ModelMap model) throws Exception{
//		Map params = ReqUtils.getParameterMap(request);
		
//		model.addAttribute("params", params);
//		model.addAttribute("pageInfo", pageInfo);
//		model.addAttribute("cPage", pageInfo.get("cPage"));
//		model.addAttribute("totalCnt", pageInfo.get("totalCnt"));
//		model.addAttribute("intListCnt", pageInfo.get("intListCnt"));
//		model.addAttribute("resultList", pageInfo.get("resultList"));
//		model.addAttribute("pageNavigator", pageInfo.get("pageNavigator"));
		
		return "letech/sys/sch/sch00List";
	}
	
	/**
	 * 배치프로그램 상세조회
	 * @param request
	 * @param map
	 * @return
	 * @throws Exception
	 * @Method : getSch00View
	 * @Author : KIM JI YOUNG
	 * @Date   : 2022.03.21
	 */
	@RequestMapping(value="/sys/sch/sch00View.do")
	public String getSch00View(HttpServletRequest request, ModelMap map) throws Exception{
		return "letech/sys/sch/sch00View";
	}
	
	/**
	 * 배치프로그램 등록
	 * @param request
	 * @param map
	 * @return
	 * @throws Exception
	 * @Method : getSch00Form
	 * @Author : KIM JI YOUNG
	 * @Date   : 2022.03.21
	 */
	@RequestMapping(value="/sys/sch/sch00View.do")
	public String getSch00Form(HttpServletRequest request, ModelMap map) throws Exception{
		return "letech/sys/sch/sch00Form";
	}
}
