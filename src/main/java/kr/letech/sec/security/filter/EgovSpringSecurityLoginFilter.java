package kr.letech.sec.security.filter;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.letech.cmm.LoginVO;
import kr.letech.sys.bbs.service.BbsMngService;
import kr.letech.sys.mnm.service.MenuMngService;
import kr.letech.uat.uia.service.EgovLoginService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.context.support.WebApplicationContextUtils;

import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;

/**
 *
 * @author 공통서비스 개발팀 서준식
 * @since 2011. 8. 29
 * @version 1.0
 * @see
 *
 * <pre>
 * 개정이력(Modification Information)
 *
 *     수정일                 수정자        	  수정내용
 *  -----------    --------   ---------------------------
 *  2011.08.29    	 서준식        	 최초생성
 *  2011.12.12      유지보수        사용자 로그인 정보 간섭 가능성 문제(멤버 변수 EgovUserDetails userDetails를 로컬변수로 변경)
 *  2014.03.07      유지보수        로그인된 상태에서 다시 로그인 시 미처리 되는 문제 수정 (로그인 처리 URL 파라미터화)
 *
 *  </pre>
 */

public class EgovSpringSecurityLoginFilter implements Filter {

	private FilterConfig config;

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovSpringSecurityLoginFilter.class);

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

		LOGGER.info("EgovSpringSecurityLoginFilter called...");

		// 로그인 URL
		String loginURL = config.getInitParameter("loginURL");
		loginURL = loginURL.replaceAll("\r", "").replaceAll("\n", "");

		String loginProcessURL = config.getInitParameter("loginProcessURL");
		loginProcessURL = loginProcessURL.replaceAll("\r", "").replaceAll("\n", "");

		ApplicationContext act = WebApplicationContextUtils.getRequiredWebApplicationContext(config.getServletContext());
		EgovLoginService loginService = (EgovLoginService) act.getBean("loginService");
		MenuMngService menuMngService = (MenuMngService) act.getBean("menuMngService");
		//TODO 게시판 필요정보
		BbsMngService bbsMngService = (BbsMngService) act.getBean("bbsMngService");
//		EgovMessageSource egovMessageSource = (EgovMessageSource) act.getBean("egovMessageSource");

		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		HttpSession session = httpRequest.getSession();
		//String isLocallyAuthenticated = (String)session.getAttribute("isLocallyAuthenticated");
		String isRemotelyAuthenticated = (String) session.getAttribute("isRemotelyAuthenticated");

		String requestURL = ((HttpServletRequest) request).getRequestURI();

		//스프링 시큐리티 인증이 처리 되었는지 EgovUserDetailsHelper.getAuthenticatedUser() 메서드를 통해 확인한다.
		//context-common.xml 빈 설정에 egovUserDetailsSecurityService를 등록 해서 사용해야 정상적으로 동작한다.
		if (EgovUserDetailsHelper.getAuthenticatedUser() == null || requestURL.contains(loginProcessURL)) {

			if (isRemotelyAuthenticated != null && isRemotelyAuthenticated.equals("true")) {
				try {
					//세션 토큰 정보를 가지고 DB로부터 사용자 정보를 가져옴
					LoginVO loginVO = (LoginVO) session.getAttribute("loginVOForDBAuthentication");
					loginVO = loginService.actionLoginByEsntlId(loginVO);

					if (loginVO != null && loginVO.getId() != null && !loginVO.getId().equals("")) {
						//세션 로그인
						session.setAttribute("loginVO", loginVO);

						//로컬 인증결과 세션에 저장
						session.setAttribute("isLocallyAuthenticated", "true");

						//스프링 시큐리티 로그인
						//httpResponse.sendRedirect(httpRequest.getContextPath() + "/j_spring_security_check?j_username=" + loginVO.getUserSe() + loginVO.getId() + "&j_password=" + loginVO.getUniqId());

						UsernamePasswordAuthenticationFilter springSecurity = null;

						Map<String, UsernamePasswordAuthenticationFilter> beans = act.getBeansOfType(UsernamePasswordAuthenticationFilter.class);
						if (beans.size() > 0) {
							springSecurity = (UsernamePasswordAuthenticationFilter) beans.values().toArray()[0];
						} else {
							LOGGER.error("No AuthenticationProcessingFilter");
							throw new IllegalStateException("No AuthenticationProcessingFilter");
						}
						//springSecurity.setContinueChainBeforeSuccessfulAuthentication(false);	// false 이면 chain 처리 되지 않음.. (filter가 아닌 경우 false로...)

						LOGGER.debug("before security filter call....");
						//2015-10-16 사용자 정보를 가져오는 부분수정 jwchoi
//						springSecurity.doFilter(new RequestWrapperForSecurity(httpRequest, loginVO.getUserSe() + loginVO.getId(), loginVO.getUniqId()), httpResponse, chain);
						springSecurity.doFilter(new RequestWrapperForSecurity(httpRequest, loginVO.getId(), loginVO.getUniqId()), httpResponse, chain);
						LOGGER.debug("after security filter call....");

					}

				} catch (Exception ex) {
					//DB인증 예외가 발생할 경우 로그를 남기고 로컬인증을 시키지 않고 그대로 진행함.
					LOGGER.debug("Local authentication Fail : {}", ex.getMessage());
				}

			} else if (isRemotelyAuthenticated == null) {
				if (requestURL.contains(loginProcessURL)) {

					String password = httpRequest.getParameter("password");
					
					// 보안점검 후속 조치(Password 검증)
					if (password == null || password.equals("") || password.length() < 4 || password.length() > 20) {
//						httpRequest.setAttribute("message", egovMessageSource.getMessage("fail.common.login.password"));
						RequestDispatcher dispatcher = httpRequest.getRequestDispatcher(loginURL);
						dispatcher.forward(httpRequest, httpResponse);

						//chain.doFilter(request, response);

						return;
					}

					LoginVO loginVO = new LoginVO();

					loginVO.setId(httpRequest.getParameter("id"));
					loginVO.setPassword(password);
					loginVO.setUserSe(httpRequest.getParameter("userSe"));

					try {

						//사용자 입력 id, password로 DB 인증을 실행함
						loginVO = loginService.actionLogin(loginVO);

						if (loginVO != null && loginVO.getId() != null && !loginVO.getId().equals("")) {
							Map params = new HashMap();
							params.put("levl","1");
							params.put("use_yn","Y");
							List mnList = menuMngService.getMnList(params);
							
							session.setAttribute("mnList", mnList);
							
							params.put("levl","2");
//							List mnList2 = menuMngService.getOneCodeList(params);
							List mnList2 = menuMngService.getMnList(params);
							
							//TODO 게시판 정보 불러오기
							List bbsTabList = bbsMngService.get00List(params);
							int iMnList2Size = mnList2.size();
							int iBbsTabListSize = bbsTabList.size();
							int iRemoveInd = 0;
							for(int i=0; i < iMnList2Size; i++){
								Map mnMap2 = (Map) mnList2.get(i);
								String sMn = String.valueOf(mnMap2.get("MN"));
								if("MN0020".equals(sMn)){
										
									String sMnHref = String.valueOf(mnMap2.get("MN_HREF"));
									String sUseYn = String.valueOf(mnMap2.get("USE_YN"));
									String sMnVal = String.valueOf(mnMap2.get("MN_VAL"));
									String sMnType = String.valueOf(mnMap2.get("MN_TYPE"));
									String sUpMn = String.valueOf(mnMap2.get("UP_MN"));
									String sLevl = String.valueOf(mnMap2.get("LEVL"));
									
									for(int j=0; j < iBbsTabListSize; j++){
										Map iBbsTabMap = (Map) bbsTabList.get(j);
										
										Map resultMap = new HashMap();
										
										resultMap.put("MN_HREF", sMnHref+"?bbs_id="+iBbsTabMap.get("BBS_ID"));
										resultMap.put("MN_ORD", iBbsTabMap.get("BBS_ORD"));
										resultMap.put("USE_YN", sUseYn);
										resultMap.put("MN_VAL", sMnVal);
										resultMap.put("MN_TYPE", sMnType);
										resultMap.put("UP_MN", sUpMn);
										resultMap.put("MN_NM", iBbsTabMap.get("BBS_NM"));
										resultMap.put("MN", sMn);
										resultMap.put("LEVL", sLevl);

										mnList2.add(resultMap);
									}
									iRemoveInd = i;
								}
							}
							
							mnList2.remove(iRemoveInd);
							
							session.setAttribute("mnList2", mnList2);
							
							params.put("levl","3");
							List mnList3 = menuMngService.getOneCodeList(params);
							session.setAttribute("mnList3", mnList3);
							
							//세션 로그인
							session.setAttribute("loginVO", loginVO);

							//로컬 인증결과 세션에 저장
							session.setAttribute("isLocallyAuthenticated", "true");

							//스프링 시큐리티 로그인
							//httpResponse.sendRedirect(httpRequest.getContextPath() + "/j_spring_security_check?j_username=" + loginVO.getUserSe() + loginVO.getId() + "&j_password=" + loginVO.getUniqId());

							UsernamePasswordAuthenticationFilter springSecurity = null;

							Map<String, UsernamePasswordAuthenticationFilter> beans = act.getBeansOfType(UsernamePasswordAuthenticationFilter.class);
							if (beans.size() > 0) {
								springSecurity = (UsernamePasswordAuthenticationFilter) beans.values().toArray()[0];
							} else {
								LOGGER.error("No AuthenticationProcessingFilter");
								throw new IllegalStateException("No AuthenticationProcessingFilter");
							}
							//springSecurity.setContinueChainBeforeSuccessfulAuthentication(false);	// false 이면 chain 처리 되지 않음.. (filter가 아닌 경우 false로...)

							LOGGER.debug("before security filter call....");
							//2015-10-16 사용자 정보를 가져오는 부분수정
//							springSecurity.doFilter(new RequestWrapperForSecurity(httpRequest, loginVO.getUserSe() + loginVO.getId(), loginVO.getUniqId()), httpResponse, chain);
							springSecurity.doFilter(new RequestWrapperForSecurity(httpRequest, loginVO.getId(), loginVO.getUniqId()), httpResponse, chain);
							LOGGER.debug("after security filter call....");

						} else {
							//사용자 정보가 없는 경우 로그인 화면으로 redirect 시킴
//							httpRequest.setAttribute("message", egovMessageSource.getMessage("fail.common.login"));
							RequestDispatcher dispatcher = httpRequest.getRequestDispatcher(loginURL);
							dispatcher.forward(httpRequest, httpResponse);
							
							//chain.doFilter(request, response);

							return;

						}

					} catch (Exception ex) {
						//DB인증 예외가 발생할 경우 로그인 화면으로 redirect 시킴
						LOGGER.error("Login Exception : {}", ex.getCause(), ex);
//						httpRequest.setAttribute("message", egovMessageSource.getMessage("fail.common.login"));
						RequestDispatcher dispatcher = httpRequest.getRequestDispatcher(loginURL);
						dispatcher.forward(httpRequest, httpResponse);
						//chain.doFilter(request, response);

						return;

					}
					return;
				}

			}
		}else{
			if(requestURL.contains("Popup.do") || requestURL.contains("Ajax.do") || requestURL.contains("Tran.do")){
			}else{
				try{
					Map params = new HashMap();
					
					/** 메뉴타이틀 및 네비게이션 정보 조회 Start **/
					String menu_id = request.getAttribute("menu_id3")==null?request.getParameter("menu_id3"):(String)request.getAttribute("menu_id3");
					if(menu_id == null || menu_id.equals("")){
						menu_id = request.getAttribute("menu_id2")==null?request.getParameter("menu_id2"):(String)request.getAttribute("menu_id2");
					}
					if( !"".equals(menu_id) && null != menu_id ){
						params.put("menu_id", menu_id);
						Map titleNaviMap = menuMngService.getTitleAndNaviInfo(params);
						request.setAttribute("titleNaviMap", titleNaviMap);
					}
					/** 메뉴타이틀 및 네비게이션 정보 조회 End **/
				} catch (Exception ex){
					RequestDispatcher dispatcher = httpRequest.getRequestDispatcher(loginURL);
					dispatcher.forward(httpRequest, httpResponse);
					return;
				}
			}
		}

		chain.doFilter(request, response);
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		this.config = filterConfig;
	}
}

class RequestWrapperForSecurity extends HttpServletRequestWrapper {
	private String username = null;
	private String password = null;

	public RequestWrapperForSecurity(HttpServletRequest request, String username, String password) {
		super(request);

		this.username = username;
		this.password = password;
	}

	@Override
	public String getRequestURI() {
		return ((HttpServletRequest) super.getRequest()).getContextPath() + "/j_spring_security_check";
	}

	@Override
	public String getParameter(String name) {
		if (name.equals("j_username")) {
			return username;
		}

		if (name.equals("j_password")) {
			return password;
		}

		return super.getParameter(name);
	}
}
