package kr.letech.app.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.google.android.gcm.server.Message;

import kr.letech.app.service.AppPushService;
import kr.letech.app.util.GCMServerSide;

@Service("appPushService")
public class AppPushServiceImple implements AppPushService {

	@Resource(name = "appPushDAO")
	private AppPushDAO appPushDAO;

	public void googlePushSend(Map<String, Object> params) throws Exception {

		// 구글 푸시 발송될 폰 토큰 정보 조회
		List<String> list = appPushDAO.getSelectAppPushList(params);

		if (list.size() > 0) {
			String title = (String) params.get("title");
			String bbsSeq = (String) params.get("bbs_seq");

			Message message = new Message.Builder().addData("title", "[공지사항]" + title).addData("data", "data")
					.addData("bbsSeq", bbsSeq).addData("bName", "BB0001").build();

			GCMServerSide gcm = new GCMServerSide();

			try {
				gcm.sendMessage(message, list);
			} catch (Exception e) {

			}

		}
	}

	public void googlePushSendPayment(Map<String, Object> params) throws Exception {

		// 구글 푸시 발송될 폰 토큰 정보 조회
		List<String> list = appPushDAO.getSelectAppPushListPayment(params);

		if (list.size() > 0) {
			String title = (String) params.get("title");
			String bbsSeq = (String) params.get("bbs_seq");
			String aprv_no = (String) params.get("aprv_no");
			String line_chk = (String) params.get("line_chk");
			String conf_yn = (String) params.get("conf_yn");

			Message message = new Message.Builder().addData("title", "[LETECH] 확인할 정보가 있습니다.")
					.addData("aprvNo", aprv_no).addData("lineChk", line_chk).addData("confYn", conf_yn).build();

			GCMServerSide gcm = new GCMServerSide();

			gcm.sendMessage(message, list);
		}
	}
}
