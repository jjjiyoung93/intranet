package kr.letech.doc.service.impl;

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
		} else if("CD0001013".equals(cd1)) { // 근무제신청
			if("CD0001013001".equals(cd2)) { // 유연근무제
				docMap = docDAO.getFlexWrkSyst(params);
			}
		} else if("CD0001008".equals(cd1)) { // 품의서
			docMap = docDAO.getPttn(params);
		} else if("CD0001009".equals(cd1)) { // 출장
			if("CD0001009001".equals(cd2)) { // 출장정산(국내)
				docMap = docDAO.getBztrpAdjs(params);
				docMap.put("items", docDAO.getBztrpAdjsItem(params));
			}
		} else if("CD0001015".equals(cd1)) { // 도서구매신청
			docMap = docDAO.getBksBuyAplf(params);
		} else if("CD0001016".equals(cd1)) { // 교육훈련신청
			docMap = docDAO.getEducTrain(params);
		}
		
		return docMap;
	}
}
