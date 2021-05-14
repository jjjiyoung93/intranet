package kr.letech.aprv;

import java.util.List;
import java.util.Map;

public class TmpPayItemVO {
	
	private String aprvNo;
	private String itemNo; // 받는 번호
	private String cd1;
	private String cd2;
	private String cnt;
	private String stDt;
	private String edDt;
	private String price;
	private String amt;
	private String rmk1;
	private String rmk2;
	private String rmk3;
	private String rmk4;
	private String itemNoAdd; // 생성된 번호
	
	public String getItemNoAdd() {
		return itemNoAdd;
	}
	public void setItemNoAdd(String itemNoAdd) {
		this.itemNoAdd = itemNoAdd;
	}
	public String getAprvNo() {
		return aprvNo;
	}
	public void setAprvNo(String aprvNo) {
		this.aprvNo = aprvNo;
	}
	public String getItemNo() {
		return itemNo;
	}
	public void setItemNo(String itemNo) {
		this.itemNo = itemNo;
	}
	public String getCd1() {
		return cd1;
	}
	public void setCd1(String cd1) {
		this.cd1 = cd1;
	}
	public String getCd2() {
		return cd2;
	}
	public void setCd2(String cd2) {
		this.cd2 = cd2;
	}
	public String getCnt() {
		return cnt;
	}
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	public String getStDt() {
		return stDt;
	}
	public void setStDt(String stDt) {
		this.stDt = stDt;
	}
	public String getEdDt() {
		return edDt;
	}
	public void setEdDt(String edDt) {
		this.edDt = edDt;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getAmt() {
		return amt;
	}
	public void setAmt(String amt) {
		this.amt = amt;
	}
	public String getRmk1() {
		return rmk1;
	}
	public void setRmk1(String rmk1) {
		this.rmk1 = rmk1;
	}
	public String getRmk2() {
		return rmk2;
	}
	public void setRmk2(String rmk2) {
		this.rmk2 = rmk2;
	}
	public String getRmk3() {
		return rmk3;
	}
	public void setRmk3(String rmk3) {
		this.rmk3 = rmk3;
	}
	public String getRmk4() {
		return rmk4;
	}
	public void setRmk4(String rmk4) {
		this.rmk4 = rmk4;
	}
	@Override
	public String toString() {
		return "TmpPayItemVO [aprvNo=" + aprvNo + ", itemNo=" + itemNo + ", cd1=" + cd1 + ", cd2=" + cd2 + ", cnt="
				+ cnt + ", stDt=" + stDt + ", edDt=" + edDt + ", price=" + price + ", amt=" + amt + ", rmk1=" + rmk1
				+ ", rmk2=" + rmk2 + ", rmk3=" + rmk3 + ", rmk4=" + rmk4 + ", itemNoAdd=" + itemNoAdd + "]";
	}
	
}
