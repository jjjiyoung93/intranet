package kr.letech.aprv;

import java.util.List;

public class TmpPayItemListVO {
	
	private List<TmpPayItemVO> tmpPayItemList;

	public List<TmpPayItemVO> getTmpPayItemList() {
		return tmpPayItemList;
	}

	public void setTmpPayItemList(List<TmpPayItemVO> tmpPayItemList) {
		this.tmpPayItemList = tmpPayItemList;
	}

	@Override
	public String toString() {
		return "TmpPayItemListVO [tmpPayItemList=" + tmpPayItemList + "]";
	}
	
}
