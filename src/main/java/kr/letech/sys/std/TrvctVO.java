package kr.letech.sys.std;

public class TrvctVO {
	
	private String regnCd1;
	private String regnCd1Nm;
	private String regnCd2;
	private String regnCd2Nm;
	private Double dstnc;
	private Integer trcs;
	public String getRegnCd1() {
		return regnCd1;
	}
	public void setRegnCd1(String regnCd1) {
		this.regnCd1 = regnCd1;
	}
	public String getRegnCd1Nm() {
		return regnCd1Nm;
	}
	public void setRegnCd1Nm(String regnCd1Nm) {
		this.regnCd1Nm = regnCd1Nm;
	}
	public String getRegnCd2() {
		return regnCd2;
	}
	public void setRegnCd2(String regnCd2) {
		this.regnCd2 = regnCd2;
	}
	public String getRegnCd2Nm() {
		return regnCd2Nm;
	}
	public void setRegnCd2Nm(String regnCd2Nm) {
		this.regnCd2Nm = regnCd2Nm;
	}
	public Double getDstnc() {
		return dstnc;
	}
	public void setDstnc(Double dstnc) {
		this.dstnc = dstnc;
	}
	public Integer getTrcs() {
		return trcs;
	}
	public void setTrcs(Integer trcs) {
		this.trcs = trcs;
	}
	@Override
	public String toString() {
		return "TrvctVO [regnCd1=" + regnCd1 + ", regnCd1Nm=" + regnCd1Nm + ", regnCd2=" + regnCd2 + ", regnCd2Nm="
				+ regnCd2Nm + ", dstnc=" + dstnc + ", trcs=" + trcs + "]";
	}
}
