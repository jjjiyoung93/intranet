package kr.letech.vct.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.letech.cmm.util.ObjToConvert;
import kr.letech.cmm.util.PageNavigator;
import kr.letech.cmm.util.ReqUtils;
import kr.letech.vct.service.VctMngService;

@Service("vctMngService")
public class VctMngServiceImpl implements VctMngService {

	/** vctMngDAO */
	@Resource(name = "vctMngDAO")
	private VctMngDAO vctMngDAO;


	@Override
	public Map getVctDayPageingList(Map params) throws Exception {
		
		String cPage = ReqUtils.getEmptyResult2((String)params.get("cPage"), "1");
		String listCnt = ReqUtils.getEmptyResult2((String)params.get("listCnt"), "10");
		String searchGubun = ReqUtils.getEmptyResult2((String)params.get("searchGubun"), "");	
		String searchField = ReqUtils.getEmptyResult2((String)params.get("searchField"), "");
		
		/*검색조건 추가 - 2022.01.05 :BEGIN*/
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy");
		String yearStr = formatter.format(now);
		//기준년도
		
		String searchGubun2 = ReqUtils.getEmptyResult2((String)params.get("searchGubun2"), yearStr);
		
		//기준년도 값이 없을 경우 금년도 값으로 설정
		if(StringUtils.isEmpty((String)params.get("searchGubun2"))) {
			params.put("searchGubun2", searchGubun2);
		}
		
		//재직구분
		String searchGubun3 = ReqUtils.getEmptyResult2((String)params.get("searchGubun3"), "");
		
		String searchGubun4 = ReqUtils.getEmptyResult2((String)params.get("searchGubun4"), "");
		String searchGubun5 = ReqUtils.getEmptyResult2((String)params.get("searchGubun5"), "");
		String searchGubun6 = ReqUtils.getEmptyResult2((String)params.get("searchGubun6"), "");
		/*검색조건 추가 - 2022.01.05 :END*/
		
		int intPage = Integer.parseInt(cPage);			/* 현재페이지 */
		int intListCnt = Integer.parseInt(listCnt);		/* 세로페이징(게시글수)*/
		int pageCnt = 10;								/* 가로페이징(페이지수) */
		int totalCnt = 0;								/* 총 건수  */
		
		//총 건수 조회
		totalCnt = vctMngDAO.getVctDayTotCount(params);
		
		int offSet = intListCnt * (ObjToConvert.strToint(cPage)-1);
		int limit = intListCnt; //ObjToConvert.strToint(cPage)*intListCnt;
		
		// 페이지 네비게이터 생성
		PageNavigator pageNavigator = new PageNavigator(
				intPage		
			   ,""
			   ,pageCnt		
			   ,intListCnt	
			   ,totalCnt	
			   ,""); // 검색 파라미터
		
		List list = vctMngDAO.getVctDayPageList(params, offSet, limit);
		
		Map objectMap = new HashMap();
		
		objectMap.put("resultList", list);
		objectMap.put("cPage", cPage);
		objectMap.put("intListCnt", intListCnt);
		objectMap.put("totalCnt", totalCnt);
		objectMap.put("pageNavigator", pageNavigator.getMakePageScript());
		
		
		return objectMap;
	}


	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public int mergeVctDay(Map params) throws Exception {
		
		int result = 0;
		/* 휴가부여일수 등록/수정 : MERGE 처리 */
		
		result = vctMngDAO.mergeVctDay(params);
		
		return result;
		
	}
	
	
}
