package kr.letech.egov;

import java.io.IOException;

import com.google.android.gcm.server.Message;
import com.google.android.gcm.server.Result;
import com.google.android.gcm.server.Sender;

public class GcmSend {

	public static void main(String[] args) {

		String API_KEY = "AIzaSyD8MK-baLU3No6svy-V0ISnIENJYAONgFs";
		String REGISTRATION_ID = "cl3dOrgjecQ:APA91bE1Y1znY-Hn9XC9q-CetCm04C3X6wFTj4DODYTAdmJwtFjNRWtz5c0jlEOUiDPH5t89L1jvre4UHcjT538xqeuyv7RTEUdYOn5SgsZvhQUQW3lC_ouaiWGXTV9nSpl6Gvn3IlQO"; // 단말기 RegID 입력
		
		String sendTlt = "타이틀 제목";
        String sendMsg = "내용 : 메시지가 보입니다";

        Sender sender = new Sender(API_KEY);
         
        //단건
        Result result = null;
        try {
        /**
         * message Build 부분에서 addData로 추가한 값은 어플리케이션의
         * onMessage(context, intent)에서 Intent로 전달되며
         * intent.getExtras().getString("title")형태로 얻어와 사용 가능하다.
         */
        //UTF-8인코딩용
/*        Message message = new Message.Builder()
        .addData("title", URLEncoder.encode(sendTlt, "UTF-8"))
        .addData("msg", URLEncoder.encode(sendMsg, "UTF-8"))
        .build();
*/        
        Message message = new Message.Builder()
        		.addData("title",sendTlt)
        		.addData("msg", sendMsg)
        		.addData("message", sendMsg)
        		.build();

        
        //발송할 메시지, 발송할 타깃(RegistrationId, Retry 횟수)
			result = sender.send(message, REGISTRATION_ID, 2);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        if (result.getMessageId() != null) {
            System.out.println("Send success");
        } else {
            String error = result.getErrorCodeName();
            System.out.println("Send fail : " + error);
        }
		 
        //여러건 보낼때
		/*Message message = new Message.Builder().addData("msg", "push notify").build();
		List<String> list = new ArrayList<String>();
		list.add(REGISTRATION_ID);
		MulticastResult multiResult;
		try {
			multiResult = sender.send(message, list, 5);
			if (multiResult != null) {
				List<Result> resultList = multiResult.getResults();
				for (Result result : resultList) {
					System.out.println(result.getMessageId());
				}
			}
		} catch (IOException e) {
		// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
	}

}
