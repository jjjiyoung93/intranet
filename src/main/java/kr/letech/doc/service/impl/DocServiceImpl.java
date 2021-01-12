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

}
