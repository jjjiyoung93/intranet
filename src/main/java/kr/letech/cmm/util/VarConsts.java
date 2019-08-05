package kr.letech.cmm.util;

public class VarConsts {
	/* ======================================= SESSION */
	/**
	 *  종류 = SESSION<br>
	 *  타입 = String<br>
	 *  값   = 'SESSION_USER' <br>
	 */	
	public static final String SESS_USER = "SESSION_USER";
	
	/**
	 *  종류 = SESSION<br>
	 *  타입 = String<br>
	 *  값   = 'SESSION_USER'<br> 
	 */	
	public static final String SESS_INDEX = "SESSION_INDEX";
	

	
	/*수정 삭제 저장*/
	
	/**
	 * 종류 = 입력 <br>
	 * 타입 = String<br>
	 * 값 = 'INSERT'<br>
	 */
	public static final String MODE_I = "INSERT";
	
	/**
	 * 종류 = 수정 <br>
	 * 타입 = String<br>
	 * 값 = 'UPDATE'<br>
	 */
	public static final String MODE_U = "UPDATE";
	
	/**
	 * 종류 = 삭제<br>
	 * 타입 = String<br>
	 * 값 = 'DELETE'<br>
	 */
	public static final String MODE_D = "DELETE";
	
	/**
	 * 종류 = 전체삭제 <br>
	 * 타입 = String<br>
	 * 값 = 'DELETE_ALL'<br>
	 */
	public static final String MODE_DA = "DELETE_ALL";
	
	/**
	 * 종류 = 답변 <br>
	 * 타입 = String<br>
	 * 값 = 'INSERT'<br>
	 */
	public static final String MODE_R = "REPLY";
	
	
	/*이하 코드*/
	
	/**
	 * 종류 = 결재구분코드 (마스터)<br>
	 * 타입 = String<br>
	 * 값 = 'CD0002'<br>
	 */
	public static final String EAM_MASTER_CODE = "CD0001";
	
	/**
	 * 종류 = 결재구분코드 (업무보고)<br>
	 * 타입 = String<br>
	 * 값 = 'CD0010'<br>
	 */
	public static final String EAM_WORK_CODE = "CD0001001";
	
	/**
	 * 종류 = 결재구분코드 (휴가)<br>
	 * 타입 = String<br>
	 * 값 = 'CD0011'<br>
	 */
//	public static final String EAM_VACATION_CODE = "CD0001002";
	/*
	 * 현재 휴가 코드가 CD0001011로 사용되고 있음.
	 */
	public static final String EAM_VACATION_CODE = "CD0001011";
	
	/**
	 * 종류 = 결재구분코드 (출장)<br>
	 * 타입 = String<br>
	 * 값 = 'CD0012'<br>
	 */
	public static final String EAM_BUSITRIP_CODE = "CD0001003";
	
	/**
	 * 종류 = 결재구분코드 (파견)<br>
	 * 타입 = String<br>
	 * 값 = 'CD0013'<br>
	 */
	public static final String EAM_BUSISEND_CODE = "CD0001004";
	
	/**
	 * 종류 = 프로젝트코드 <br>
	 * 타입 = String<br>
	 * 값 = 'CD0002'<br>
	 */
	public static final String EAM_PROJECT_CODE = "CD0002" ;
	
	/**
	 * 종류 = 메뉴타입코드<br>
	 * 타입 = String<br>
	 * 값 = 'CD0003'<br>
	 */
	public static final String SYS_MNMTYPE_CODE = "CD0003";
	
	/**
	 * 종류 = 권한구분타입코드<br>
	 * 타입 = String<br>
	 * 값 = 'CD0005'<br>
	 */
	public static final String SYS_AUTH_CODE = "CD0006";
	
	/**
	 * 종류 = 사용자구분타입코드<br>
	 * 타입 = String<br>
	 * 값 = 'CD0005'<br>
	 */
	public static final String SYS_USER_CODE = "CD0005";

	/** 
	 * 종류 = 게시판타입코드<br>
	 * 타입 = String<br>
	 * 값 = 'CD0004'<br>
	 */
	public static final String SYS_BBS_TYPE_CODE = "CD0004";
	
	/** 
	 * 종류 = 게시판레이아웃코드<br>
	 * 타입 = String<br>
	 * 값 = 'CD0007'<br>
	 */
	public static final String SYS_BBS_LAYOUT_TY = "CD0007";
	
	/* 에러 메일 발송 코드 */
	
	/** 
	 * 종류 = 에러 메일 발송코드<br>
	 * 타입 = String<br>
	 * 값 = 'ERROR'<br>
	 */
	public static final String MAIL_SEND_ERROR = "ERROR";
	
	/* 결재 메일 발송 코드 */
	
	/** 
	 * 종류 = 결재 요청 메일 발송코드<br>
	 * 타입 = String<br>
	 * 값 = 'APRV'<br>
	 */
	public static final String MAIL_SEND_APRV_REQU = "APRV";
	
	/** 
	 * 종류 = 결재 대기 메일 발송코드<br>
	 * 타입 = String<br>
	 * 값 = 'WAIT'<br>
	 */
	public static final String MAIL_SEND_APRV_WAIT = "WAIT";
	
	/** 
	 * 종류 = 결재 반려 메일 발송코드<br>
	 * 타입 = String<br>
	 * 값 = 'RETR'<br>
	 */
	public static final String MAIL_SEND_APRV_RETR = "RETR";
	
	/** 
	 * 종류 = 결재 보류 메일 발송코드<br>
	 * 타입 = String<br>
	 * 값 = 'DEFE'<br>
	 */
	public static final String MAIL_SEND_APRV_DEFE = "DEFE";
	
	/** 
	 * 종류 = 결재 승인 메일 발송코드<br>
	 * 타입 = String<br>
	 * 값 = 'APPR'<br>
	 */
	public static final String MAIL_SEND_APRV_APPR = "APPR";
	
	/** 
	 * 종류 = 메일 수신 확인 발송코드<br>
	 * 타입 = String<br>
	 * 값 = 'RECE'<br>
	 */
	public static final String MAIL_SEND_APRV_RECE = "RECE";
	
	/* 결재 상태 코드*/
	
	/** 
	 * 종류 = 결재 대기 상태 코드<br>
	 * 타입 = String<br>
	 * 값 = '0'<br>
	 */
	public static final String APRV_COND_WAIT = "0";
	
	/** 
	 * 종류 = 결재 승인 상태 코드<br>
	 * 타입 = String<br>
	 * 값 = '1'<br>
	 */
	public static final String APRV_COND_APPR = "1";
	
	/** 
	 * 종류 = 결재 보류 상태 코드<br>
	 * 타입 = String<br>
	 * 값 = '2'<br>
	 */
	public static final String APRV_COND_DEFE = "2";
	
	/** 
	 * 종류 = 결재 반려 상태 코드<br>
	 * 타입 = String<br>
	 * 값 = '3'<br>
	 */
	public static final String APRV_COND_RETR = "3";
	
}
