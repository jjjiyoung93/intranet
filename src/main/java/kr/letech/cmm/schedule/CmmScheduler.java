package kr.letech.cmm.schedule;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.TimeZone;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.letech.aprv.service.AprvMngService;
import kr.letech.cal.service.HolidayMngService;
import kr.letech.cal.service.impl.CalMngDAO;
import kr.letech.cmm.util.EgovDateUtil;
import kr.letech.cmm.util.EgovProperties;
import kr.letech.uss.umt.service.impl.UssMngDAO;

@Component
public class CmmScheduler {

	private static final Logger log = LoggerFactory.getLogger(EgovProperties.class);
	
	/**
	 * 메일보내기 관리 서비스
	 */
//	@Resource(name = "mailSendService")
//	private MailSendService mailSendService;
	
	@Resource(name = "aprvMngService")
	private AprvMngService aprvMngService;

//	@Scheduled(fixedDelay=30000)
//	public void mailSender() throws Exception {
//		mailSendService.searchMailSend();
//	}
	
	/**
	 * UssMngDAO
	 */
	@Resource(name = "ussMngDAO")
	private UssMngDAO ussMngDAO;
	
	/**
	 *  CalMngDAO
	 */
	@Resource(name = "calMngDAO")
	private CalMngDAO calMngDAO;
	
	
	/** holidayMngService */
	@Resource(name = "holidayMngService")
	private HolidayMngService holidayMngService;
	
	

	/**
	* 비즈플레이 배치
	* @Method : bizplayAPI
	* @Author : JO MIN SOO
	* @Date : 2021. 1. 6.
	*/
	@Scheduled(cron = "0 0 07,21 * * *") // 매일 오전 7시, 오후 9시에 
	public void bizplayAPI() {
		Map<String, Object> params = new HashMap<String, Object>(); // 넘겨줄 파라미터
		
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd", Locale.getDefault()); // 날짜 포맷 지정
		Calendar cal = Calendar.getInstance(); // 오늘 날짜  가져오기
		
		String endDate = df.format(cal.getTime()); // 종료일
		
		cal.add(Calendar.MONTH, -1); // 한달 전
		String startDate = df.format(cal.getTime());
		
		params.put("START_DATE", startDate);
		params.put("END_DATE", endDate);
		
		// BIZPLAY 데이터 호출하여 DB에 저장
		try {
			aprvMngService.insertBizplayData(params);
		} catch (Exception e) {
			log.error("[BIZPLAY] 비즈플레이 데이터 적재 실패");
		}
		
		// 저장된 BIZPLAY 데이터를 이용하여 결재 데이터 생성
		try {
			aprvMngService.insertBizplayAprv(params);
		} catch (Exception e) {
			log.error("[BIZPLAY] 결재 데이터 생성 실패");
		}
	}
	
	
	
	
	/**
	 * 매년 말 사용자의 내년 생일 등록 
	 */
	 @Scheduled(cron = "0 0 0 31 12 ?") 
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public void ussBirthday() {
		Map<String, Object> params = new HashMap<String, Object>(); // 넘겨줄 파라미터
		//파라미터 생성
		try {
			List<Map> ussList = ussMngDAO.getWorkUssList(params);
			Map calMap = null;
			
			for (Map ussView : ussList) {
				String ussId = (String)ussView.get("USS_ID");
				String ussNm = (String)ussView.get("USS_NM");
				String birCalSeq = String.valueOf(ussView.get("BIR_CAL_SEQ"));
				String birthType = (String)ussView.get("USS_BIRTH_DAY_TYPE");
				String birthDate = (String)ussView.get("USS_BIRTH_DAY");
				String ussAuthNm = (String)ussView.get("USS_AUTH_NM");
				
				params.put("uss_id", ussId);
				
				if(StringUtils.isNotEmpty(birthType) && StringUtils.isNotEmpty(birthDate)) {
					
					/*2022.01.19 생일을 캘린더에 등록 후 캘린더 번호 사원 테이블에 저장 : BEGIN*/
					Date today = new Date();
					
					SimpleDateFormat formatter = new SimpleDateFormat("yyyy");
					
					String thisYear = formatter.format(today);
					
					int yearNum = Integer.valueOf(thisYear);
					
					int nextYearNum = yearNum + 1 ;
					
					String nextYear = String.valueOf(nextYearNum);
					
					String birthday = "";
					String birthdayConv = "";
					String birthYear = "";
					String birthMon = "";
					String birthDays = "";
					//양력일 경우
					if(StringUtils.equals(birthType, "S")) {
						birthYear = nextYear;
						birthday = nextYear+"-"+birthDate;
					}else if(StringUtils.equals(birthType, "L")) {
						birthday = nextYear+"-"+birthDate;
						birthday = birthday.replaceAll("-", "");
						birthdayConv = EgovDateUtil.toSolar(birthday, 0);
						
						//음력일 경우
						birthYear = birthdayConv.substring(0, 4);
						
						int yearConvNum = Integer.valueOf(birthYear);
						
						if(yearConvNum > nextYearNum) {
							birthYear = thisYear;
							birthday = birthYear+birthDate;
							birthday = birthday.replaceAll("-", "");
							birthdayConv = EgovDateUtil.toSolar(birthday, 0);
							birthYear = birthdayConv.substring(0, 4);
							
						}
						birthMon = birthdayConv.substring(4, 6);
						birthDays = birthdayConv.substring(6);
						
						birthday = birthYear + "-" + birthMon + "-" + birthDays; 

					}
					
					calMap = new HashMap();
					calMap.put("cal_nm", ussNm + " "+ussAuthNm+ " 생일");
					calMap.put("cal_content", birthYear + " 년도 " + ussNm + " " + ussAuthNm + " 생일");
					calMap.put("cal_st_dt", birthday);
					calMap.put("cal_ed_dt", birthday);
					/*날짜 만들기(음력 시 양력 변화 필요) : END*/
					calMap.put("uss_id", ussId);
					calMap.put("aprv_yn", "N");
					
					//캘린더 정보 추가
					int calSeq = calMngDAO.calInsert(calMap);
					
					params.put("bir_cal_seq", calSeq);
					
					//추가한 캘린더 시퀀스 번호 사용자 정보 등록
					ussMngDAO.updateBirCalSeq(params);
					
					/*2022.01.19 생일을 캘린더에 등록 후 캘린더 번호 사원 테이블에 저장 : END*/ 
					
				}
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
	}
	
	/**
	 * 매년 첫 날 재직중인 사원 근속년수 수정 
	 */
	@Scheduled(cron = "0 0 0 1 1 ?") 
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public void ussWorkYrCnt()  {
		Map<String, Object> params = new HashMap<String, Object>(); // 넘겨줄 파라미터
		
		try {
			ussMngDAO.updateWorkYrCnt(params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	 
	 /**
	  * 매년 12월 1일 다음 해 휴일 정보 저장
	  */
	 @Scheduled(cron = "0 0 0 1 12 ?") 
	 @Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	 public void insertHoliday()  {
		 Map<String, Object> params = new HashMap<String, Object>(); // 넘겨줄 파라미터
		 
		 Date today = new Date();
		 
		 SimpleDateFormat formatter = new SimpleDateFormat("yyyy");
		 
		 String thisYr = formatter.format(today);
		 int thisYrNum = Integer.valueOf(thisYr);
		 int nextYrNum = thisYrNum + 1;
		 String nextYr = String.valueOf(nextYrNum);
		 
		 params.put("stdd_yr", nextYr);
		 
		 try {
			 holidayMngService.holMngUpdateBySys(params);
		 } catch (Exception e) {
			 e.printStackTrace();
		 }
		 
	 }
	 
	
	
	
	
}
