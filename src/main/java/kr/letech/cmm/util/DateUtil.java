package kr.letech.cmm.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

public class DateUtil {

	/**
	 * 현재 년월일(0000-00-00) 구하기
	 * @return
	 */
	public String nowDate(){
		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy-MM-dd", Locale.KOREA );
		Date currentTime = new Date ( );
		String dTime = formatter.format ( currentTime );
		
		return dTime;
	}
	
	public String datePlus(String now_date, int day){
		String new_date = "";
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		try{
			Date date = df.parse(now_date);
			
			// 날짜 더하기
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			cal.add(Calendar.DATE, day);
			
			new_date = df.format(cal.getTime());
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return new_date;
	}
	
	public static void main(String[] args) throws Exception {
		DateUtil dt = new DateUtil();
		System.out.println(dt.datePlus("2015-08-30", 6));
	}
}
