package kr.letech.doc.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.letech.aprv.TmpPayItemVO;
import kr.letech.cmm.service.impl.AbstractDAO;

@Repository("docDAO")
public class DocDAO extends AbstractDAO {

	/***** getDocData에서 사용하는 CRUD START *****/
	public Map getFrogh(Map params) throws Exception {
		return (Map)getObject("doc.getFrogh", params);
	}
	public Map getFlexWrkSyst(Map params) throws Exception {
		return (Map)getObject("doc.getFlexWrkSyst", params);
	}
	public Map getEducTrain(Map params) throws Exception {
		return (Map)getObject("doc.getEducTrain", params);
	}
	public Map getBksBuyAplf(Map params) throws Exception {
		return (Map)getObject("doc.getBksBuyAplf", params);
	}
	public Map getPttn(Map params) throws Exception {
		return (Map)getObject("doc.getPttn", params);
	}
	public Map getBztrpAdjs(Map params) throws Exception {
		return (Map)getObject("doc.getBztrpAdjs", params);
	}
	public List getBztrpAdjsItem(Map params) throws Exception {
		return (List)getList("doc.getBztrpAdjsItem", params);
	}
	public int insertFrogh(Map params) throws Exception {
		return (Integer) insert("doc.insertFrogh", params);
	}
	public int insertFlexWrkSyst(Map params) throws Exception {
		return (Integer) insert("doc.insertFlexWrkSyst", params);
	}
	public int insertEducTrain(Map params) throws Exception {
		return (Integer) insert("doc.insertEducTrain", params);
	}
	public int insertBksBuyAplf(Map params) throws Exception {
		return (Integer) insert("doc.insertBksBuyAplf", params);
	}
	public int insertPttn(Map params) throws Exception {
		return (Integer) insert("doc.insertPttn", params);
	}
	public int insertBztrpAdjs(Map params) throws Exception {
		return (Integer) insert("doc.insertBztrpAdjs", params);
	}
	public int insertBztrpAdjsItem(Map params) throws Exception {
		return (Integer) insert("doc.insertBztrpAdjsItem", params);
	}
	public int updateFrogh(Map params) throws Exception {
		return (Integer) update("doc.updateFrogh", params);
	}
	public int updateFlexWrkSyst(Map params) throws Exception {
		return (Integer) update("doc.updateFlexWrkSyst", params);
	}
	public int updateEducTrain(Map params) throws Exception {
		return (Integer) update("doc.updateEducTrain", params);
	}
	public int updateBksBuyAplf(Map params) throws Exception {
		return (Integer) update("doc.updateBksBuyAplf", params);
	}
	public int updatePttn(Map params) throws Exception {
		return (Integer) update("doc.updatePttn", params);
	}
	public int updateBztrpAdjs(Map params) throws Exception {
		return (Integer) update("doc.updateBztrpAdjs", params);
	}
	public int updateBztrpAdjsItem(Map params) throws Exception {
		return (Integer) update("doc.updateBztrpAdjsItem", params);
	}
	public int deleteFrogh(Map params) throws Exception {
		return (Integer) delete("doc.deleteFrogh", params);
	}
	public int deleteFlexWrkSyst(Map params) throws Exception {
		return (Integer) delete("doc.deleteFlexWrkSyst", params);
	}
	public int deleteEducTrain(Map params) throws Exception {
		return (Integer) delete("doc.deleteEducTrain", params);
	}
	public int deleteBksBuyAplf(Map params) throws Exception {
		return (Integer) delete("doc.deleteBksBuyAplf", params);
	}
	public int deletePttn(Map params) throws Exception {
		return (Integer) delete("doc.deletePttn", params);
	}
	public int deleteBztrpAdjs(Map params) throws Exception {
		return (Integer) delete("doc.deleteBztrpAdjs", params);
	}
	public int deleteBztrpAdjsItem(Map params) throws Exception {
		return (Integer) delete("doc.deleteBztrpAdjsItem", params);
	}
	
	/***** getDocData에서 사용하는 CRUD END *****/
	// 가지급금 crud
	public int insertTmpPay(Map params) throws Exception {
		return (Integer) insert("doc.insertTmpPay", params);
	}
	//문서 템플릿 가져오기
	public String getDocTemplate(Map params) throws Exception {
		return (String) getObject("doc.getDocTemplate", params);
	}
	//가지급금 문서 데이터 가져오기
	public Map getTmpPay(Map params) throws Exception {
		return (Map) getObject("doc.getTmpPay", params);
	}
	//가지급금 문서 데이터 수정하기
	public int  updateTmpPay(Map params) throws Exception {
		return (Integer) update("doc.updateTmpPay", params);
	}
	//가지금금 문서 정보 삭제
	public int deleteTmpPay(Map params) throws Exception {
		return (Integer) delete("doc.deleteTmpPay", params);
	}
	//가지급금 상세 사항 입력
	public int insertTmpPayItem(TmpPayItemVO tmpPayItemVO) throws Exception {
		return (Integer) insert("doc.insertTmpPayItem", tmpPayItemVO);
		
	}
	//가지급금 상세 데이터 수정
	public int updateTmpPayItem(TmpPayItemVO tmpPayItemVO) throws Exception {
		return (Integer) update("doc.updateTmpPayItem", tmpPayItemVO);
	}
	//가지급금 상세 데이터 삭제
	public int deleteTmpPayItem(Map params) throws Exception {
		return (Integer) delete("doc.deleteTmpPayItem", params);
	}
	//가지급금 상세 데이터 가져오기
	public List getTmpPayItem(Map params) throws Exception {
		return (List) getList("doc.getTmpPayItem", params);
	}
		
}
