package kr.letech.doc.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import kr.letech.doc.service.DocService;

@Service("docService")
public class DocServiceImpl implements DocService {

	@Resource(name="docDAO")
	private DocDAO docDAO;
	
	/**
	* 결재코드에 해당하는 문서 코드를 반환
	* 작성자 : JO MIN SOO
	* @param params
	* @return
	* @throws Exception
	*/
	@Override
	public String getDocCode(Map params) throws Exception {
		String cd1 = (String) params.get("APRV_TYPE_CD");
		String cd2 = (String) params.get("APRV_TYPE_DTIL_CD");
		
		String docCode = null;
		
		if("CD0001011".equals(cd1)) { // 휴가신청
			docCode = "letech/doc/code/code_frogh";
		} else if("CD0001013".equals(cd1)) { // 유연근무제신청
			if("CD0001013001".equals(cd2)) { // 시차출퇴근제
				docCode = "letech/doc/code/code_flexWrkSyst";
			}
		} else if("CD0001008".equals(cd1)) { // 품의서
			docCode = "letech/doc/code/code_pttn";
		} else if("CD0001009".equals(cd1)) { // 출장
			if("CD0001009001".equals(cd2)) { // 출장정산(국내_법인)
				docCode = "letech/doc/code/code_bztrpAdjsCpr";
			} else if("CD0001009002".equals(cd2)) { // 출장정산(국내_일반)
				docCode = "letech/doc/code/code_bztrpAdjsGnrl";
			} else if("CD0001009004".equals(cd2)) { // 출장정산(국내)
				docCode = "letech/doc/code/code_bztrpAdjsdomt";
			}
		} else if("CD0001015".equals(cd1)) { // 도서구매신청
			docCode = "letech/doc/code/code_bksBuyAplf";
		} else if("CD0001016".equals(cd1)) { // 교육훈련신청
			docCode = "letech/doc/code/code_educTrain";
		} else if("CD0001010".equals(cd1)) {
			docCode = "letech/doc/code/code_tmpPay"; // 가지급금
		}
		
		if(docCode == null) {
			docCode = "letech/doc/code/code_default";
		}
		
		return docCode;
	}
	
	/**
	* 결재코드에 해당하는 보고서 코드를 반환
	* 작성자 : JO MIN SOO
	* @param params
	* @return
	* @throws Exception
	*/
	@Override
	public String getReportCode(Map params) throws Exception {
		String cd1 = (String) params.get("APRV_TYPE_CD");
		String cd2 = (String) params.get("APRV_TYPE_DTIL_CD");
		String stddYr = (String)params.get("STDD_YR");
		String reportCode = null;
		int stddYrNum = 0;
		if(StringUtils.isNotEmpty(stddYr)) {
			stddYrNum = Integer.parseInt(stddYr); 
		}
		if("CD0001011".equals(cd1)) { // 휴가신청
			if(stddYrNum < 2022) {
				reportCode = "letech/doc/report/report_frogh_old";
			}else {
				reportCode = "letech/doc/report/report_frogh";
			}
		} else if("CD0001013".equals(cd1)) { // 유연근무제신청
			if("CD0001013001".equals(cd2)) { // 시차출퇴근제
				reportCode = "letech/doc/report/report_flexWrkSyst";
			}
		} else if("CD0001008".equals(cd1)) { // 품의서
			reportCode = "letech/doc/report/report_pttn";
		} else if("CD0001009".equals(cd1)) { // 출장
			if("CD0001009001".equals(cd2)) { // 출장정산(국내_법인)
				reportCode = "letech/doc/report/report_bztrpAdjsCpr";
			} else if("CD0001009002".equals(cd2)) { // 출장정산(국내_일반)
				reportCode = "letech/doc/report/report_bztrpAdjsGnrl";
			}
		} else if("CD0001015".equals(cd1)) { // 도서구매신청
			reportCode = "letech/doc/report/report_bksBuyAplf";
		} else if("CD0001016".equals(cd1)) { // 교육훈련신청
			reportCode = "letech/doc/report/report_educTrain";
		} else if("CD0001007".equals(cd1)) { // 지출결의
			reportCode = "letech/doc/report/report_bizplay";
		} else if("CD0001010".equals(cd1)) { // 가지급금
			reportCode = "letech/doc/report/report_tmppay";
		}
		
		if(reportCode == null) {
			reportCode = "letech/doc/report/report_default";
		}
		
		return reportCode;
	}
	
	/**
	* 결재코드에 해당하는 문서 데이터를 반환
	* 작성자 : JO MIN SOO
	* @param params
	* @return
	* @throws Exception
	*/
	@Override
	public Map getDocData(Map params) throws Exception {
		String cd1 = (String) params.get("APRV_TYPE_CD");
		String cd2 = (String) params.get("APRV_TYPE_DTIL_CD");
		
		Map docMap = null;
		
		if("CD0001011".equals(cd1)) { // 휴가신청
			docMap = docDAO.getFrogh(params);
		} else if("CD0001013".equals(cd1)) { // 유연근무제신청
			if("CD0001013001".equals(cd2)) { // 시차출퇴근제
				docMap = docDAO.getFlexWrkSyst(params);
			}
		} else if("CD0001008".equals(cd1)) { // 품의서
			docMap = docDAO.getPttn(params);
		} else if("CD0001009".equals(cd1)) { // 출장
			if("CD0001009001".equals(cd2) || "CD0001009002".equals(cd2)) { // 출장정산(국내)-법인,일반
				docMap = docDAO.getBztrpAdjs(params);
				List itemList = docDAO.getBztrpAdjsItem(params);
				if(!itemList.isEmpty()) {
					docMap.put("items", itemList);
				}
			}
		} else if("CD0001015".equals(cd1)) { // 도서구매신청
			docMap = docDAO.getBksBuyAplf(params);
		} else if("CD0001016".equals(cd1)) { // 교육훈련신청
			docMap = docDAO.getEducTrain(params);
		} else if("CD0001010".equals(cd1)) { // 가지급금
			docMap = docDAO.getTmpPay(params);
			List itemList = docDAO.getTmpPayItem(params);
			if(itemList != null && !itemList.isEmpty()) {
				docMap.put("tmpPayItemList", itemList);
			}
		}
		
		return docMap;
	}

	@Override
	public String getDocTemplate(Map params) throws Exception {
		String cd1 = (String) params.get("APRV_TYPE_CD");
		String cd2 = (String) params.get("APRV_TYPE_DTIL_CD");
		
		String docTemplate = null;
		
		if("CD0001010".equals(cd1)) { //가지급금
			docTemplate = docDAO.getDocTemplate(params);
		}
			
		return docTemplate;
	}

	
}
