package kr.letech.sys.mail.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.letech.cmm.util.EmailSender;
import kr.letech.sys.mail.dao.MailSendDAO;
import kr.letech.sys.mail.service.MailSendService;
import kr.letech.sys.mail.vo.EmailVo;


@Service("mailSendService")
public class MailSendServiceImpl implements MailSendService {
	
	/** mailSendDAO */
	@Resource(name = "mailSendDAO")
	private MailSendDAO mailSendDAO;
	
	@Autowired
	private EmailSender emailSender;
	
	@Autowired
	private EmailVo emailVo;

	@Override
	public void searchMailSend() throws Exception {
		//TODO 시간 테스트
		long start = System.currentTimeMillis(); 
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String str = dayTime.format(new Date(start));
		System.out.println("======================== 시작시간 : "+str+" ========================");
		
		List mailSendList = mailSendDAO.mailSendList();
		
		for(int i = 0; i < mailSendList.size(); i++){
			Map resultMap = (Map) mailSendList.get(i);
			
			setMailContent(resultMap);
			
			int iMailSendCode = emailSender.sendEmail(emailVo);
			resultMap.put("MAIL_SEND", iMailSendCode);
			mailSendDAO.updateSendResult(resultMap);
				
			emailVoReset();
		}
		
		//TODO 시간 테스트
		long end = System.currentTimeMillis();
		String endTime = dayTime.format(new Date(end));
		System.out.println("======================== 종료시간 : "+endTime+" ========================");
		
		if((end-start) > 10000){
			System.out.println("처리시간 : "+(end-start)/1000 +" 초");
		}
	}

	/** 메일로 보낼 기본정보*/
	private void setMailContent(Map resultMap) {
		String fromAddr = resultMap.get("MAIL_FROM").toString();
		String toAddr = resultMap.get("MAIL_TO").toString();
		String subject = resultMap.get("MAIL_SUBJ").toString();
		String content = setContent(resultMap);
		
		emailVo.setFrom(fromAddr);
		emailVo.setReceiver(toAddr);
		emailVo.setSubject(subject);
		emailVo.setContent(content);
	}

	/** 메일의 내용을 정의*/
	private String setContent(Map resultMap) {
		
		StringBuffer sbResult = new StringBuffer();
		
		sbResult.append("<div style='width:740px; backgrond:#444;'>");
		sbResult.append("<div style='position:relative; margin:0; padding:0;height:192px;'>");
		sbResult.append("<img src='http://www.letech.kr/img/mailing/top_bg.jpg' style='margin:0; padding:0;'></div>");
		sbResult.append("<div style='width:706px; min-height:200px; border-left:17px solid #444;border-right:17px solid #444;'>");
		sbResult.append("<div style='width:686;padding:0 10px;'>");
		sbResult.append("<div class='contest_txt'>");
		sbResult.append(resultMap.get("MAIL_CONT"));
		sbResult.append("<br/></div></div></div><div class='mailing_footer' style='clear:both; float:left; width:100%; background:#106e87;'>");
		sbResult.append("<div style='position:relative; float:left; '><div class='footer_logo' style=' float:left; padding:10px 30px 0; '>");
		sbResult.append("<a href='http://intra.letech.kr'><img src='http://www.letech.kr/img/mailing/footer_logo.png'></a></div>");
		sbResult.append("<div class='ft_txt' style=' float:left; '><ul style='float:left; padding:0; list-style:none; color:#d4d4d4;'>");
		sbResult.append("<li><strong>(주) 엘이테크</strong></li>");
		sbResult.append("<li>(우)31456 대전광역시 유성구 유성대로 783번길 25, 2층 (주)엘이테크</li>");
		sbResult.append("<li><strong style='color:#6ebcdd'> Tel. </strong>042-472-0815");
		sbResult.append("<strong style='color:#6ebcdd; margin-left:10px;'> Fax.</strong>042-472-0819</li>");
		sbResult.append("</ul></div></div></div></div>");
		
		return sbResult.toString();
	}
	
//초기화
	private void emailVoReset() {
		emailVo.setFrom("");
		emailVo.setReceiver("");
		emailVo.setSubject("");
		emailVo.setContent("");
	}
}