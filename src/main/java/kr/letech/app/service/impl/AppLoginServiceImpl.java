package kr.letech.app.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.letech.app.service.AppLoginService;
import kr.letech.cmm.util.EgovFileScrty;
import kr.letech.cmm.util.EgovStringUtil;

@Service("appLoginService")
public class AppLoginServiceImpl implements AppLoginService {

	private static final String keyString = "intra_letech";
	
	@Resource(name="appLoginDAO")
	private AppLoginDAO appLoginDAO;
	
	@Override
	public EgovMap getSelectAppLogin(Map<String, Object> params) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();

		String ussId = EgovStringUtil.nullConvert(params.get("ussId"));
		String ussPwd = EgovStringUtil.nullConvert(params.get("ussPwd"));
		String certNo = EgovStringUtil.nullConvert(params.get("certNo"));
		String tokenKey = EgovStringUtil.nullConvert(params.get("tokenKey"));
		String pushYn = EgovStringUtil.nullConvert(params.get("pushYn"));

		if (certNo == null || "".equals(certNo)) {
			// 인증키 정보가 없을경우
			params.put("ussPwd", EgovFileScrty.encryptPassword(ussPwd, ussId));
			map = appLoginDAO.getSelectAppLogin(params);
		} else {
			// 인증키 정보가 있을경우
			map = appLoginDAO.getSelectAppLoginCret(params);
		}

		
		EgovMap egovMap = new EgovMap();
		if(map != null){
			egovMap.putAll(map);
			egovMap.put("certNo", certNo);
			egovMap.put("tokenKey", tokenKey);
			egovMap.put("pushYn", pushYn);

			if (!"".equals(egovMap.get("ussId"))) {
				// 로그인 성공
				egovMap.put("loginType", "success");
				egovMap.put("certNo", getCertification(egovMap));
			} else {
				// 로그인 실패
				egovMap.put("loginType", "failure");
			}
			
		}else{
			// 로그인 실패
			egovMap.put("loginType", "failure");
			
		}

		return egovMap;
	}
	
	/**
	 * 폰 토큰 정보 저장 및 인증번호 생성
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	private String getCertification(EgovMap params) throws Exception {
		String certNo = "";
		if (params.get("certNo") == null || ("").equals(params.get("certNo"))) {
			// 회원 인증 번호
			certNo = EgovFileScrty.encryptPassword((String) params.get("ussId"), keyString);
			params.put("certNo", certNo);
		} else {
			certNo = (String) params.get("certNo");
		}

		appLoginDAO.insertAppMng(params);

		return certNo;
	}
	
	
	@Override
	public EgovMap getSelectSettingInfo(Map<String, Object> params) throws Exception {
			EgovMap egovMap = appLoginDAO.getSelectSettingInfo(params);
			return egovMap;
	}

	
}
