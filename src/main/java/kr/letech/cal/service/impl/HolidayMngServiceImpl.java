package kr.letech.cal.service.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.letech.cal.service.HolidayMngService;
import kr.letech.cmm.util.EgovProperties;
import kr.letech.cmm.util.VarConsts;
import kr.letech.vct.service.impl.VctMngDAO;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@Service("holidayMngService")
public class HolidayMngServiceImpl implements HolidayMngService {

	/** calMngDAO */
	@Resource(name="holidayMngDAO")
	private HolidayMngDAO holidayMngDAO;
	
	/** vctMngDAO */
	@Resource(name="vctMngDAO")
	private VctMngDAO vctMngDAO;
	
	

	/**
	 * 휴일 목록
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public List getHolidyList(Map params) throws Exception {
		
		return holidayMngDAO.getHolidayList(params);
	}
	
	/**
	 * 휴일 상세조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public Map getHolidyView(Map params) throws Exception {
		
		return holidayMngDAO.getHolidayView(params);
	}
	
	/**
	 * 휴일 등록
	 * @param params
	 * @throws Exception
	 */
	@Override
	public void holidayInsert(Map params) throws Exception {
		holidayMngDAO.holidayInsert(params);
	}
	
	/**
	 * 휴일 수정
	 * @param params
	 * @throws Exception
	 */
	@Override
	public void holidayUpdate(Map params) throws Exception {
		holidayMngDAO.holidayUpdate(params);
	}
	
	/**
	 * 휴일 삭제
	 * @param params
	 * @throws Exception
	 */
	@Override
	public void holidayDelete(Map params) throws Exception {
		holidayMngDAO.holidayDelete(params);
	}

	/**
	 * 휴일 목록 조회
	 * @param params 기준년도(stdd_yr)
	 * @return list 휴일 목록
	 * @throws Exception
	 */
	@Override
	public List getHolMngList(Map params) throws Exception {
		
		List list = holidayMngDAO.getHolMngList(params);
		
		/*페이징 처리 필요시 로직 추가*/
		
		
		return list;
	}

	@Override
	public List getHolidayInfo(Map params) throws Exception {
		
		String urlStr = EgovProperties.getProperty("holi.url");
		String operation = "/"+EgovProperties.getProperty("holi.operation");
		String serviceKey = EgovProperties.getProperty("holi.serviceKey");
		String urlParam = "?serviceKey=" + serviceKey
						 + "&solYear=2022"
						 + "&numOfRows=100"
						 + "&_type=json";
		
		String reqUrl = urlStr + operation + urlParam;
		
		HttpURLConnection conn = null;
		
		URL url = new URL(reqUrl);
		
		conn = (HttpURLConnection)url.openConnection();
		conn.setRequestProperty("Accept-language", "ko");
		conn.setRequestProperty("Content-type", "application/json");
		conn.setRequestMethod("GET");
		BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        
        String sbStr = sb.toString();
        
        Map resultMap = JSONObject.fromObject(sbStr);
        Map resp = JSONObject.fromObject(resultMap.get("response"));
        Map body = JSONObject.fromObject(resp.get("body"));
        Map items = JSONObject.fromObject(body.get("items"));
        List<Map> itemList = JSONArray.fromObject(items.get("item"));
        
        for (Map item : itemList) {
			String name = (String)item.get("dateName");
			System.out.println(name.toString());
			
		}
        
        
        System.out.println(itemList.toString());
		
		
		return null;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public int holMngDelete(Map params) throws Exception {
		//지울 대상에 해당하는 휴일 정보 가져오기
		Map holMap = holidayMngDAO.getHolMngView(params);
		//휴일날짜
		String holDt = (String)holMap.get("CAL_HOL_DT");
		//휴가날짜
		String vctDt = holDt.substring(0, 4) + "-" + holDt.substring(4, 6) + "-" + holDt.substring(6);
		
		int holCnt = 0;
		int delCnt = 0;
		
		//holMap
		//휴일정보 삭제
		delCnt = holidayMngDAO.deleteHolMng(params);
		
		Map paramMap = new HashMap();
		
		paramMap.put("cal_hol_dt", holDt);
		
		//휴일날짜에 해당하는 휴일정보가 '모두' 삭제되었는지 확인
		holCnt = holidayMngDAO.getHolidayCnt(paramMap);
		
		//휴일날짜에 해당하는 휴가 정보가 없으면 휴가 정보 사용여부 플래그 변경 (N=>Y)
		if(holCnt == 0) {
			paramMap.put("use_yn", "Y");
			paramMap.put("vct_dt", vctDt);
			vctMngDAO.updateVctInfUse(paramMap);
		}
		
		return delCnt;
	}

	@Override
	public int getHolMngMaxSeq(Map params) throws Exception {
		
		return holidayMngDAO.getHolMngMaxSeq(params);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public Map mergeHolMng(Map params) throws Exception {
		String maxSeq = (String)params.get("max_row_cnt");
		String stddYr = (String)params.get("stdd_yr");
		String ussId = (String)params.get("uss_id");
		
		Map resultMap = new HashMap();
		
		int maxRowSeq = 0;
		if(StringUtils.isNotEmpty(maxSeq)) {
			maxRowSeq = Integer.parseInt(maxSeq);
			Map paramMap = new HashMap();
			
			//수정 갯수
			int updCnt = 0;

			//등록 갯수
			int insCnt = 0;
			
			for(int i = 1; i<=maxRowSeq; i++) {
				String seq = (String)params.get("seq_"+i);
				
				//seq 값이 있을 경우 등록/수정된 자료
				if(StringUtils.isNotEmpty(seq)) {
					
					String dt = (String)params.get("dt_"+i);
					String vctDt = dt.substring(0, 4) + "-" + dt.substring(4, 6) + "-" + dt.substring(6);
					String nm = (String)params.get("nm_"+i);
					String rmk = (String)params.get("rmk_"+i);
					String mode = (String)params.get("mode_"+i);
					
					//등록 /수정 map
					paramMap.put("cal_hol_seq", seq);
					paramMap.put("cal_hol_dt", dt);
					paramMap.put("cal_hol_nm", nm);
					paramMap.put("cal_hol_rmk", rmk);
					paramMap.put("cal_hol_yr", stddYr);
					paramMap.put("cal_hol_lst_mod_emp", ussId);
					
					
					if(StringUtils.equals(mode, VarConsts.MODE_U)) {
						/*수정*/
						//기존 날짜 데이터 조회
						Map holViewMap = holidayMngDAO.getHolMngView(paramMap);
						String orginHolDt = (String)holViewMap.get("CAL_HOL_DT");
						String vctOrginDt = orginHolDt.substring(0, 4) + "-" + orginHolDt.substring(4, 6) + "-" + orginHolDt.substring(6);
						
						
						//휴일 정보 수정
						updCnt += holidayMngDAO.updateHolMng(paramMap);
						
						int holCnt = 0;
						Map holParam = new HashMap();
						holParam.put("cal_hol_dt", orginHolDt);
						
						//날짜 수정된 경우 : 기존 날짜 관련 휴일 정보 카운팅 후 없으면 휴가정보 사용여부 Y 변경, 있으면 N 변경
					    //             : 변경 날짜 관련 휴가정보 사용여부 N 변경
						if(!StringUtils.equals(dt, orginHolDt)) {
							//기존날짜 : 기존날짜는 날짜 중복 자료가 존재할 경우 휴가 정보 사용여부는 N, 날짜 중복 자료가 존재하지 않을 시 Y 변경
							holCnt = holidayMngDAO.getHolidayCnt(holParam);
							
							if(holCnt > 0) {
								holParam.put("vct_dt", vctOrginDt);
								holParam.put("use_yn", "N");
							}else if(holCnt == 0) {
								holParam.put("vct_dt", vctOrginDt);
								holParam.put("use_yn", "Y");
							}
							
							vctMngDAO.updateVctInfUse(holParam);
							
							//변경날짜 : 변경날짜는 중복 자료가 있으나 없으나 휴가 정보 사용여부 N 변경
							holParam.put("vct_dt", vctDt);
							holParam.put("vct_dt", "N");
							
							vctMngDAO.updateVctInfUse(holParam);
						}
						
						
					}else if(StringUtils.equals(mode, VarConsts.MODE_I)) {
						/*휴일등록*/
						insCnt += holidayMngDAO.insertHolMng(paramMap);
						
						/*해당 날짜 휴가정보 사용여부 'N' 변경*/
						paramMap.put("vct_dt", vctDt);
						paramMap.put("use_yn", "N");
						vctMngDAO.updateVctInfUse(paramMap);
						
					}
					
				}else { // seq 값이 없으면 반복문 속행
					continue;
				}
				
			}
			
			resultMap.put("insCnt", insCnt);
			resultMap.put("updCnt", updCnt);
			
		}
		
		
		return resultMap;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public int holMngUpdateBySys(Map params) throws Exception {
		String stddYr = (String)params.get("stdd_yr");
		params.put("cal_hol_lst_mod_emp", "SYSTEM");
		//기존 자료 조회(휴가 정보 사용여부 변경하기 위해서)
		List<Map> sysHolList = holidayMngDAO.getHolMngList(params);
		//기존자료 삭제 단, SYSTEM 등록 자료만
		holidayMngDAO.deleteHolMngBySys(params);
		Map paramMap = new HashMap();
		int holCnt = 0;
		//삭제한 자료에 맞춰 휴가 정보 사용여부 Y 변경처리
		for (Map sysHol : sysHolList) {
			String holDt = (String)sysHol.get("CAL_HOL_DT");
			String vctDt = holDt.substring(0, 4) + "-" + holDt.substring(4, 6) + "-" + holDt.substring(6);
			paramMap.put("cal_hol_dt", holDt);
			
			//휴일날짜에 해당하는 휴일정보가 '모두' 삭제되었는지 확인
			holCnt = holidayMngDAO.getHolidayCnt(paramMap);
			
			//휴일날짜에 해당하는 휴가 정보가 없으면 휴가 정보 사용여부 플래그 변경 (N=>Y)
			if(holCnt == 0) {
				paramMap.put("use_yn", "Y");
				paramMap.put("vct_dt", vctDt);
				vctMngDAO.updateVctInfUse(paramMap);
			}
			
		}
		//api 호출 정보 생성
		String urlStr = EgovProperties.getProperty("holi.url");
		String operation = "/"+EgovProperties.getProperty("holi.operation");
		String serviceKey = EgovProperties.getProperty("holi.serviceKey");
		String urlParam = "?serviceKey=" + serviceKey
						 + "&solYear="+stddYr
						 + "&numOfRows=100"
						 + "&_type=json";
		
		String reqUrl = urlStr + operation + urlParam;
		
		//api 호출
		HttpURLConnection conn = null;
		
		URL url = new URL(reqUrl);
		BufferedReader rd = null;
		StringBuilder sb = new StringBuilder();
		try {
			conn = (HttpURLConnection)url.openConnection();
			conn.setRequestProperty("Accept-language", "ko");
			conn.setRequestProperty("Content-type", "application/json");
			conn.setRequestMethod("GET");
			if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			String line;
			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}
			
		}catch (Exception e) {
			throw new Exception();
		}finally {
			rd.close();
			conn.disconnect();
		}
        
        String sbStr = sb.toString();
        
        Map resultMap = JSONObject.fromObject(sbStr);
        Map resp = JSONObject.fromObject(resultMap.get("response"));
        Map body = JSONObject.fromObject(resp.get("body"));
        Map items = JSONObject.fromObject(body.get("items"));
        List<Map> itemList = JSONArray.fromObject(items.get("item"));
        
        Map holParam = new HashMap();
        int insCnt = 0;
        for (Map item : itemList) {
        	String holDt = (String)item.get("locdate");
			String holNm = (String)item.get("dateName");
			String holRmk = (String)item.get("remarks");
			String vctDt = holDt.substring(0, 4) + "-" + holDt.substring(4, 6) + "-" + holDt.substring(6);
			
			//휴일정보 등록 MAP 생성
			holParam.put("cal_hol_dt", holDt);
			holParam.put("cal_hol_nm", holNm);
			holParam.put("cal_hol_rmk", holRmk);
			holParam.put("cal_hol_yr", stddYr);
			holParam.put("cal_hol_lst_mod_emp", "SYSTEM");
			
			//휴일정보 DB 적재
			insCnt += holidayMngDAO.insertHolMngBySys(holParam);
			
			//신규 데이터 등록에 따른 휴가 정보 사용여부 N 변경처리
			holParam.put("vct_dt", vctDt);
			holParam.put("use_yn", "N");
			
			vctMngDAO.updateVctInfUse(holParam);
			
			
		}
		
		
		return insCnt;
	}
}
