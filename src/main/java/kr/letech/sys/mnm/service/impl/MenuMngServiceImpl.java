package kr.letech.sys.mnm.service.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestWrapper;
import org.springframework.stereotype.Service;

import kr.letech.sys.mnm.service.MenuMngService;
import kr.letech.sys.rol.service.impl.RoleMngDAO;

@Service("menuMngService")
public class MenuMngServiceImpl implements MenuMngService {

	@Resource(name="menuMngDAO")
	private MenuMngDAO menuMngDAO;
	
	/**
	 * 권한 정보 조회
	 */
	@Resource(name="roleMngDAO")
	private RoleMngDAO roleMngDAO;
	
	@Override
	public List getOneCodeList(Map params) throws Exception {
		return menuMngDAO.getOneCodeList(params);
	}

	@Override
	public List getCodeList(Map params) throws Exception {
		return menuMngDAO.getCodeList(params);
	}

	@Override
	public Map getCodeView(Map params) throws Exception {
		return menuMngDAO.getCodeView(params);
	}

	@Override
	public void insert(Map params) throws Exception {
		menuMngDAO.insert(params);
	}

	@Override
	public Map getMaxOrdr(Map params) throws Exception {
		return menuMngDAO.getMaxOrdr(params);
	}

	@Override
	public void updateNm(Map params) throws Exception {
		menuMngDAO.updateNm(params);
	}

	@Override
	public void delete(Map params) throws Exception {
		menuMngDAO.delete(params);
	}

	@Override
	public void deleteAll(Map params) throws Exception {
		menuMngDAO.deleteAll(params);
	}

	/**
	 * 메뉴 Tree 구조 리스트 정보
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public List getMenuTreeList(Map params) throws Exception {
		return menuMngDAO.getMenuTreeList(params);
	}
	
	/**
	 * 해당 메뉴의 하위 메뉴까지 삭제
	 * @param params
	 * @throws Exception
	 */
	@Override
	public void mnAllDelete(Map params) throws Exception {
		menuMngDAO.mnAllDelete(params);
	}
	
	/**
	 * 메뉴타이틀 및 네비게이션 정보 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public Map getTitleAndNaviInfo(Map params) throws Exception {
		return menuMngDAO.getTitleAndNaviInfo(params);
	}

	@Override
	public List getMnList(Map params) throws Exception {
		
		
		//패턴 리스트 조회
//		List prtList = roleMngDAO.get00List(params);
		
		//메뉴리스트조회
		
//		params.put("order","desc");
		
//		List<Map> refMnList = menuMngDAO.getOneCodeList(params);
		List<Map> refMnList = menuMngDAO.getMnList(params);
		
		
//		Iterator itr = prtList.iterator();
//		String mn = "sys/";
		int cnt = 0;
		
//		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//		Object principal = auth.getPrincipal();
//		
//		List auList = (List) auth.getAuthorities();
		
		
		/*for(Map f : refMnList){
			while (itr.hasNext()) {
				Map prtMap = (Map) itr.next();
				String prt = (String)prtMap.get("ROLE_PTTRN");
				String rCode = (String)prtMap.get("ROLE_CODE");
				String rType = (String)prtMap.get("ROLE_TY");
					String mn = (String)f.get("MN_VAL");
					Pattern p1 = Pattern.compile(mn);
					Matcher m1 = p1.matcher(prt);
					if(m1.find()){
						List<String> athList = roleMngDAO.getAuthCodeList(rCode);
						for(String authStr : athList){
							if(hasRole(authStr)){
								System.out.println(authStr);
							}else{
								
							}
						}
					}
			}
		}*/
		
		return refMnList;
	}
	
	 protected boolean hasRole(String role) {
	        // get security context from thread local
	        SecurityContext context = SecurityContextHolder.getContext();
	        if (context == null)
	            return false;

	        Authentication authentication = context.getAuthentication();
	        if (authentication == null)
	            return false;

	        for (GrantedAuthority auth : authentication.getAuthorities()) {
	            if (role.equals(auth.getAuthority()))
	                return true;
	        }

	        return false;
	    }
}
