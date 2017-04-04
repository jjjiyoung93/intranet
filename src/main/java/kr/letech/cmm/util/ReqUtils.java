package kr.letech.cmm.util;

import java.io.File;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public final class ReqUtils {
	public static Map<String, Object> getParameterMap(HttpServletRequest request) {
		@SuppressWarnings("unchecked")
		Map paramerterMap = request.getParameterMap();
		Iterator<String> iter = paramerterMap.keySet().iterator();

		Map<String, Object> map = new HashMap<String, Object>();
		String key = null;
		String[] value = null;

		try {
			while (iter.hasNext()) {
				key = (String) iter.next();
				value = (String[]) paramerterMap.get(key);
				if (value.length > 1) {
					map.put(key, filter(value));
				} else {
					map.put(key, filter(value[0]));
				}
			}
		} catch (Exception e) {
			System.out.println("            <<<ReqUtils - getParameterMap(HttpServletRequest request)>>>");
			System.out.println("            " + e.getMessage());
		}
		return map;
	}

	public static Map<String, Object> getParameterMap2(HttpServletRequest request) {
		@SuppressWarnings("unchecked")
		Map paramerterMap = request.getParameterMap();
		Iterator<String> iter = paramerterMap.keySet().iterator();

		Map<String, Object> map = new HashMap<String, Object>();
		String key = null;
		String[] value = null;
		try {
			while (iter.hasNext()) {
				key = (String) iter.next();
				value = (String[]) paramerterMap.get(key);
				if (value.length > 1) {
					map.put(key, value);
				} else {
					map.put(key, value[0]);
				}
			}
		} catch (Exception e) {
			System.out.println("            <<<ReqUtils - getParameterMap(HttpServletRequest request)>>>");
			System.out.println("            " + e.getMessage());
		}
		return map;
	}

	public static Map<String, Object> getParameterMap3(MultipartHttpServletRequest request) {
		@SuppressWarnings("unchecked")
		Map paramerterMap = request.getParameterMap();
		Iterator<String> iter = paramerterMap.keySet().iterator();

		Map<String, Object> map = new HashMap<String, Object>();
		String key = null;
		String[] value = null;
		try {
			while (iter.hasNext()) {
				key = (String) iter.next();
				value = (String[]) paramerterMap.get(key);
				if (value.length > 1) {
					map.put(key, filter(value));
				} else {
					map.put(key, filter(value[0]));
				}
			}
		} catch (Exception e) {
			System.out.println("            <<<ReqUtils - getParameterMap(HttpServletRequest request)>>>");
			System.out.println("            " + e.getMessage());
		}
		return map;
	}

	public static Map<String, Object> getParameterMap(HttpServletRequest request, String type) {
		@SuppressWarnings("unchecked")
		Map paramerterMap = request.getParameterMap();
		Iterator<String> iter = paramerterMap.keySet().iterator();

		Map<String, Object> map = new HashMap<String, Object>();
		String key = null;
		String[] value = null;
		try {
			while (iter.hasNext()) {
				key = (String) iter.next();
				value = (String[]) paramerterMap.get(key);
				if (value.length > 1 || type.equals("array")) {
					map.put(key, filter(value));
				} else {
					map.put(key, filter(value[0]));
				}
			}
		} catch (Exception e) {
			System.out.println("            <<<ReqUtils - getParameterMap(HttpServletRequest request)>>>");
			System.out.println("            " + e.getMessage());
		}
		return map;
	}

	public static Map<String, String> getEmptyResult(String resultColumns) {
		Map<String, String> map = null;
		if (resultColumns != null && !resultColumns.equals("")) {
			map = new HashMap<String, String>();
			String[] columns = StringUtils.split(resultColumns, ",");
			for (int i = 0; i < columns.length; i++) {
				map.put(columns[i], "");
			}
		}
		return map;
	}

	/******************************************************************
	 * 널데이터 체크(String 형식)
	 * 
	 * @param getVal
	 *            데이터값
	 * @param chgdata
	 *            널일때 교체할 값
	 ******************************************************************/
	public static String getEmptyResult2(String getVal, String chgdata) {
		String rVal = getVal;

		if (getVal == null || getVal.equals("") || getVal.equals("null")) {
			rVal = chgdata;
		}

		return rVal;
	}

	/******************************************************************
	 * 원하는 길이만큼 자르기.(String 형식)
	 * 
	 * @param str
	 *            데이터값
	 * @param num
	 *            자를 길이
	 ******************************************************************/
	public static String cutStr(String str, int num) {
		String tmp = "";
		if (str.length() > num) {
			tmp = str.substring(0, num) + "...";
		} else {
			tmp = str;
		}
		return tmp;
	}

	/******************************************************************
	 * 널데이터 체크(String 형식)
	 * 
	 * @param getVal
	 *            데이터값
	 * @param chgdata
	 *            널일때 교체할 값
	 ******************************************************************/
	public static String getEmptyResult2(String getVal) {
		String rVal = getVal;

		if (getVal == null || getVal.equals("") || getVal.equals("null")) {
			rVal = "";
		}

		return rVal;
	}

	/******************************************************************
	 * 널데이터 체크(Map 형식)
	 * 
	 * @param map
	 *            데이터
	 ******************************************************************/
	public static Map<String, String> getResultNullChk(Map<String, Object> map) {
		Map<String, String> rMap = new HashMap<String, String>();
		Iterator<String> iter = map.keySet().iterator();
		String key = null;
		String value = null;
		try {
			while (iter.hasNext()) {
				key = (String) iter.next();
				value = "" + map.get(key);

				if (value != null && !"null".equals(value) && value != "") {
					rMap.put(key, value);
				} else {
					rMap.put(key, "");
				}
			}

		} catch (Exception e) {
			System.out.println("getResultNullChk:" + e.getMessage());
		}

		return rMap;
	}

	/******************************************************************
	 * 현재년도구하기
	 ******************************************************************/
	public static String getCurrYear() {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy");
		String currYear = formatter.format(new java.util.Date());
		return currYear;
	}

	/******************************************************************
	 * 현재날짜
	 ******************************************************************/
	public String getToDate() {
		String thisdate = "";
		try {
			java.util.Date todate = new java.util.Date();
			java.text.SimpleDateFormat sysdate = new java.text.SimpleDateFormat("yyyy-MM-dd", java.util.Locale.KOREA);
			thisdate = sysdate.format(todate);
		} catch (Exception e) {
		}
		return thisdate;
	}

	/******************************************************************************************************
	 * 해당페이지 네비게이션 바를 만든다.
	 * 
	 * @param total
	 *            총갯수
	 * @param list_per_limit
	 *            한페이당 보여주눈 줄수
	 * @param page_per_limit
	 *            페이지 묶음 단위
	 * @param page
	 *            현재페이지
	 * @return String 형으로 페이지 네비게이션 바를 그린다.
	 *******************************************************************************************************/
	public String paging(int total, int list_per_limit, int page_per_limit, int page) {

		int total_page_temp = total % list_per_limit == 0 ? 0 : 1;
		int total_page = (total / list_per_limit) + total_page_temp;

		if (page == 0)
			page = 1;
		int page_list_temp = page % page_per_limit == 0 ? 0 : 1;
		int page_list = (page / page_per_limit) + page_list_temp - 1;
		String navigation = "";
		int prev_page = 0;
		// 페이지 리스트의 첫번째가 아닌 경우엔 [1]...[prev] 버튼을 생성한다.
		if (page_list > 0) {
			navigation = "<a href=\"javascript:goPage('1');\" class='urLnkFunction'>[" + 1 + "]</a> ";
			prev_page = page_list * page_per_limit;
			navigation += "<a href=\"javascript:goPage('" + prev_page + "');\">[◀]</a> ";
		}

		// 페이지 목록 가운데 부분 출력
		int page_end = (page_list + 1) * page_per_limit;
		if (page_end > total_page)
			page_end = total_page;

		for (int setpage = page_list * page_per_limit + 1; setpage <= page_end; setpage++) {
			if (setpage == page_end) {
				if (setpage == page) {
					navigation += "<font color='#0066CC'><strong>" + setpage + "</strong></font> ";
				} else {
					navigation += "<a href=\"javascript:goPage('" + setpage + "')\" class='urLnkFunction'>" + setpage
							+ "</a> ";
				}
			} else {
				if (setpage == page) {
					navigation += "<font color='#0066CC'><strong>" + setpage + "</strong></font> ";
				} else {
					navigation += "<a href=\"javascript:goPage('" + setpage + "')\" class='urLnkFunction'>" + setpage
							+ "</a> ";
				}
			}
		}

		// 페이지 목록 맨 끝이 $total_page 보다 작을 경우에만, [next]...[total_page] 버튼을 생성한다.
		if (page_end < total_page) {
			int next_page = (page_list + 1) * page_per_limit + 1;
			navigation += "<a href=\"javascript:goPage('" + next_page + "')\">[▶]</a> ";
			navigation += "<a href=\"javascript:goPage('" + total_page + "');\" class='urLnkFunction'>[" + total_page
					+ "]</a>";
		}

		return navigation;
	}

	/******************************************************************
	 * 문자열을 UTF-8 변환
	 * 
	 * @param str
	 *            문자열
	 ******************************************************************/
	public static String getEncode(String str) {
		try {
			return java.net.URLEncoder.encode(str, "UTF-8");
		} catch (Exception e) {
			return "";
		}
	}

	/******************************************************************
	 * 폴더 만들기
	 * 
	 * @param
	 ******************************************************************/
	public static void upFolder(HttpServletRequest request, String path) {
		// String upFolder =path;
		// System.out.println("upFolder param : "+upFolder);
		// File upDir = new File(upFolder);
		// if (!upDir.exists()) {
		//// 파일디렉토리없으면 만들기
		// if(upDir.mkdir()) System.out.println(upFolder+" make ok");
		// else System.out.println(upFolder+" make fail!!");
		//
		// }

		String upFolder = request.getSession().getServletContext().getRealPath(path);
		// System.out.println("upFolder param : "+upFolder);
		File upDir = new File(upFolder);
		if (!upDir.exists()) {
			// 파일디렉토리없으면 만들기
			if (upDir.mkdir())
				System.out.println(upFolder + " make ok");
			else
				System.out.println(upFolder + " make fail!!");
		}
	}

	/******************************************************************
	 * 'YYYYMMDD' 형태의 String형을 Date형으로 만들어 리턴
	 * 
	 * @param
	 ******************************************************************/
	public static Date stringToDate(String d) {

		int year = Integer.parseInt(d.substring(0, 4));
		int month = Integer.parseInt(d.substring(4, 6));
		int day = Integer.parseInt(d.substring(6));

		Calendar cdate = java.util.Calendar.getInstance();
		cdate.set(Calendar.YEAR, year);
		cdate.set(Calendar.MONTH, month);
		cdate.set(Calendar.DATE, day);

		Date ddate = cdate.getTime(); // java.sql.Date 가 아님..
		return ddate;
	}

	/******************************************************************
	 * System의 현재 날짜를 yyyyMMdd형식으로 반환하는 method
	 * 
	 * @param
	 ******************************************************************/
	public static String getCurrentDate() {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		String currDate = formatter.format(new java.util.Date());
		return currDate;
	}

	/****************************************************************************************************
	 * 텍스트문자의 공백과 줄내림표시를 html형식으로 변경
	 * 
	 * @param text
	 *            텍스트문자
	 * @return String html문자
	 ****************************************************************************************************/
	public String textToHtml(String text) {
		String txt = getEmptyResult2(text);
		return txt.replaceAll(" ", "&nbsp;").replaceAll("\n", "<br>");
	}

	/****************************************************************************************************
	 * 숫자형 데이터를 회계단위로 표현(10000=>10,000)
	 * 
	 * @param numData
	 *            텍스트형 숫자 데이타
	 * @return String 변형된 데이타
	 ****************************************************************************************************/
	public String numFormat(Object obj) {
		NumberFormat nf = NumberFormat.getInstance();
		String chgDataType = "0";
		try {
			if (obj instanceof Double) {
				chgDataType = nf.format((Double) obj);
			} else if (obj instanceof Long) {
				chgDataType = nf.format((Long) obj);
			} else if (obj instanceof String) {
				chgDataType = nf.format(Double.parseDouble((String) obj));
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return chgDataType;
	}

	/****************************************************************************************************
	 * yyyymmdd형택의 문자열을 yyyy-mm-dd형태로 변경
	 * 
	 * @param yyyymmdd
	 *            텍스트문자
	 * @return yyyy-mm-dd 텍스트문자
	 ****************************************************************************************************/
	public String cvtDate(String yyyymmdd) {
		return cvtDate(yyyymmdd, "-");
	}

	/****************************************************************************************************
	 * yyyymmdd형택의 문자열을 yyyy-mm-dd형태로 변경
	 * 
	 * @param yyyymmdd
	 *            텍스트문자
	 * @param type
	 *            변형형식(/,-)
	 * @return yyyy-mm-dd or yyyy/mm/dd 텍스트문자
	 ****************************************************************************************************/
	public String cvtDate(String yyyymmdd, String type) {
		String rval = "";
		if (type != null && yyyymmdd.length() >= 8) {
			if (type.equals("/")) {
				rval = yyyymmdd.substring(0, 4) + "/" + yyyymmdd.substring(4, 6) + "/" + yyyymmdd.substring(6, 8);
			} else if (type.equals("-")) {
				rval = yyyymmdd.substring(0, 4) + "-" + yyyymmdd.substring(4, 6) + "-" + yyyymmdd.substring(6, 8);
			}
		}
		return rval;
	}

	/****************************************************************************************************
	 * RSS 서비스 데이터를 파싱해서 배열 형태로 돌려줌
	 * 
	 * @param url
	 *            RSS서비스 주소
	 * @param item
	 *            해당 필드 갯수
	 * @param start
	 *            시작 item 위치
	 * @param count
	 *            가지고 올 목록갯수
	 * @return 2차원배열로 첫번째 위치는 목록갯수 두번째 위치는 필드 위치입니다.
	 ****************************************************************************************************/
	public String[][] getXmlList(String url, int item, int start, int count) {
		String[][] list = null;
		try {
//			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
//			DocumentBuilder builder = factory.newDocumentBuilder();
			// parse() 메소드에 들어갈 수 있는 인자 중, 아래처럼 URI String 도 있습니다.
//			Document doc = builder.parse(url);
//			NodeList rss = doc.getElementsByTagName("rss");

//			NodeList channel = rss.item(0).getChildNodes();

			// _n 변수에 <channel> ~~~ </channel> 속 노드들 정보가 들어갑니다.
//			NodeList _n = channel.item(1).getChildNodes();
			list = new String[count][item];
			for (int i = start; i < (start + count * 2); i = i + 2) {
				// 예제에서는 RSS 피드중 상단 블로그 정보 부분만 콘솔로 출력해 봅니다.
				for (int j = 1; j < (item * 2); j = j + 2) {
					// rss 오류로 사용안함 rss 사용할경우 다른 대책을 찾을것
					// list[l][k] =
					// _n.item(i).getChildNodes().item(j).getTextContent();
				}
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return list;
	}

	/****************************************************************************************************
	 * 00000000000형택의 문자열을 00-0000-0000 또는 000-0000-0000형태로 변경(전화번호 데이터에 사용)
	 * 
	 * @param 00000000000
	 *            텍스트문자
	 * @return 00-0000-0000 또는 000-0000-0000 텍스트문자 length의 return값은 int임!!
	 ****************************************************************************************************/
	public String telNum(String tel) {
		String rval = "";
		if (!tel.equals("") && 11 == tel.length()) {
			rval = tel.substring(0, 3) + "-" + tel.substring(3, 7) + "-" + tel.substring(7, 11);
		} else if (!tel.equals("") && 10 == tel.length()) {
			if ("2".equals(tel.substring(1, 2))) {
				rval = tel.substring(0, 2) + "-" + tel.substring(2, 6) + "-" + tel.substring(6, 10);
			} else {
				rval = tel.substring(0, 3) + "-" + tel.substring(3, 6) + "-" + tel.substring(6, 10);
			}
		} else if (!tel.equals("") && 9 == tel.length()) {
			rval = tel.substring(0, 2) + "-" + tel.substring(2, 5) + "-" + tel.substring(5, 9);
		} else {
			rval = tel;
		}
		return rval;
	}

	/**
	 * <p>
	 * String이 비었거나("") 혹은 null 인지 검증한다.
	 * </p>
	 * 
	 * <pre>
	 *  StringUtil.isEmpty(null)      = true
	 *  StringUtil.isEmpty("")        = true
	 *  StringUtil.isEmpty(" ")       = false
	 *  StringUtil.isEmpty("bob")     = false
	 *  StringUtil.isEmpty("  bob  ") = false
	 * </pre>
	 * 
	 * @param str
	 *            - 체크 대상 스트링오브젝트이며 null을 허용함
	 * @return <code>true</code> - 입력받은 String 이 빈 문자열 또는 null인 경우
	 */
	public static boolean isEmpty(String str) {
		return str == null || str.length() == 0;
	}

	/**
	 * 객체가 null인지 확인하고 null인 경우 "" 로 바꾸는 메서드
	 * 
	 * @param object
	 *            원본 객체
	 * @return resultVal 문자열
	 */
	public static String isNullToString(Object object) {
		String string = "";

		if (object != null) {
			string = object.toString().trim();
		}

		return string;
	}

	/**
	 * <p>
	 * 기준 문자열에 포함된 모든 대상 문자(char)를 제거한다.
	 * </p>
	 *
	 * <pre>
	 * StringUtil.remove(null, *)       = null
	 * StringUtil.remove("", *)         = ""
	 * StringUtil.remove("queued", 'u') = "qeed"
	 * StringUtil.remove("queued", 'z') = "queued"
	 * </pre>
	 *
	 * @param str
	 *            입력받는 기준 문자열
	 * @param remove
	 *            입력받는 문자열에서 제거할 대상 문자열
	 * @return 제거대상 문자열이 제거된 입력문자열. 입력문자열이 null인 경우 출력문자열은 null
	 */
	public static String remove(String str, char remove) {
		if (isEmpty(str) || str.indexOf(remove) == -1) {
			return str;
		}
		char[] chars = str.toCharArray();
		int pos = 0;
		for (int i = 0; i < chars.length; i++) {
			if (chars[i] != remove) {
				chars[pos++] = chars[i];
			}
		}
		return new String(chars, 0, pos);
	}

	/**
	 * <p>
	 * 문자열 내부의 콤마 character(,)를 모두 제거한다.
	 * </p>
	 *
	 * <pre>
	 * StringUtil.removeCommaChar(null)       = null
	 * StringUtil.removeCommaChar("")         = ""
	 * StringUtil.removeCommaChar("asdfg,qweqe") = "asdfgqweqe"
	 * </pre>
	 *
	 * @param str
	 *            입력받는 기준 문자열
	 * @return " , "가 제거된 입력문자열 입력문자열이 null인 경우 출력문자열은 null
	 */
	public static String removeCommaChar(String str) {
		return remove(str, ',');
	}

	private static String filter(String input) {

		if (input == null) {
			return null;
		}
		/*
		 * String clean = new HTMLInputFilter().filter(input.replaceAll("%22",
		 * "").replaceAll("..\\\\", "").replaceAll("\"",
		 * "%22").replaceAll("\'","%27")); clean=clean.replaceAll("<",
		 * "%3C").replaceAll(">", "%3E").replaceAll("../", "");
		 * System.out.println("Map1=======================after:"+clean); return
		 * clean;
		 */
		return input;
	}

	private static String[] filter(String[] input) {

		if (input == null) {
			return null;
		}
		/*
		 * String[] clean=new String[input.length]; for(int
		 * i=0;i<input.length;i++){ input[i] = new
		 * HTMLInputFilter().filter(input[i].replaceAll("%22", "").replaceAll(
		 * "..\\\\", "").replaceAll("\"", "%22").replaceAll("\'","%27"));
		 * clean[i]=input[i].replaceAll("<", "%3C").replaceAll(">",
		 * "%3E").replaceAll("../", "");
		 * System.out.println("MapA=======================after:"+clean[i]); }
		 * return clean;
		 */
		return input;
	}
}