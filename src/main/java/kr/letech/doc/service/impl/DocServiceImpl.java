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
	* 상위코드, 하위코드에 해당하는 문서코드를 반환
	* 작성자 : JO MIN SOO
	* @param params
	* @return
	* @throws Exception
	*/
	@Override
	public Map getDocCode(Map params) throws Exception {
		return docDAO.getDocCode(params);
	}

	/**
	* 보고서 양식을 반환
	* 작성자 : JO MIN SOO
	* @param params
	* @return
	* @throws Exception
	*/
	@Override
	public Map getDocReport(Map params) throws Exception {
		return docDAO.getDocReport(params);
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
