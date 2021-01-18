package kr.letech.doc.service;

import java.util.Map;

public interface DocService {

	/**
	* 상위코드, 하위코드에 해당하는 문서코드를 반환
	* 작성자 : JO MIN SOO
	* @param params
	* @return
	* @throws Exception
	*/
	public Map getDocCode(Map params) throws Exception;

	/**
	* 결재코드에 해당하는 문서 데이터를 반환
	* 작성자 : JO MIN SOO
	* @param params
	* @return
	* @throws Exception
	*/
	public Map getDocData(Map params) throws Exception;;
}
