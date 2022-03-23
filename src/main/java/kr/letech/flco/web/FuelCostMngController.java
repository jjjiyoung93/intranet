package kr.letech.flco.web;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.letech.cmm.util.VarConsts;

@Controller
@RequestMapping("/flco")
public class FuelCostMngController {

	/**
	 * 유류비 관리 목록 조회
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/flco00List.do")
	public String getFuelCostList() throws Exception {
		return "letech/flco/flco00List";
	}

	/**
	 * 유류비 관리 등록 및 수정 화면
	 * 
	 * @return
	 */
	@RequestMapping("/flco00Form.do")
	public String flcoInsertForm(@RequestParam Map paraMap, Model model) {
		String mode = (String) paraMap.get("mode");
		
		if (mode != null && mode.equals(VarConsts.MODE_U)) {
			model.addAttribute("mode", mode);
		}

		return "letech/flco/flco00Form";
	}

	@RequestMapping("/flco00View.do")
	public String fnclView() {
		return "letech/flco/flco00View";
	}
}
