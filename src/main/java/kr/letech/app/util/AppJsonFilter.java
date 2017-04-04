/******************************************************************
 * Copyright LETECH 2016
 ******************************************************************/
package kr.letech.app.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.letech.app.service.AppLoginService;
import kr.letech.cmm.util.EgovStringUtil;
import kr.letech.cmm.util.ReqUtils;

/**
 * <pre>
 * FileName: AppJsonFilter.java
 * Package : kr.letech.app.util
 * 
 * 앱 접속 관련 인증번호 필터
 *
 * </pre>
 * 
 * @author : ksk
 * @date : 2016. 4. 27.
 */
public class AppJsonFilter implements Filter {

	private FilterConfig config;

	private static final Logger LOGGER = LoggerFactory.getLogger(AppJsonFilter.class);

	@Override
	public void destroy() {
	}

	/**
	 * <pre>
	 * 
	 * 인증 필터
	 *
	 * </pre>
	 * 
	 * @author : ksk
	 * @date : 2016. 4. 27.
	 * @param request
	 * @param response
	 * @param filterChain
	 * @throws IOException
	 * @throws ServletException
	 */
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain)
			throws IOException, ServletException {

		LOGGER.info("AppJsonFilter called...");

		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;

		httpRequest.setCharacterEncoding("utf-8");
		httpResponse.setCharacterEncoding("utf-8");

		ApplicationContext act = WebApplicationContextUtils
				.getRequiredWebApplicationContext(config.getServletContext());
		AppLoginService appLoginService = (AppLoginService) act.getBean("appLoginService");

		Map<String, Object> params = ReqUtils.getParameterMap(httpRequest);
		String requestURL = httpRequest.getRequestURI();

		ParameterWrapper parameterWrapper = new ParameterWrapper(httpRequest);

		PrintWriter out = httpResponse.getWriter();
		EgovMap userMap = new EgovMap();

		String ussId = (String) params.get("ussId");
		String ussPwd = (String) params.get("ussPwd");
		String certNo = (String) params.get("certNo");
		String tokenKey = (String) params.get("tokenKey");
		boolean isAuth = false;

		try {
			// url이 로그인 페이지이고 id, pw 있는경우 또는 url이 로그인 페이지가 아니고 certNo, tokenKey 있는경우 정상경로 판단
			if (requestURL.contains("appLogin.json") 
					|| (!requestURL.contains("appLogin.json") && !EgovStringUtil.isEmpty(certNo) && !EgovStringUtil.isEmpty(tokenKey))) {

				// 로그인 페이지의 경우 certNo 초기화(뒤로버튼 접근 시) 
				if (requestURL.contains("appLogin.json") && !EgovStringUtil.isEmpty(ussId) && !EgovStringUtil.isEmpty(ussPwd)) {
					parameterWrapper.setParameter("certNo", "");
					params.put("certNo", "");
				}
				
				userMap = (EgovMap) appLoginService.getSelectAppLogin(params);

				ussId = (String) userMap.get("ussId");
				if (EgovStringUtil.isEmpty(ussId)) {
					// 로그인 실패
					userMap.put("resultCode", "301");
					userMap.put("resultMsg", "인증에 실패하였습니다.");
				} else {
					// 로그인 성공
					isAuth = true;
				}
			} else {
				// URI Error
				userMap.put("resultCode", "302");
				userMap.put("resultMsg", "잘못된 접근입니다.");
			}

			if (isAuth) {
				parameterWrapper.setParameter("resultCode", "200");
				parameterWrapper.setParameter("resultMsg", "");

				filterChain.doFilter((HttpServletRequest) parameterWrapper, httpResponse);
			} else {
				this.convertMap2Json(out, userMap);
			}

		} catch (Exception e) {
			LOGGER.error("Service Error : {}", e.getMessage());
			userMap.put("resultCode", "301");
			userMap.put("resultMsg", "인증에 실패하였습니다.");

			this.convertMap2Json(out, userMap);
			return;
		} finally {
			out.close();
		}
	}

	/**
	 * <pre>
	 * 
	 * convert map to json & printwriter
	 *
	 * </pre>
	 * 
	 * @author : ksk
	 * @date : 2016. 4. 27.
	 * @param out
	 * @param userMap
	 */
	@SuppressWarnings("unchecked")
	private void convertMap2Json(PrintWriter out, EgovMap userMap) {
		JSONObject obj = new JSONObject();
		obj.putAll(userMap);

		out.write(obj.toString());
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		this.config = filterConfig;
	}
}
