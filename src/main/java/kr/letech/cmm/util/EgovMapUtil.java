package kr.letech.cmm.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * <pre>
 * FileName: EgovMapUtil.java
 * Package : kr.letech.cmm.util
 * 
 * EgovMapUtil
 *
 * </pre>
 * @author : ksk
 * @date   : 2016. 4. 28.
 */
public class EgovMapUtil {

	/**
	 * <pre>
	 * 
	 * Convert ListHashMap to ListEvogMap
	 * 
	 * </pre>
	 *
	 * @author : ksk
	 * @date   : 2016. 4. 28.
	 * @param listHashMap
	 * @return
	 * @throws Exception
	 */
	public static List<EgovMap> convertListHashMap2ListEgovMap(List<HashMap<?, ?>> listHashMap) throws Exception {
		List<EgovMap> listEgovMap = new ArrayList<EgovMap>();
		EgovMap eGovMap;

		for (HashMap<?, ?> hashMap : listHashMap) {
			eGovMap = new EgovMap();
			eGovMap.putAll(hashMap);
			listEgovMap.add(eGovMap);
		}

		return listEgovMap;
	}


}
