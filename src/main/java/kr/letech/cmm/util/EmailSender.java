package kr.letech.cmm.util;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Repository;

import kr.letech.sys.mail.vo.EmailVo;

@Repository("emailSender")
public class EmailSender {
	
	@Autowired
	private JavaMailSender mailSender;
	
	public int sendEmail(EmailVo email) throws Exception{
		int result = 0;
		
		MimeMessage msg = mailSender.createMimeMessage();
		
		try {
			MimeMessageHelper helper = new MimeMessageHelper(msg, true, "UTF-8");
			helper.setTo(email.getReceiver());
			helper.setText(email.getContent(), true);
			helper.setFrom(email.getFrom());
			helper.setSubject(email.getSubject());
			
			
        }catch(MessagingException e) {
            System.out.println("MessagingException");
            e.printStackTrace();
            result = 1;
        }
		
        try {
            mailSender.send(msg);
        }catch(MailException e) {
            System.out.println("MailException발생");
            e.printStackTrace();
            result = 2;
        }
        
        return result;
	}
}
