package kr.letech.sample.pkg.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.letech.cmm.service.impl.AbstractDAO;

/**
 * mybitis 연동한 참고용 SampleDAO
 * @author jwchoi
 *
 */
@Repository("sampleDAO")
public class SampleDAO extends AbstractDAO {

	/**
	 * 샘플 등록
	 * @param params
	 */
	public void sampleInsert(Map params){
		insert("sampleDAO.insert", params);
	}

	/**
	 * 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List sampleList(Map params) throws Exception {
		return getList("sampleDAO.getList", params);
	}

}
