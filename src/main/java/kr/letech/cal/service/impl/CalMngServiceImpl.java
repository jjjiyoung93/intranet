package kr.letech.cal.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.letech.cal.service.CalMngService;
import kr.letech.cmm.util.DateUtil;
import kr.letech.cmm.util.EgovFileTool;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;

@Service("calMngService")
public class CalMngServiceImpl implements CalMngService {

	/** calMngDAO */
	@Resource(name="calMngDAO")
	private CalMngDAO calMngDAO;
	
	/**
	 * 일정 정보 조회
	 */
	@Override
	public void getCalList(Map params, ModelMap model) throws Exception {
		DateUtil dt = new DateUtil();
		String now_date = params.get("now_date")==null?"":(String)params.get("now_date");
		
		if(now_date.length() > 10){
			now_date.substring(1, 10);
		}
		
		if(params.get("view_type").equals("month")){
			// 월별일경우 
			now_date = now_date.substring(0, 7);
			params.put("start_date", now_date);
			params.put("end_date", now_date);
		}else{
			// 주별일경우
			params.put("start_date", now_date);					// 주일에 시작 날짜
			params.put("end_date", dt.datePlus(now_date, 6));	// 주일에 마지막 날짜
		}
		
		List calList = calMngDAO.getCalList(params);
		
		List list = new ArrayList();
		int calListCnt = calList.size();
		for(int i=0; i < calListCnt; i++){
			Map map = (HashMap)calList.get(i);
			Map putMp = new HashMap();
			putMp.put("title", map.get("CAL_NM"));
//			putMp.put("url", "javascript:fnView("+map.get("CAL_SEQ")+");");
			putMp.put("url", map.get("CAL_SEQ"));
			putMp.put("start", map.get("CAL_ST_DT"));
			putMp.put("end", map.get("CAL_ED_DT_PLUS"));
			putMp.put("startDate", map.get("CAL_ST_DT"));
			putMp.put("endDate", map.get("CAL_ED_DT"));
			putMp.put("startTimeFri", map.get("CAL_ST_TIME_FRI"));
			putMp.put("startTimeSec", map.get("CAL_ST_TIME_SEC"));
			putMp.put("endTimeFri", map.get("CAL_ED_TIME_FRI"));
			putMp.put("endTimeSec", map.get("CAL_ED_TIME_SEC"));
			putMp.put("ussId", map.get("USS_ID"));
			list.add(putMp);
		}	
		
		model.clear();
		model.addAttribute("calList", list);
		
	}
	
	/**
	 * 일정 및 파일 등록
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public int calInsert(Map params, List<Map<String, Object>> fileList) throws Exception {
		
	    /* 시간 합치기 */
		String cal_st_time1 = params.get("cal_st_time1")==null?"":(String)params.get("cal_st_time1");
		String cal_st_time2 = params.get("cal_st_time2")==null?"":(String)params.get("cal_st_time2");
		String cal_ed_time1 = params.get("cal_ed_time1")==null?"":(String)params.get("cal_ed_time1");
		String cal_ed_time2 = params.get("cal_ed_time2")==null?"":(String)params.get("cal_ed_time2");
		if(!cal_st_time1.equals("") && !cal_st_time2.equals("")){
			params.put("cal_st_time", cal_st_time1+""+cal_st_time2);
		}
		if(!cal_ed_time1.equals("") && !cal_ed_time2.equals("")){
			params.put("cal_ed_time", cal_ed_time1+""+cal_ed_time2);
		}
		
		/* 일정 저장 */
		int cal_seq = calMngDAO.calInsert(params);
		
		/* 일정 파일 저장 */
		int fileCnt = fileList.size();
		Map fileParams = new HashMap();
		for(int i=0; i < fileCnt; i++){
			Map<String, Object> file = fileList.get(i);
			fileParams = new HashMap();
			fileParams.put("cal_seq", cal_seq);
			fileParams.put("file_nm", file.get("OrignlFileNm"));
			fileParams.put("file_stre_nm", file.get("StreFileNm"));
			fileParams.put("file_path", file.get("FileStreCours"));
			fileParams.put("file_size", file.get("FileMg"));
			fileParams.put("file_ext", file.get("FileExtsn"));
			
			calMngDAO.calFileInsert(fileParams);
		}
		
		return cal_seq;
	}
	
	/**
	 * 일정 상세정보 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public Map getCalView(Map params) throws Exception {
		return calMngDAO.getCalView(params);
	}
	
	/**
	 * 일정 수정 및 일정 파일 추가, 삭제 기능
	 * @param params
	 * @param fileList
	 * @throws Exception
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public void calUpdate(Map params, List<Map<String, Object>> fileList) throws Exception {
		
	    /* 시간 합치기 */
		String cal_st_time1 = params.get("cal_st_time1")==null?"":(String)params.get("cal_st_time1");
		String cal_st_time2 = params.get("cal_st_time2")==null?"":(String)params.get("cal_st_time2");
		String cal_ed_time1 = params.get("cal_ed_time1")==null?"":(String)params.get("cal_ed_time1");
		String cal_ed_time2 = params.get("cal_ed_time2")==null?"":(String)params.get("cal_ed_time2");
		if(!cal_st_time1.equals("") && !cal_st_time2.equals("")){
			params.put("cal_st_time", cal_st_time1+""+cal_st_time2);
		}
		if(!cal_ed_time1.equals("") && !cal_ed_time2.equals("")){
			params.put("cal_ed_time", cal_ed_time1+""+cal_ed_time2);
		}
		
		/* 일정 수정 */
		calMngDAO.calUpdate(params);
		String cal_seq = (String)params.get("cal_seq");
		
		/* 일정 파일 저장 */
		int fileCnt = fileList.size();
		Map fileParams = new HashMap();
		for(int i=0; i < fileCnt; i++){
			Map<String, Object> file = fileList.get(i);
			fileParams = new HashMap();
			fileParams.put("cal_seq", cal_seq);
			fileParams.put("file_nm", file.get("OrignlFileNm"));
			fileParams.put("file_stre_nm", file.get("StreFileNm"));
			fileParams.put("file_path", file.get("FileStreCours"));
			fileParams.put("file_size", file.get("FileMg"));
			fileParams.put("file_ext", file.get("FileExtsn"));
			
			calMngDAO.calFileInsert(fileParams);
		}
		
		/* 일정 파일 삭제 */
		
	}
	
	/**
	 * 일정 삭제
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public void calDelete(Map params) throws Exception {
		/* 일정 삭제 */
		calMngDAO.calDelete(params);
		
		// 파일 삭제하기전에 정보 조회
		List fileList = calMngDAO.getCalFileList(params);
		/* 일정 파일 삭제 */
		calMngDAO.calFileDelete(params);
		
		/* 물리적 파일 삭제 */
		int fileListCnt = fileList.size();
		for(int i=0; i < fileListCnt; i++){
			Map file = (Map)fileList.get(i);
			String file_stre_nm = (String)file.get("FILE_STRE_NM");		// 저장파일명
			String file_path = (String)file.get("FILE_PATH");			// 저장위치
			// 파일 삭제
			EgovFileTool.deleteFile(file_path+file_stre_nm);
		}
	}
	
	
	/**
	 * 일정 파일 등록
	 * @param params
	 * @throws Exception
	 */
	@Override
	public void calFileInsert(Map params) throws Exception {
		calMngDAO.calFileInsert(params);
	}
	
	/**
	 * 일정 파일정보 조회
	 */
	@Override
	public List getCalFileList(Map params) throws Exception {
		return calMngDAO.getCalFileList(params);
	}
		
	/**
	 * 일정 파일 삭제
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public void calFileDelete(Map params) throws Exception {
		/* 일정 파일 삭제 */
		calMngDAO.calFileOneDelete(params);
		
		/* 물리적 파일 삭제 */
		String file_stre_nm = (String)params.get("file_stre_nm");		// 저장파일명
		String file_path = (String)params.get("file_path");			// 저장위치
		// 파일 삭제
		EgovFileTool.deleteFile(file_path+file_stre_nm);
	}
}
