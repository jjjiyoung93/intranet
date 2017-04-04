package kr.letech.sys.mail.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.letech.aprv.service.impl.AprvMngDAO;
import kr.letech.cmm.util.VarConsts;
import kr.letech.sys.cdm.service.CodeMngService;
import kr.letech.sys.mail.dao.MailAprvDAO;
import kr.letech.sys.mail.dao.MailReceDAO;
import kr.letech.sys.mail.service.MailReceService;


@Service("mailReceService")
public class MailReceServiceImpl implements MailReceService {
	
	/** mailReceDAO */
	@Resource(name="mailReceDAO")
	private MailReceDAO mailReceDAO;
	
	/** mailAprvDAO */
	@Resource(name="mailAprvDAO")
	private MailAprvDAO mailAprvDAO;
	
	/** aprvMngDAO */
	@Resource(name="aprvMngDAO")
	private AprvMngDAO aprvMngDAO;
	
	/** 코드 데이터를 조회위한 서비스 */
	@Resource(name = "codeMngService")
	private CodeMngService codeMngService;

	private String sMessageRece = "수신확인";		//결재승인

	@Override
	public void sendMailConfRece(Map params) throws Exception {
		Map receInfoMap = mailReceDAO.getReceInfo(params);
		
		if(receInfoMap.size() > 0){
			int iReceYn = Integer.parseInt(String.valueOf(receInfoMap.get("RECE_YN")));
			
			if(iReceYn == 0){
				params.put("aprv_no", receInfoMap.get("APRV_NO"));
				params.put("aprv_emp_no", receInfoMap.get("APRV_EMP_NO"));
				
				mailReceDAO.setConfRece(params);
				
				/** 결재관리 상세내용*/
				Map aprvInfoMap = aprvMngDAO.getAprvView(params);
				
				/** 결재자정보 */
				Map lineInfoMap = mailAprvDAO.getAprvLineInfo(params);
				
				apprMailContent(aprvInfoMap, lineInfoMap);
				
				mailAprvDAO.setMailSend(lineInfoMap);
			}
		}
	}
	

	/** 수신확인메일*/
	private void apprMailContent(Map aprvInfoMap, Map lineInfoMap) throws Exception {
		String sMailKind = "APRV";
		String sFromAddr = "support@letech.kr";
		String sSubject = apprSubject(sMessageRece, aprvInfoMap, lineInfoMap);
		String sContent = aprvContent(aprvInfoMap, lineInfoMap);
		
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
	private String aprvContent(Map aprvInfoMap, Map lineInfoMap) {
		StringBuffer sbResult = new StringBuffer();
		
		sbResult.append("<table width=&#34;100%&#34; cellpadding=&#34;0&#34; cellspacing=&#34;0&#34;>");
		sbResult.append("<colgroup><col width=&#34;20%&#34; /><col width=&#34;*&#34; /></colgroup>");
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
		sbResult.append("</td></tr><tr><th>보고내용</th><td><pre style=&#34;white-space: pre-wrap;&#34;>");
		sbResult.append(aprvInfoMap.get("REPT_CONT"));
		sbResult.append("</pre></td></tr>");
		if(lineInfoMap.get("APRV_CONT") != null){
			sbResult.append("<tr><th>상세내용</th><td><pre style=&#34;white-space: pre-wrap;&#34;>");
			sbResult.append(lineInfoMap.get("APRV_CONT"));
			sbResult.append("</pre></td></tr>");
		}
		sbResult.append("</tbody></table><br/>");
		
		return sbResult.toString();
	}
}