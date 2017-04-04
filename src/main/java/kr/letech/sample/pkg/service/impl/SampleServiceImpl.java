package kr.letech.sample.pkg.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.letech.sample.pkg.service.SampleService;

@Service("sampleService")
public class SampleServiceImpl implements SampleService {

	/** sampleDAO */
	@Resource(name="sampleDAO")
	private SampleDAO sampleDAO;
	
	@Override
	public void insert(Map params) throws Exception {
		sampleDAO.sampleInsert(params);
	}

	@Override
	public List getlsit(Map params) throws Exception {
		return sampleDAO.sampleList(params);
	}

	@Override
	public void insert2(Map params) {
		sampleDAO.insert("sampleDAO.insert", params);
	}

}
