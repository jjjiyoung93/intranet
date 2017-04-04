package kr.letech.sys.mail.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.letech.cmm.util.ReqUtils;
import kr.letech.cmm.util.VarConsts;
import kr.letech.sys.cdm.service.CodeMngService;
import kr.letech.sys.mail.service.MailReceService;

@Controller
public class MailReceController {

	@Resource(name = "mailReceService")
	private MailReceService mailReceService;
	
	@RequestMapping(value = "/uat/uia/mailRec.do", method={RequestMethod.GET, RequestMethod.POST})
	public void mailRec(HttpServletRequest request, ModelMap model) throws Exception {

		Map params = ReqUtils.getParameterMap(request);
		
		//메일 확인시 수신완료 코드와 시간을 수정함
		mailReceService.sendMailConfRece(params);
	}
}
