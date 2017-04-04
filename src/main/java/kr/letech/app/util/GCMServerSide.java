package kr.letech.app.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.android.gcm.server.Message;
import com.google.android.gcm.server.MulticastResult;
import com.google.android.gcm.server.Result;
import com.google.android.gcm.server.Sender;

public class GCMServerSide {
	
	// 구글 푸시 API Key (안드로이드 API Key)
	/*private static final Sender sender = new Sender("AIzaSyA0S6auM9tXrGikh1ZAQ_TyhZ43eI83J5Q");*/
	private static final Sender sender = new Sender("AIzaSyA5t9lEso31WD6-k77E41YkhkF00vLT0Zc");
	
	/**
	 * 구글 푸시 발송기능
	 * @param message
	 * @param list
	 * @throws IOException
	 */
	public void sendMessage(Message message, List<String> list) throws IOException {
		 
		MulticastResult multiResult = sender.send(message, list, 5);
		 
		if (multiResult != null) {
			List<Result> resultList = multiResult.getResults();
		 
			for (Result result : resultList) {
				System.out.println(result.getMessageId());
			}
		}
	}
	
	public void sendMessageTest() throws IOException {
		// 구글 푸시 API Key(안드로이드 API Key)
		Sender sender = new Sender("AIzaSyA5t9lEso31WD6-k77E41YkhkF00vLT0Zc");
		// 폰 토큰키 정보
		String regId = "cqZRz7gkLQc:APA91bF2pvNfodZsBr3qL6xQSD5mgE7t63NCI41DCK6hCLAxKWX8WmoqQF7p-XMwo8H3MxXe7BOYHRk-b-tJ4nRRkgVL84kgnDv65ltwfYmz_d9tFL9TCazsdcbu8Bu8tOnSrxqVrGFv";
		//Sender sender = new Sender("AIzaSyD8MK-baLU3No6svy-V0ISnIENJYAONgFs");
		//String regId = "cl3dOrgjecQ:APA91bE1Y1znY-Hn9XC9q-CetCm04C3X6wFTj4DODYTAdmJwtFjNRWtz5c0jlEOUiDPH5t89L1jvre4UHcjT538xqeuyv7RTEUdYOn5SgsZvhQUQW3lC_ouaiWGXTV9nSpl6Gvn3IlQO";
//		Message message = new Message.Builder().addData("msg", "push notify").build();

		String sendTlt = "타이틀 제목";
        String sendMsg = "내용 : 메시지가 보입니다";
        
        Message message = new Message.Builder()
        		.addData("title",sendTlt)
//        		.addData("message", sendMsg)
        		.addData("seq", "1")
        		.build();
				
		List<String> list = new ArrayList<String>();
		list.add(regId);
		 
		MulticastResult multiResult = sender.send(message, list, 5);
		 
		if (multiResult != null) {
			List<Result> resultList = multiResult.getResults();
		 
			for (Result result : resultList) {
				System.out.println(result.getMessageId());
			}
		}
	}
	 
	public static void main(String[] args) throws Exception {
		GCMServerSide s = new GCMServerSide();
		s.sendMessageTest();
	}
}
