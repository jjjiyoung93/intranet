package kr.letech.vct.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.letech.cmm.util.ReqUtils;
import kr.letech.vct.service.VctMngService;

@Controller
public class VctMngController {
	
	/** vctMngService */
	@Resource(name = "vctMngService")
	private VctMngService vctMngService;
	
	/**
	 * 휴가부여일수 조회
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "sys/vct/vctDay00List.do")
	public String getVctDayList(HttpServletRequest request, ModelMap model) throws Exception {
		
		Map params = ReqUtils.getParameterMap(request);
		
		// searchGubun2 파라미터 값이 없으면 기본값으로 빈 값 추가
		if(StringUtils.isEmpty((String)params.get("searchGubun2"))) {
			params.put("searchGubun2", "");
		}
		
		//목록 및 총건수, 페이징
		Map vctDayObject = vctMngService.getVctDayPageingList(params);
		
		
		model.addAttribute("cPage", vctDayObject.get("cPage"));					// 페이지수
		model.addAttribute("totalCnt", vctDayObject.get("totalCnt"));				// 총건수
		model.addAttribute("intListCnt", vctDayObject.get("intListCnt"));			// 시작페이지 수
		model.addAttribute("resultList", vctDayObject.get("resultList"));			// 목록정보
		model.addAttribute("pageNavigator", vctDayObject.get("pageNavigator"));	// 페이징
		model.addAttribute("params", params);
		
		
		
		
		return "letech/vct/day/vctDay00List";
	}

	@RequestMapping(value = "sys/vct/vct00Tran.do")
	public String tran(HttpServletRequest request, ModelMap model) throws Exception {
		Map params = ReqUtils.getParameterMap(request);
		List<Map> vctMapList = new ArrayList<Map>();
		
		Set  keySet =  params.keySet();
		Iterator itr = keySet.iterator();
		String key = null;
		String ussId = null;
		String stddYr = (String)params.get("searchGubun2");
		while(itr.hasNext()) {
			key = itr.next().toString();
			if(StringUtils.contains(key, "vct_grnt_day")) {
				int separIdx = key.indexOf("-");
				ussId = StringUtils.substring(key, separIdx+1);
				Map vctMap = new HashMap();
				vctMap.put("uss_id", ussId);
				vctMap.put("vct_grnt_day", Integer.valueOf((String)params.get(key)));
				vctMap.put("stdd_yr", stddYr);
				vctMapList.add(vctMap);
			}
		}
		params.put("vctMapList", vctMapList);
		
		int resultCnt = 0;
		String msg = null;
		try {
			resultCnt = vctMngService.mergeVctDay(params);
			msg = "0000";
			
		} catch (Exception e) {
			msg = "9999";
		}

		model.addAttribute("resultCnt", resultCnt);
		model.addAttribute("resultMsg", msg);
		model.addAttribute("params", params);
		
		return "letech/vct/day/vctDay00Tran";
	}
	
	
}
