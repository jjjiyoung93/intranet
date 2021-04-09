package kr.letech.doc.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

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
			if("CD0001009001".equals(cd2)) { // 출장정산(국내)
				docCode = "letech/doc/code/code_bztrpAdjs";
			}
		} else if("CD0001015".equals(cd1)) { // 도서구매신청
			docCode = "letech/doc/code/code_bksBuyAplf";
		} else if("CD0001016".equals(cd1)) { // 교육훈련신청
			docCode = "letech/doc/code/code_educTrain";
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
		
		String reportCode = null;
		
		if("CD0001011".equals(cd1)) { // 휴가신청
			reportCode = "letech/doc/report/report_frogh";
		} else if("CD0001013".equals(cd1)) { // 유연근무제신청
			if("CD0001013001".equals(cd2)) { // 시차출퇴근제
				reportCode = "letech/doc/report/report_flexWrkSyst";
			}
		} else if("CD0001008".equals(cd1)) { // 품의서
			reportCode = "letech/doc/report/report_pttn";
		} else if("CD0001009".equals(cd1)) { // 출장
			if("CD0001009001".equals(cd2)) { // 출장정산(국내)
				reportCode = "letech/doc/report/report_bztrpAdjs";
			}
		} else if("CD0001015".equals(cd1)) { // 도서구매신청
			reportCode = "letech/doc/report/report_bksBuyAplf";
		} else if("CD0001016".equals(cd1)) { // 교육훈련신청
			reportCode = "letech/doc/report/report_educTrain";
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
			if("CD0001009001".equals(cd2)) { // 출장정산(국내)
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
		}
		
		return docMap;
	}

	
}
