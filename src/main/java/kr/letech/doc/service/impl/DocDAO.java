package kr.letech.doc.service.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.letech.cmm.service.impl.AbstractDAO;

@Repository("docDAO")
public class DocDAO extends AbstractDAO {

	/**
	 * 상위코드, 하위코드에 해당하는 문서코드를 반환
	 * 작성자 : JO MIN SOO
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map getDocCode(Map params) throws Exception {
		return (Map)getObject("doc.getDocCode", params);
	}
}
