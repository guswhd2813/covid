package gara.corona.common.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import gara.corona.common.util.StringUtils;

public class MemberSessionUtil {
	
	Logger log = Logger.getLogger(this.getClass());
	
	private HttpServletRequest	request;
	private Map<String,Object>	sessionMap	= new HashMap<String, Object>();

	private StringUtils strUtils = new StringUtils();
	
	@SuppressWarnings("unchecked")
	public MemberSessionUtil(HttpServletRequest req)		{
		
		this.request	= req;
		this.sessionMap	= (Map<String, Object>) request.getSession().getAttribute("memberLoginMap");

	}
	

	
	@SuppressWarnings("unchecked")
	public Map<String,Object> getLoginSessionMap()		{
		
		if ( this.request == null )
			return null;
		
		return (Map<String, Object>) request.getSession().getAttribute("memberLoginMap");
	}
	
	public String getLoginSessionMapProperty(String propName)		{
		
		String retStr	= "";
		
		log.debug(sessionMap);
		
		if ( sessionMap != null  && ! sessionMap.isEmpty() )	{
			retStr	= (String) sessionMap.get(propName);
		}
		
		return retStr;
	}
	
	public boolean isMySession(String strAccntId)		{
		
		boolean retResult	= false;
		
		strAccntId	= strUtils.nullToStr(strAccntId);
		
		String pSessionId	= strAccntId;
		String mySessionId	= getLoginSessionMapProperty("ACCNT_ID");
		
		if ( "".equals(pSessionId) || "".equals(mySessionId) )	{
			
			retResult	= false;
			
		}else if ( pSessionId.equals(mySessionId) )		{
			
			retResult	= true;
			
		}
		
		return retResult;
	}
	
	public void updSessionMap(String propName, String value, HttpSession session)	{
		
		Map<String, Object> retMap	= this.sessionMap;
		
		retMap.put(propName, value);
		
		session.setAttribute("memberLoginMap", retMap);
	}
	

	
	
	public void printMessageWithReturnUri(HttpServletResponse response, String msg, String uri )	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer;
		try {
			writer = response.getWriter();
			writer.println("<script>alert('" + msg + "'); location.href='" + uri +"';</script>");
			writer.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void printMessageWithReturnUri2(HttpServletResponse response, String msg, String uri )	{
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer;
		try {
			log.info("msg=="+msg);
			writer = response.getWriter();
			writer.println("<script>alert('" + msg + "');history.back();</script>");
			writer.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void printLoadingBar(HttpServletResponse response)	{
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer;
		try {
			
			writer = response.getWriter();
			writer.println("<script>$('.loading').hide();</script>");
			writer.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void printMessageWithReturnUri3(HttpServletResponse response, String msg, String uri )	{
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		//PrintWriter writer;
		try {
		
		
			response.sendRedirect("/admin/noIp.do");
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public void printMessage(HttpServletResponse response, String msg )	{
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer;
		try {
			writer = response.getWriter();
			writer.println("<script>alert('" + msg + "'); history.back();</script>");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
