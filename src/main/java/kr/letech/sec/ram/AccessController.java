package kr.letech.sec.ram;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AccessController {

	 /**
	 * 권한제한 화면 이동
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping("/sec/ram/accessDenied.do")
    public String accessDenied()
            throws Exception {
        return "letech/error/accessDenied";
    }
    
    
/* 임시 사용 Start */
    @RequestMapping("/error/exception.do")
    public String exception()
            throws Exception {
        return "letech/error/exception";
    }
    @RequestMapping("/error/null.do")
    public String nullMethod()
            throws Exception {
        return "letech/error/null";
    }
    @RequestMapping("/error/sql.do")
    public String sql()
            throws Exception {
        return "letech/error/sql";
    }
/* 임시 사용 End */
}
