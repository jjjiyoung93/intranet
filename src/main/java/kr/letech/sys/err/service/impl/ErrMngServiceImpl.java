package kr.letech.sys.err.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.letech.cmm.util.ObjToConvert;
import kr.letech.cmm.util.PageNavigator;
import kr.letech.cmm.util.ReqUtils;
import kr.letech.sys.err.service.ErrMngService;

@Service("errMngService")
public class ErrMngServiceImpl implements ErrMngService {

	@Resource(name="errMngDAO")
	private ErrMngDAO errMngDAO;

	@Override
	public Map get00PageInfo(Map params) throws Exception {
		String cPage = ReqUtils.getEmptyResult2((String)params.get("cPage"), "1");
		String listCnt = ReqUtils.getEmptyResult2((String)params.get("listCnt"), "10");
		
		int intPage = Integer.parseInt(cPage);			/* 현재페이지 */
		int intListCnt = Integer.parseInt(listCnt);		/* 세로페이징(게시글수)*/
		int pageCnt = 10;								/* 가로페이징(페이지수) */
		int totalCnt = 0;								/* 총 건수  */
		
		totalCnt = errMngDAO.get00ErrListCnt(params);
		
		int offSet = pageCnt * (ObjToConvert.strToint(cPage)-1);
		int limit = ObjToConvert.strToint(cPage)*intListCnt;
		
		// 페이지 네비게이터 생성
		PageNavigator pageNavigator = new PageNavigator(
				intPage		
			   ,"notice00L.do"
			   ,pageCnt		
			   ,intListCnt	
			   ,totalCnt	
			   ,""); // 검색 파라미터
		
		List highList = errMngDAO.get00List(params, offSet, limit);
		
		
				
		Map objectMap = new HashMap();
		
		objectMap.put("highList", highList);
		objectMap.put("cPage", cPage);
		objectMap.put("intListCnt", intListCnt);
		objectMap.put("totalCnt", totalCnt);
		objectMap.put("pageNavigator", pageNavigator.getMakePageScript());
		
		return objectMap;
	}

	@Override
	public Map get00ErrView(Map params) throws Exception {
		return errMngDAO.get00ErrView(params);
	}

	@Override
	public void updateProcessState(Map params) throws Exception {
		errMngDAO.updateProcessState(params);
	}

	@Override
	public void updateCompletion(Map params) throws Exception {
		errMngDAO.updateCompletion(params);
	}

	@Override
	public void updateSave(Map params) throws Exception {
		errMngDAO.updateSave(params);
	}

	@Override
	public Map get01PageInfo(Map params) throws Exception {
		String cPage = ReqUtils.getEmptyResult2((String)params.get("cPage"), "1");
		String listCnt = ReqUtils.getEmptyResult2((String)params.get("listCnt"), "10");
		
		int intPage = Integer.parseInt(cPage);			/* 현재페이지 */
		int intListCnt = Integer.parseInt(listCnt);		/* 세로페이징(게시글수)*/
		int pageCnt = 10;								/* 가로페이징(페이지수) */
		int totalCnt = 0;								/* 총 건수  */
		
		totalCnt = errMngDAO.get01ErrListCnt(params);
		
		int offSet = pageCnt * (ObjToConvert.strToint(cPage)-1);
		int limit = ObjToConvert.strToint(cPage)*intListCnt;
		
		// 페이지 네비게이터 생성
		PageNavigator pageNavigator = new PageNavigator(
				intPage		
			   ,"notice00L.do"
			   ,pageCnt		
			   ,intListCnt	
			   ,totalCnt	
			   ,""); // 검색 파라미터
		
		List highList = errMngDAO.get01List(params, offSet, limit);
		
		
				
		Map objectMap = new HashMap();
		
		objectMap.put("highList", highList);
		objectMap.put("cPage", cPage);
		objectMap.put("intListCnt", intListCnt);
		objectMap.put("totalCnt", totalCnt);
		objectMap.put("pageNavigator", pageNavigator.getMakePageScript());
		
		return objectMap;
	}

	@Override
	public Map get01ErrView(Map params) throws Exception {
		return errMngDAO.get01ErrView(params);
	}
}
