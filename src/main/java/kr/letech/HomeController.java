package kr.letech;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.letech.cmm.LoginVO;
import kr.letech.cmm.util.DateUtil;
import kr.letech.cmm.util.EgovUserDetailsHelper;
import kr.letech.cmm.util.ReqUtils;
import kr.letech.sys.mnm.service.MenuMngService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	/**
	 * 메뉴 관련 서비스
	 */
	@Resource(name = "menuMngService")
	private MenuMngService menuMngService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/index.do", method={RequestMethod.GET, RequestMethod.POST})
	public String index(HttpServletRequest request, Model model)throws Exception {
		Map params = ReqUtils.getParameterMap(request);
		
		
//		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		model.addAttribute("loginVO", loginVO);
		
//		params.put("use_yn", "Y");
//		params.put("levl", "1");
//		List mnList = menuMngService.getOneCodeList(params);
//		model.addAttribute("mnList", mnList);
		
		// 현재 날짜 구하기
		DateUtil dt = new DateUtil();
		String now_date = (String)params.get("now_date");
		if(now_date == null || now_date.equals("")){
			model.addAttribute("now_date", dt.nowDate());
		}else{
			model.addAttribute("now_date", now_date);
		}
		
		if(params.get("view_type") == null || params.get("view_type").equals("")){
			model.addAttribute("view_type", "month");
		}else{
			model.addAttribute("view_type", params.get("view_type"));
		}
		
		return "letech/home/index";
	}
	
}
