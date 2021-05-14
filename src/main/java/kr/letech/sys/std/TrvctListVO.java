package kr.letech.sys.std;

import java.util.List;

public class TrvctListVO {
	
	private List<TrvctVO> trcsList;

	public List<TrvctVO> getTrcsList() {
		return trcsList;
	}

	public void setTrcsList(List<TrvctVO> trcsList) {
		this.trcsList = trcsList;
	}

	@Override
	public String toString() {
		return "TrvctListVO [trcsList=" + trcsList + "]";
	}
	
	

}
