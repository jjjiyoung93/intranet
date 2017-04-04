package kr.letech.app.util;

import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

/**
 * <pre>
 * FileName: ParameterWrapper.java
 * Package : kr.letech.app.util
 * 
 * Request의 Parameter를 set 하기위한
 * HttpServletRequestWrapper 확장 클래스
 *
 * </pre>
 * 
 * @author : ksk
 * @date : 2016. 5. 3.
 */
public class ParameterWrapper extends HttpServletRequestWrapper {
	private HashMap<String, Object> params;

	/**
	 * <pre>
	 * 
	 * request param set
	 *
	 * </pre>
	 * 
	 * @author : ksk
	 * @date : 2016. 4. 27.
	 * @param request
	 */
	@SuppressWarnings("unchecked")
	public ParameterWrapper(HttpServletRequest request) {
		super(request);
		this.params = new HashMap<String, Object>(request.getParameterMap());
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.ServletRequestWrapper#getParameter(java.lang.String)
	 */
	public String getParameter(String name) {
		String returnValue = null;
		String[] paramArray = getParameterValues(name);
		if (paramArray != null && paramArray.length > 0) {
			returnValue = paramArray[0];
		}
		return returnValue;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.ServletRequestWrapper#getParameterMap()
	 */
	public Map getParameterMap() {
		return Collections.unmodifiableMap(params);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.ServletRequestWrapper#getParameterNames()
	 */
	public Enumeration<String> getParameterNames() {
		return Collections.enumeration(params.keySet());
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * javax.servlet.ServletRequestWrapper#getParameterValues(java.lang.String)
	 */
	public String[] getParameterValues(String name) {
		String[] result = null;
		String[] temp = (String[]) params.get(name);
		if (temp != null) {
			result = new String[temp.length];
			System.arraycopy(temp, 0, result, 0, temp.length);
		}
		return result;
	}

	/**
	 * <pre>
	 * 
	 * request param set
	 *
	 * </pre>
	 * 
	 * @author : ksk
	 * @date : 2016. 4. 27.
	 * @param name
	 * @param value
	 */
	public void setParameter(String name, String value) {
		String[] oneParam = { value };
		setParameter(name, oneParam);
	}

	/**
	 * <pre>
	 * 
	 * request param set
	 *
	 * </pre>
	 * 
	 * @author : ksk
	 * @date : 2016. 4. 27.
	 * @param name
	 * @param values
	 */
	public void setParameter(String name, String[] values) {
		params.put(name, values);
	}

}
