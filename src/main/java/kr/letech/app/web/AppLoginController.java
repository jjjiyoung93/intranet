package kr.letech.app.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.letech.app.service.AppLoginService;
import kr.letech.cmm.util.ReqUtils;

@Controller
public class AppLoginController {

	@Resource(name = "appLoginService")
	private AppLoginService appLoginService;

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/sample/appLogin.json")
	public String appLogin(HttpServletRequest request, ModelMap model) throws Exception {

		Map<String, Object> params = ReqUtils.getParameterMap(request);

		String viewName = "jsonView";
		model.addAllAttributes(appLoginService.getSelectAppLogin(params));
		return viewName;
	}

	@RequestMapping(value = "/sample/setPushSetting.json")
	public String setPushSetting(HttpServletRequest request, ModelMap model) throws Exception {
		String viewName = "jsonView";
		return viewName;
	}

	// 푸시 셋팅정보 호출
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/sample/getPushInfo.json")
	public String getPushInfo(HttpServletRequest request, ModelMap model) throws Exception {

		Map<String, Object> params = ReqUtils.getParameterMap(request);

		String viewName = "jsonView";
		model.addAllAttributes(appLoginService.getSelectSettingInfo(params));

		return viewName;
	}

}
