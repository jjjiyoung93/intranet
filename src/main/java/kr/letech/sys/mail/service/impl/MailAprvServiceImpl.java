package kr.letech.sys.mail.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.aspectj.weaver.ast.Var;
import org.springframework.stereotype.Service;

import kr.letech.aprv.service.impl.AprvMngDAO;
import kr.letech.cmm.util.VarConsts;
import kr.letech.sys.cdm.service.CodeMngService;
import kr.letech.sys.mail.dao.MailAprvDAO;
import kr.letech.sys.mail.service.MailAprvService;


@Service("mailAprvService")
public class MailAprvServiceImpl implements MailAprvService {
	
	/** mailAprvDAO */
	@Resource(name="mailAprvDAO")
	private MailAprvDAO mailAprvDAO;
	
	/** aprvMngDAO */
	@Resource(name="aprvMngDAO")
	private AprvMngDAO aprvMngDAO;
	
	/** 코드 데이터를 조회위한 서비스 */
	@Resource(name = "codeMngService")
	private CodeMngService codeMngService;

	private String sMessageRetr = "반려";			//결재반려
	private String sMessageDefe = "보류";			//결재보류
	private String sMessageAppr = "승인";			//결재승인
	private String sMessageRece = "수신확인";		//결재승인
	
	@Override
	public void aprvMailSendInsert(Map params) throws Exception {
		// TODO Auto-generated method stub
		
		String sMode = String.valueOf(params.get("mode"));
		String sMessage = null;
		
		//최초 글을 등록할때 실행
		if(VarConsts.MODE_I.equals(sMode)){
			//라인 갯수
			int iAprvLineCnt = 0;
			if (params.get("aprv_line_cnt") != null) {
				iAprvLineCnt = Integer.parseInt(String.valueOf(params.get("aprv_line_cnt")));
			}
			
			for(int idx = 1; idx <= iAprvLineCnt; idx++){
				int iAprvOrdr = Integer.parseInt(String.valueOf(params.get("aprv_ordr" + idx)));
				if(iAprvOrdr <= 1){
					params.put("aprv_emp_no", params.get("aprv_emp_no" + idx));
					params.put("aprv_ordr", params.get("aprv_ordr" + idx));
					params.put("aprv_ym", params.get("aprv_ym" + idx));
					params.put("aprv_yn_cd", params.get("aprv_yn_cd" + idx));
					params.put("refe_yn", params.get("refe_yn" + idx) == null ? "N" : params.get("refe_yn" + idx));

					/** 결재관리 상세내용*/
					Map aprvInfoMap = aprvMngDAO.getAprvView(params);
					
					/** 결재자정보 */
					Map lineInfoMap = mailAprvDAO.getAprvLineInfo(params);
					
					aprvMailContent(aprvInfoMap, lineInfoMap);
					
					mailAprvDAO.setMailSend(lineInfoMap);
				}
			}
		}else if(VarConsts.MODE_U.equals(sMode)){
			// 결재 라인 수정
			if ("0".equals(params.get("aprv_line_cd"))) {
				mailAprvDAO.outMailSend(params);
				
				int iAprvLineCnt = 0;
				if (params.get("aprv_line_cnt") != null) {
					iAprvLineCnt = Integer.parseInt(String.valueOf(params.get("aprv_line_cnt")));
				}
				
				for(int idx = 1; idx <= iAprvLineCnt; idx++){
					int iAprvOrdr = Integer.parseInt(String.valueOf(params.get("aprv_ordr" + idx)));
					
					if(iAprvOrdr <= 1){
						params.put("aprv_emp_no", params.get("aprv_emp_no" + idx));
						params.put("aprv_ordr", params.get("aprv_ordr" + idx));
						params.put("aprv_ym", params.get("aprv_ym" + idx));
						params.put("aprv_yn_cd", params.get("aprv_yn_cd" + idx));
						params.put("refe_yn", params.get("refe_yn" + idx) == null ? "N" : params.get("refe_yn" + idx));

						/** 결재관리 상세내용*/
						Map aprvInfoMap = aprvMngDAO.getAprvView(params);
						
						/** 결재자정보 */
						Map lineInfoMap = mailAprvDAO.getAprvLineInfo(params);
						
						aprvMailContent(aprvInfoMap, lineInfoMap);
						
						mailAprvDAO.setMailSend(lineInfoMap);
					}
				}
			}else if("2".equals(params.get("aprv_line_cd")) || "3".equals(params.get("aprv_line_cd"))){
				/* 반려나 보류일경우 해당 결재라인의 정보를 대기로 변경 */
				int iAprvLineCnt = 0;
				if (params.get("aprv_line_cnt") != null) {
					iAprvLineCnt = Integer.parseInt(String.valueOf(params.get("aprv_line_cnt")));
				}
				
				for(int idx = 1; idx <= iAprvLineCnt; idx++){
					int iAprvOrdr = Integer.parseInt(String.valueOf(params.get("aprv_ordr" + idx)));
					
					if(iAprvOrdr <= 1){
						params.put("aprv_emp_no", params.get("aprv_emp_no" + idx));
						params.put("aprv_ordr", params.get("aprv_ordr" + idx));
						params.put("aprv_ym", params.get("aprv_ym" + idx));
						params.put("aprv_yn_cd", params.get("aprv_yn_cd" + idx));
						params.put("refe_yn", params.get("refe_yn" + idx) == null ? "N" : params.get("refe_yn" + idx));

						/** 결재관리 상세내용*/
						Map aprvInfoMap = aprvMngDAO.getAprvView(params);
						
						/** 결재자정보 */
						Map lineInfoMap = mailAprvDAO.getAprvLineInfo(params);
						
						aprvMailContent(aprvInfoMap, lineInfoMap);
						
						mailAprvDAO.setMailSend(lineInfoMap);
					}
				}
			}else{
				/** 결재관리 상세내용*/
				Map aprvInfoMap = aprvMngDAO.getAprvView(params);
				
				/** 결재자정보 */
				Map lineInfoMap = mailAprvDAO.getAprvLineInfo(params);
				
				String sAprvYnCd = String.valueOf(params.get("aprv_yn_cd"));
				if(!VarConsts.APRV_COND_WAIT.equals(sAprvYnCd)){				//대기
					if(VarConsts.APRV_COND_APPR.equals(sAprvYnCd)){				//승인
						sMessage = sMessageAppr;
						
						int iRefeLineCnt = mailAprvDAO.getRefeCount(params);
						int iAprvLineCnt = Integer.parseInt(String.valueOf(params.get("aprv_line_cnt")))-iRefeLineCnt;
						int iAprvOrdr = Integer.parseInt(String.valueOf(lineInfoMap.get("APRV_ORDR")));
						
						
						if(iAprvOrdr < iAprvLineCnt){
							int iUpAprvOrdr = ++iAprvOrdr < iAprvLineCnt ?iAprvOrdr :iAprvLineCnt;
							
							params.put("upp_line", iUpAprvOrdr);
							
							Map uppLineInfoMap = mailAprvDAO.getUppAprvLineInfo(params);
							
							aprvMailContent(aprvInfoMap, uppLineInfoMap);
							
							mailAprvDAO.setMailSend(uppLineInfoMap);
						}
					}else if(VarConsts.APRV_COND_DEFE.equals(sAprvYnCd)){		//보류
						sMessage = sMessageDefe; 
					}else if(VarConsts.APRV_COND_RETR.equals(sAprvYnCd)){		//반려
						sMessage = sMessageRetr;
					}
					
					apprMailContent(sMessage, aprvInfoMap, lineInfoMap);
					mailAprvDAO.setMailSend(lineInfoMap);
				}
			}
		}else{
			mailAprvDAO.outMailSend(params);
		}
	}
	
	/** 결재자에게 발송되는 메일 내용 */
	private void aprvMailContent(Map aprvInfoMap, Map lineInfoMap) throws Exception {
		int iMailSeq = mailAprvDAO.getMailSeq();
		String sMailKind = "APRV";
		String sFromAddr = "support@letech.kr";
		String sSubject = aprvSubject(aprvInfoMap);
		String sContent = aprvContent(iMailSeq, aprvInfoMap, lineInfoMap);
		
		lineInfoMap.put("MAIL_SEQ", iMailSeq);
		lineInfoMap.put("MAIL_KIND", sMailKind);
		lineInfoMap.put("MAIL_FROM", sFromAddr);
		lineInfoMap.put("MAIL_SUBJ", sSubject);
		lineInfoMap.put("MAIL_CONT", sContent);
	}

	/** 결재자에게 발송되는 메일 제목*/
	private String aprvSubject(Map aprvInfoMap) throws Exception {
		/*코드리스트 조회를 위한 상위코드입력*/
		aprvInfoMap.put("up_cd", VarConsts.EAM_MASTER_CODE);
		
		List codeList = codeMngService.getCodeList(aprvInfoMap);
		
		for(int i = 0; i < codeList.size(); i++){
			Map codeMap = (Map) codeList.get(i);
			
			if(aprvInfoMap.get("APRV_TYPE_CD").equals(codeMap.get("CD"))){
				aprvInfoMap.put("CD_NM", codeMap.get("CD_NM"));
			}
		}
		
		StringBuffer sbResult = new StringBuffer();
		
		sbResult.append("[결재요청] ");
		sbResult.append(aprvInfoMap.get("REPT_APRV_NM"));
		sbResult.append("님이 ");
		sbResult.append(aprvInfoMap.get("CD_NM"));
		sbResult.append("결재를 요청하였습니다.");
	
		return sbResult.toString();
	}
	
	/** 상신자에게 발송되는 메일 (승인/반려/보류)*/
	private void apprMailContent(String sMessage, Map aprvInfoMap, Map lineInfoMap) throws Exception {
		int iMailSeq = 0;
		String sMailKind = "APRV";
		String sFromAddr = "support@letech.kr";
		String sSubject = apprSubject(sMessage, aprvInfoMap, lineInfoMap);
		String sContent = aprvContent(iMailSeq, aprvInfoMap, lineInfoMap);
		
		lineInfoMap.put("APRV_EMP_NO", aprvInfoMap.get("REPT_APRV_NO"));
		lineInfoMap.put("MAIL_TO", lineInfoMap.get("REPT_APRV_MAIL"));
		lineInfoMap.put("MAIL_FROM", sFromAddr);
		lineInfoMap.put("MAIL_SUBJ", sSubject);
		lineInfoMap.put("MAIL_CONT", sContent);
		lineInfoMap.put("MAIL_KIND", sMailKind);
	}

	/** 상신자에게 발송되는 메일 제목(승인/반려/보류)*/
	private String apprSubject(String sMessage, Map aprvInfoMap, Map lineInfoMap) throws Exception {
		/*코드리스트 조회를 위한 상위코드입력*/
		aprvInfoMap.put("up_cd", VarConsts.EAM_MASTER_CODE);
		
		List codeList = codeMngService.getCodeList(aprvInfoMap);
		
		for(int i = 0; i < codeList.size(); i++){
			Map codeMap = (Map) codeList.get(i);
			
			if(aprvInfoMap.get("APRV_TYPE_CD").equals(codeMap.get("CD"))){
				aprvInfoMap.put("CD_NM", codeMap.get("CD_NM"));
			}
		}
		
		StringBuffer sbResult = new StringBuffer();
		
		sbResult.append("[결재");
		sbResult.append(sMessage);
		sbResult.append("] ");
		sbResult.append(lineInfoMap.get("USS_NM"));
		sbResult.append("님이 ");
		sbResult.append(aprvInfoMap.get("CD_NM"));
		sbResult.append("결재를 ");
		sbResult.append(sMessage);
		sbResult.append("하였습니다.");

		return sbResult.toString();
	}
	
	/** 메일 내용 정의 
	 * @param iMailSeq */
	private String aprvContent(int iMailSeq, Map aprvInfoMap, Map lineInfoMap) {
		
		StringBuffer sbResult = new StringBuffer();
		
		sbResult.append("<table width='100%' cellpadding='0' cellspacing='0'>");
		sbResult.append("<colgroup><col width='20%' /><col width='*' /></colgroup>");
		sbResult.append("<tbody><tr><th>보고자</th><td>");
		sbResult.append(aprvInfoMap.get("REPT_APRV_NM"));
		sbResult.append("</td></tr><tr><th>소속</th><td>");
		sbResult.append(aprvInfoMap.get("DPNM"));
		sbResult.append("</td></tr><tr><th>제목</th><td>");
		sbResult.append(aprvInfoMap.get("TITLE"));
		sbResult.append("</td></tr><tr><th>기간</th><td>");
		sbResult.append(aprvInfoMap.get("TERM_ST_YM"));
		sbResult.append(" ~ ");
		sbResult.append(aprvInfoMap.get("TERM_ED_YM"));
		sbResult.append("</td></tr><tr><th>보고내용</th><td><pre style='white-space: pre-wrap;'>");
		sbResult.append(aprvInfoMap.get("REPT_CONT"));
		sbResult.append("</pre></td></tr>");
		
		if(lineInfoMap.get("APRV_CONT") != null){
			sbResult.append("<tr><th>상세내용</th><td><pre style='white-space: pre-wrap;'>");
			sbResult.append(lineInfoMap.get("APRV_CONT"));
			sbResult.append("</pre></td></tr>");
		}
		
		sbResult.append("</tbody></table><br/>");
		
		if(iMailSeq > 0){
			sbResult.append("<img height='0' width='0' style='display:none;' src='http://intra.letech.kr/letech/uat/uia/mailRec.do?send_id=");
			sbResult.append(iMailSeq);
			sbResult.append("'/>");
		}
		
		return sbResult.toString();
	}
}