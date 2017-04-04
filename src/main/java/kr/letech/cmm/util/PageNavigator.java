package kr.letech.cmm.util;


/*******************************************************************************
	EX)
	// 생성자 호출
	PageNavigator pageNavigator = new PageNavigator(
		cPage						- 페이지번호
		,"/xxx/xxxL.do"				- URL
		,pagePerBlock				- 블럭당 페이지 수
		,recordPerPage				- 페이지당 레코드 수
		,totalCount					- 레코드의 총 수
		,"&srchItem="+srchItem+"&srchText="+ReqUtils.getEncode(srchText));
									- 파라미터
	int startIndex = pageNavigator.getRecordPerPage() * (cPage - 1);
	시작위치, 페이지당 레코드 수, Map을 매개변수로 전달
	List list = (List)xxxService.getList(startIndex, 
		pageNavigator.getRecordPerPage(), Map args);
	xxxService 에서  원하는 레코드위치를 가져오는 메소드를 이용하여 목록을 얻음. (AbstractDao, Dao getPageList 추가)
	queryForList("xxx.getPageList", hashMap, startIndex, recordPerPage);
 ******************************************************************************/
public class PageNavigator {

	// -------------------------------------------------------------------------
	private int totalRecord;										// 전체 레코드수
	private int recordPerPage;										// 페이지당 레코드수
	private int pagePerBlock;										// 블럭당 페이지수
	private int currentPage;										// 현재페이지
	private String goUrl;											// 이동할 URL
	private String parameter;										// 파라미터
	private String imgFirst = "";// 맨 앞 
	private String imgFirstClss = "";			// 맨 앞 클래스
	private String imgBack = "Prev";			// 뒤
	private String imgBackClss = "  ";				// 뒤 클래스
	private String imgNext = "Next";			// 앞
	private String imgNextClss = " ";				// 앞 클래스
	private String imgEnd = "";	// 맨 뒤
	private String imgEndClss = "";				// 맨 뒤 클래스
	// -------------------------------------------------------------------------	
	
	public PageNavigator(){}
	
	/**
	 * 생성자
	 * @param currentPage 	- 현재 페이지 번호
	 * @param goUrl 		- 목록 액션 URL
	 * @param pagePerBlock 	- 페이지당 블록 수
	 * @param recordPerPage - 한 페이지당 목록 수
	 * @param totalRecord 	- 총 레코드 수
	 * @param parameter 	- 파라미터
	 */
	public PageNavigator (int currentPage, String goUrl, int pagePerBlock,
			int recordPerPage, int totalRecord, String parameter){
		super();
		this.currentPage = currentPage;
		this.goUrl = goUrl;
		this.pagePerBlock = pagePerBlock;
		this.recordPerPage = recordPerPage;
		this.totalRecord = totalRecord;
		this.parameter  = parameter;
	}
	
	/**
	 * 페이지 네비게이터 생성
	 * @return 네비게이터 HTML 
	 */
	public String getMakePage() {
		
		if(totalRecord == 0) return "&nbsp;";
		
		int totalNumOfPage = (totalRecord % recordPerPage == 0) ? 
				totalRecord / recordPerPage :
				totalRecord / recordPerPage + 1;
		
		int totalNumOfBlock = (totalNumOfPage % pagePerBlock == 0) ?
				totalNumOfPage / pagePerBlock :
				totalNumOfPage / pagePerBlock + 1;
		
		int currentBlock = (currentPage % pagePerBlock == 0) ? 
				currentPage / pagePerBlock :
				currentPage / pagePerBlock + 1;
		
		int startPage = (currentBlock - 1) * pagePerBlock + 1;
		int endPage = startPage + pagePerBlock - 1;
		
		if(endPage > totalNumOfPage)
			endPage = totalNumOfPage;
		
		boolean isNext = false;
		boolean isPrev = false;
		
		if(currentBlock < totalNumOfBlock)
			isNext = true;
		if(currentBlock > 1)
			isPrev = true;
		if(totalNumOfBlock == 1){
			isNext = false;
			isPrev = false;
		}
		
		StringBuffer sb = new StringBuffer();
		
		if(currentPage > 1){
			sb.append("<a href='").append(goUrl);
//			sb.append("?cPage=1").append(parameter).append("' ").append(imgFirstClss).append(" >").append(imgFirst).append("</a>&nbsp;&nbsp;&nbsp;");
			sb.append("?cPage=1").append(parameter).append("' ").append(imgFirstClss).append(" class='glyphicon-frist' >").append("</a>&nbsp;&nbsp;&nbsp;");
		}
		
		if (isPrev) {
			int goPrevPage = startPage - pagePerBlock;			
			sb.append("<a href='").append(goUrl);
//			sb.append("?cPage=").append(goPrevPage).append(parameter).append("' ").append(imgBackClss).append(" >").append(imgBack).append("</a>");
			sb.append("?cPage=").append(goPrevPage).append(parameter).append("' ").append(imgBackClss).append(" class='glyphicon-prev' >").append("</a>");
		} else {
			
		}

		for (int i = startPage; i <= endPage; i++) {
			sb.append("&nbsp;");
			if (i == currentPage) {
				sb.append("<font color='orange' size='5'>").append(i).append("</font>");
			} else {
				sb.append("<a href='").append(goUrl);
				sb.append("?cPage=").append(i).append(parameter).append("'>").append(i).append(
						"</a>");
			}
		}
	//	sb.append("&nbsp;<FONT style='font-size: 12px' COLOR=D0D0D0>|</FONT> ");
		sb.append("&nbsp;");

		if (isNext) {
			int goNextPage = startPage + pagePerBlock;

			sb.append("<a href='").append(goUrl);
//			sb.append("?cPage=").append(goNextPage).append(parameter).append("' ").append(imgNextClss).append(" >").append(imgNext).append("</a>");
			sb.append("?cPage=").append(goNextPage).append(parameter).append("' ").append(imgNextClss).append(" class='glyphicon-next' >").append("</a>");
		} else {
			
		}
		
		if(totalNumOfPage > currentPage){
			sb.append("<a href='").append(goUrl);
//			sb.append("?cPage=").append(totalNumOfPage).append(parameter).append("' ").append(imgEndClss).append(" >").append(imgEnd).append("</a>");
			sb.append("?cPage=").append(totalNumOfPage).append(parameter).append("' ").append(imgEndClss).append(" class='glyphicon-end' >").append("</a>");
		}

		return sb.toString();
		
	}
	
	public String getMakePageScript() {
		
		if(totalRecord == 0) return "&nbsp;";
		
		int totalNumOfPage = (totalRecord % recordPerPage == 0) ? 
				totalRecord / recordPerPage :
				totalRecord / recordPerPage + 1;
		
		int totalNumOfBlock = (totalNumOfPage % pagePerBlock == 0) ?
				totalNumOfPage / pagePerBlock :
				totalNumOfPage / pagePerBlock + 1;
		
		int currentBlock = (currentPage % pagePerBlock == 0) ? 
				currentPage / pagePerBlock :
				currentPage / pagePerBlock + 1;
		
		int startPage = (currentBlock - 1) * pagePerBlock + 1;
		int endPage = startPage + pagePerBlock - 1;
		
		if(endPage > totalNumOfPage)
			endPage = totalNumOfPage;
		
		boolean isNext = false;
		boolean isPrev = false;
		
		if(currentBlock < totalNumOfBlock)
			isNext = true;
		if(currentBlock > 1)
			isPrev = true;
		if(totalNumOfBlock == 1){
			isNext = false;
			isPrev = false;
		}
		
		StringBuffer sb = new StringBuffer();
		
		if(currentPage > 1){
//			sb.append("<a href='#' onclick='goPage(\"1\");' ").append(imgFirstClss).append(" >").append(imgFirst).append("</a>&nbsp;&nbsp;&nbsp;");
			sb.append("<a href='#' onclick='goPage(\"1\");' ").append(imgFirstClss).append(" class=''glyphicon glyphicon-chevron-right paging' >").append("</a>");
		}
		
		if (isPrev) {
			int goPrevPage = startPage - pagePerBlock;			
//			sb.append("<a href='#' onclick='goPage(\"").append(goPrevPage).append("\");' ").append(imgBackClss).append(" >").append(imgBack).append("</a>");
			sb.append("<a href='#' onclick='goPage(\"").append(goPrevPage).append("\");' ").append(imgBackClss).append(" class='glyphicon glyphicon-backward paging' >").append("</a>");
		} else {
			
		}

		for (int i = startPage; i <= endPage; i++) {
			sb.append("");
			if (i == currentPage) {
				sb.append("<font color='orange' size='5'>").append(i).append("</font>");
			} else {
				sb.append("<a href='#' onclick='goPage(\"").append(i).append("\");' >").append(i).append(
						"</a>");
			}
		}
	//	sb.append("&nbsp;<FONT style='font-size: 12px' COLOR=D0D0D0>|</FONT> ");
		sb.append("");

		if (isNext) {
			int goNextPage = startPage + pagePerBlock;

//			sb.append("<a href='#' onclick='goPage(\"").append(goNextPage).append("\");' ").append(imgNextClss).append(" >").append(imgNext).append("</a>");
			sb.append("<a href='#' onclick='goPage(\"").append(goNextPage).append("\");' ").append(imgNextClss).append(" class='glyphicon glyphicon-play paging' >").append("</a>");
		} else {
			
		}
		
		if(totalNumOfPage > currentPage){
//			sb.append("<a href='#' onclick='goPage(\"").append(totalNumOfPage).append("\");' ").append(imgEndClss).append(" >").append(imgEnd).append("</a>");
			sb.append("<a href='#' onclick='goPage(\"").append(totalNumOfPage).append("\");' ").append(imgEndClss).append(" class='glyphicon glyphicon-forward paging' >").append("</a>");
		}

		return sb.toString();
		
	}
			
	public int getTotalRecord() {
		return totalRecord;
	}
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}
	public int getRecordPerPage() {
		return recordPerPage;
	}
	public void setRecordPerPage(int recordPerPage) {
		this.recordPerPage = recordPerPage;
	}
	public int getPagePerBlock() {
		return pagePerBlock;
	}
	public void setPagePerBlock(int pagePerBlock) {
		this.pagePerBlock = pagePerBlock;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public String getGoUrl() {
		return goUrl;
	}
	public void setGoUrl(String goUrl) {
		this.goUrl = goUrl;
	}
	public String getParameter() {
		return parameter;
	}
	public void setParameter(String parameter) {
		this.parameter = parameter;
	}
}
