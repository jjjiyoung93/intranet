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
	 * ???????????? ??????(String ??????)
	 * 
	 * @param getVal
	 *            ????????????
	 * @param chgdata
	 *            ????????? ????????? ???
	 ******************************************************************/
	public static String getEmptyResult2(String getVal, String chgdata) {
		String rVal = getVal;

		if (getVal == null || getVal.equals("") || getVal.equals("null")) {
			rVal = chgdata;
		}

		return rVal;
	}

	/******************************************************************
	 * ????????? ???????????? ?????????.(String ??????)
	 * 
	 * @param str
	 *            ????????????
	 * @param num
	 *            ?????? ??????
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
	 * ???????????? ??????(String ??????)
	 * 
	 * @param getVal
	 *            ????????????
	 * @param chgdata
	 *            ????????? ????????? ???
	 ******************************************************************/
	public static String getEmptyResult2(String getVal) {
		String rVal = getVal;

		if (getVal == null || getVal.equals("") || getVal.equals("null")) {
			rVal = "";
		}

		return rVal;
	}

	/******************************************************************
	 * ???????????? ??????(Map ??????)
	 * 
	 * @param map
	 *            ?????????
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
	 * ?????????????????????
	 ******************************************************************/
	public static String getCurrYear() {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy");
		String currYear = formatter.format(new java.util.Date());
		return currYear;
	}

	/******************************************************************
	 * ????????????
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
	 * ??????????????? ??????????????? ?????? ?????????.
	 * 
	 * @param total
	 *            ?????????
	 * @param list_per_limit
	 *            ???????????? ???????????? ??????
	 * @param page_per_limit
	 *            ????????? ?????? ??????
	 * @param page
	 *            ???????????????
	 * @return String ????????? ????????? ??????????????? ?????? ?????????.
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
		// ????????? ???????????? ???????????? ?????? ????????? [1]...[prev] ????????? ????????????.
		if (page_list > 0) {
			navigation = "<a href=\"javascript:goPage('1');\" class='urLnkFunction'>[" + 1 + "]</a> ";
			prev_page = page_list * page_per_limit;
			navigation += "<a href=\"javascript:goPage('" + prev_page + "');\">[???]</a> ";
		}

		// ????????? ?????? ????????? ?????? ??????
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

		// ????????? ?????? ??? ?????? $total_page ?????? ?????? ????????????, [next]...[total_page] ????????? ????????????.
		if (page_end < total_page) {
			int next_page = (page_list + 1) * page_per_limit + 1;
			navigation += "<a href=\"javascript:goPage('" + next_page + "')\">[???]</a> ";
			navigation += "<a href=\"javascript:goPage('" + total_page + "');\" class='urLnkFunction'>[" + total_page
					+ "]</a>";
		}

		return navigation;
	}

	/******************************************************************
	 * ???????????? UTF-8 ??????
	 * 
	 * @param str
	 *            ?????????
	 ******************************************************************/
	public static String getEncode(String str) {
		try {
			return java.net.URLEncoder.encode(str, "UTF-8");
		} catch (Exception e) {
			return "";
		}
	}

	/******************************************************************
	 * ?????? ?????????
	 * 
	 * @param
	 ******************************************************************/
	public static void upFolder(HttpServletRequest request, String path) {
		// String upFolder =path;
		// System.out.println("upFolder param : "+upFolder);
		// File upDir = new File(upFolder);
		// if (!upDir.exists()) {
		//// ??????????????????????????? ?????????
		// if(upDir.mkdir()) System.out.println(upFolder+" make ok");
		// else System.out.println(upFolder+" make fail!!");
		//
		// }

		String upFolder = request.getSession().getServletContext().getRealPath(path);
		// System.out.println("upFolder param : "+upFolder);
		File upDir = new File(upFolder);
		if (!upDir.exists()) {
			// ??????????????????????????? ?????????
			if (upDir.mkdir())
				System.out.println(upFolder + " make ok");
			else
				System.out.println(upFolder + " make fail!!");
		}
	}

	/******************************************************************
	 * 'YYYYMMDD' ????????? String?????? Date????????? ????????? ??????
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

		Date ddate = cdate.getTime(); // java.sql.Date ??? ??????..
		return ddate;
	}

	/******************************************************************
	 * System??? ?????? ????????? yyyyMMdd???????????? ???????????? method
	 * 
	 * @param
	 ******************************************************************/
	public static String getCurrentDate() {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		String currDate = formatter.format(new java.util.Date());
		return currDate;
	}

	/****************************************************************************************************
	 * ?????????????????? ????????? ?????????????????? html???????????? ??????
	 * 
	 * @param text
	 *            ???????????????
	 * @return String html??????
	 ****************************************************************************************************/
	public String textToHtml(String text) {
		String txt = getEmptyResult2(text);
		return txt.replaceAll(" ", "&nbsp;").replaceAll("\n", "<br>");
	}

	/****************************************************************************************************
	 * ????????? ???????????? ??????????????? ??????(10000=>10,000)
	 * 
	 * @param numData
	 *            ???????????? ?????? ?????????
	 * @return String ????????? ?????????
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
	 * yyyymmdd????????? ???????????? yyyy-mm-dd????????? ??????
	 * 
	 * @param yyyymmdd
	 *            ???????????????
	 * @return yyyy-mm-dd ???????????????
	 ****************************************************************************************************/
	public String cvtDate(String yyyymmdd) {
		return cvtDate(yyyymmdd, "-");
	}

	/****************************************************************************************************
	 * yyyymmdd????????? ???????????? yyyy-mm-dd????????? ??????
	 * 
	 * @param yyyymmdd
	 *            ???????????????
	 * @param type
	 *            ????????????(/,-)
	 * @return yyyy-mm-dd or yyyy/mm/dd ???????????????
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
	 * RSS ????????? ???????????? ???????????? ?????? ????????? ?????????
	 * 
	 * @param url
	 *            RSS????????? ??????
	 * @param item
	 *            ?????? ?????? ??????
	 * @param start
	 *            ?????? item ??????
	 * @param count
	 *            ????????? ??? ????????????
	 * @return 2??????????????? ????????? ????????? ???????????? ????????? ????????? ?????? ???????????????.
	 ****************************************************************************************************/
	public String[][] getXmlList(String url, int item, int start, int count) {
		String[][] list = null;
		try {
//			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
//			DocumentBuilder builder = factory.newDocumentBuilder();
			// parse() ???????????? ????????? ??? ?????? ?????? ???, ???????????? URI String ??? ????????????.
//			Document doc = builder.parse(url);
//			NodeList rss = doc.getElementsByTagName("rss");

//			NodeList channel = rss.item(0).getChildNodes();

			// _n ????????? <channel> ~~~ </channel> ??? ????????? ????????? ???????????????.
//			NodeList _n = channel.item(1).getChildNodes();
			list = new String[count][item];
			for (int i = start; i < (start + count * 2); i = i + 2) {
				// ??????????????? RSS ????????? ?????? ????????? ?????? ????????? ????????? ????????? ?????????.
				for (int j = 1; j < (item * 2); j = j + 2) {
					// rss ????????? ???????????? rss ??????????????? ?????? ????????? ?????????
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
	 * 00000000000????????? ???????????? 00-0000-0000 ?????? 000-0000-0000????????? ??????(???????????? ???????????? ??????)
	 * 
	 * @param 00000000000
	 *            ???????????????
	 * @return 00-0000-0000 ?????? 000-0000-0000 ??????????????? length??? return?????? int???!!
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
	 * String??? ????????????("") ?????? null ?????? ????????????.
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
	 *            - ?????? ?????? ??????????????????????????? null??? ?????????
	 * @return <code>true</code> - ???????????? String ??? ??? ????????? ?????? null??? ??????
	 */
	public static boolean isEmpty(String str) {
		return str == null || str.length() == 0;
	}

	/**
	 * ????????? null?????? ???????????? null??? ?????? "" ??? ????????? ?????????
	 * 
	 * @param object
	 *            ?????? ??????
	 * @return resultVal ?????????
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
	 * ?????? ???????????? ????????? ?????? ?????? ??????(char)??? ????????????.
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
	 *            ???????????? ?????? ?????????
	 * @param remove
	 *            ???????????? ??????????????? ????????? ?????? ?????????
	 * @return ???????????? ???????????? ????????? ???????????????. ?????????????????? null??? ?????? ?????????????????? null
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
	 * ????????? ????????? ?????? character(,)??? ?????? ????????????.
	 * </p>
	 *
	 * <pre>
	 * StringUtil.removeCommaChar(null)       = null
	 * StringUtil.removeCommaChar("")         = ""
	 * StringUtil.removeCommaChar("asdfg,qweqe") = "asdfgqweqe"
	 * </pre>
	 *
	 * @param str
	 *            ???????????? ?????? ?????????
	 * @return " , "??? ????????? ??????????????? ?????????????????? null??? ?????? ?????????????????? null
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