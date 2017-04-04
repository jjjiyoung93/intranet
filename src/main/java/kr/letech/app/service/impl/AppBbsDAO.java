package kr.letech.app.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.letech.cmm.service.impl.AbstractDAO;

@Repository("appBbsDAO")
public class AppBbsDAO extends AbstractDAO {

	/**
	 * 공지사항 목록 (앱)
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<EgovMap> getSelectAppBbsPageInfo(Map<String, Object> params, int offSet, int limit) throws Exception {

		return getList("appBbs.getSelectAppBbsPageInfo", params, offSet, limit);
	}

	/**
	 * 공지사항 상세 (앱)
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public EgovMap getSelectAppBbsView(Map<String, Object> params) throws Exception {
		return (EgovMap) getObject("getSelectAppBbsView", params);
	}

	/**
	 * 결제관리 목록 (앱)
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<EgovMap> getSelectAppPaymentPageInfo(Map<String, Object> params, int offSet, int limit)
			throws Exception {

		return getList("appBbs.getSelectAppPaymentPageInfo", params, offSet, limit);
	}

	/**
	 * 결제관리 상세 (앱)
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public EgovMap getSelectAppPaymentView(Map<String, Object> params) throws Exception {
		return (EgovMap) getObject("appBbs.getSelectAppPaymentView", params);
	}

	/**
	 * 결제라인관리 상세 (앱)
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<EgovMap> getSelectAppPaymentLineView(Map<String, Object> params, int offSet, int limit)
			throws Exception {
		return getList("appBbs.getSelectAppPaymentListView", params, offSet, limit);
	}

}
