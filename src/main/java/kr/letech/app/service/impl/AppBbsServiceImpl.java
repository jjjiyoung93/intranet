package kr.letech.app.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.letech.app.service.AppBbsService;
import kr.letech.aprv.service.impl.AprvMngDAO;
import kr.letech.cmm.util.ObjToConvert;
import kr.letech.cmm.util.ReqUtils;

@Service("appBbsService")
public class AppBbsServiceImpl implements AppBbsService {

	/** appBbsDAO */
	@Resource(name = "appBbsDAO")
	private AppBbsDAO appBbsDAO;

	/** aprvMngDAO */
	@Resource(name = "aprvMngDAO")
	private AprvMngDAO aprvMngDAO;

	@Override
	public List<EgovMap> getSelectBbsPageInfo(Map<String, Object> params) throws Exception {
		if (params.get("bbsId") == null || ("").equals(params.get("bbsId")) || params.get("bbsId").equals("BB0001")) {
			params.put("bbsId", "BB0001"); // 기본 공지사항 설정
		} else if (params.get("bbsId").equals("BB0002")) {
			params.put("bbsId", "BB0002"); // 커뮤니티 설정
		} else if (params.get("bbsId").equals("BB0003")) {
			params.put("bbsId", "BB0003"); // Tech 설정
		} else {
			params.put("bbsId", "BB0004"); // 이모저모 설정
		}

		String cPage = ReqUtils.getEmptyResult2((String) params.get("pageInfo"), "1");
		String listCnt = ReqUtils.getEmptyResult2((String) params.get("listCnt"), "10");

		// int intPage = Integer.parseInt(cPage); /* 현재페이지 */
		int intListCnt = Integer.parseInt(listCnt); /* 세로페이징(게시글수)*/
		int pageCnt = 10; /* 가로페이징(페이지수) */

		int offSet = pageCnt * (ObjToConvert.strToint(cPage) - 1);
		int limit = intListCnt;
						// //ObjToConvert.strToint(cPage)*intListCnt;

		List<EgovMap> list = appBbsDAO.getSelectAppBbsPageInfo(params, offSet, limit);

		return list;
	}

	@Override
	public EgovMap getSelectAppBbsView(Map<String, Object> params) throws Exception {

		EgovMap egovMap = appBbsDAO.getSelectAppBbsView(params);

		return egovMap;
	}

	@Override
	public List<EgovMap> getSelectPaymentPageInfo(Map<String, Object> params) throws Exception {

		String cPage = ReqUtils.getEmptyResult2((String) params.get("pageInfo"), "1"); // 현재 페이지 번호
		String listCnt = ReqUtils.getEmptyResult2((String) params.get("listCnt"), "10"); // 페이지당 글갯수

		params.put("uss_id", params.get("ussId"));

		int intPage = Integer.parseInt(cPage); /* 현재페이지 */
		int pageCnt = 10; /* 가로페이징(페이지수) */
		int intListCnt = Integer.parseInt(listCnt); /* 세로페이징(게시글수) */

		int offSet = pageCnt * (ObjToConvert.strToint(cPage) - 1);
		int limit = 10; //ObjToConvert.strToint(cPage)*intListCnt;

		List<EgovMap> list = appBbsDAO.getSelectAppPaymentPageInfo(params, offSet, limit);
		
		return list;
	}
	
	
	@Override
	public String getSelectPaymentPageInfoCnt(Map<String, Object> params) throws Exception {

		int totalCnt = 0;
		totalCnt = aprvMngDAO.getAprvTotalCount(params);
		return Integer.toString(totalCnt);
	}

	

	@Override
	public EgovMap getSelectAppPaymnentView(Map<String, Object> params) throws Exception {

		params.put("aprv_no", params.get("aprvNo"));
		params.put("line_chk", params.get("lineChk"));
		params.put("conf_yn", params.get("confYn"));
		params.put("aprv_emp_no", params.get("aprvEmpNo"));

		if (params.get("line_chk") == null || params.get("conf_yn") == null) {

		} else if (params.get("line_chk").equals("Y") && params.get("conf_yn").equals("N")) {
			// 결재(line_chk -> Y) 이면서 미확인(conf_yn -> N) 일경우
			// 미확인을 확인으로 변경
			aprvMngDAO.updateConfYn(params);
		}

		EgovMap egovMap = appBbsDAO.getSelectAppPaymentView(params);

		return egovMap;
	}

	@Override
	public List<EgovMap> getSelectAppPaymnentLineView(Map<String, Object> params) throws Exception {

		String cPage = ReqUtils.getEmptyResult2((String) params.get("pageInfo"), "1");
		String listCnt = ReqUtils.getEmptyResult2((String) params.get("listCnt"), "10");

		params.put("aprv_no", params.get("aprvNo"));

		// int intPage = Integer.parseInt(cPage); /* 현재페이지 */
		int intListCnt = Integer.parseInt(listCnt); /* 세로페이징(게시글수) */
		int pageCnt = 10; /* 가로페이징(페이지수) */

		int offSet = pageCnt * (ObjToConvert.strToint(cPage) - 1);
		int limit = intListCnt; // ObjToConvert.strToint(cPage)*intListCnt;

		offSet = 0;
		limit = 9999;

		List<EgovMap> list = appBbsDAO.getSelectAppPaymentLineView(params, offSet, limit);
		return list;
	}

}
