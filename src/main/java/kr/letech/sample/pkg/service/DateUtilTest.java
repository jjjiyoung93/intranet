package kr.letech.sample.pkg.service;

import java.time.LocalDate;
import java.util.Map;
import kr.letech.cmm.util.EgovDateUtil;

public class DateUtilTest {

	public static void main(String[] args) {
		System.out.println("=========================날짜번환 테스트 시작=================================");
		EgovDateUtil cal  = new EgovDateUtil();
		
		int year = 0;
		String dayMon = "0101";
		
		LocalDate now = LocalDate.now();
		
		year = now.getYear(); 
		
		dayMon = year + dayMon;
		
		System.out.println("year : "+year);
		System.out.println("dayMon : "+dayMon);
		
		System.out.println("=========================양력 ==> 음력=================================");
		
		
		Map<String, String> date = EgovDateUtil.toLunar("20211229");
		
		
		System.out.println("=========================결과값 : "+date.get("day")+"=================================");
		
		
		System.out.println("=========================음력 ==> 양력=================================");
		
		String solarDt = EgovDateUtil.toSolar(dayMon, 0);
		
		
		System.out.println("=========================결과값 : "+solarDt+"=================================");
	
		System.out.println("=========================날짜번환 테스트 죵료=================================");
		
	}

}
