package gara.corona.common.logger;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import gara.corona.common.logger.MemberLoggerInterceptor;
import gara.corona.common.util.MemberSessionUtil;

public class MemberLoggerInterceptor extends HandlerInterceptorAdapter {
	protected Log log = LogFactory.getLog(MemberLoggerInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		if (log.isDebugEnabled()) {
			log.debug("======================================          START[Member]         ======================================");
			log.debug(" Request URI \t:  " + request.getRequestURI());			
		}
		
		String requestUri		= request.getRequestURI();
		Map<String,Object> sessionMap = (Map<String, Object>) request.getSession().getAttribute("memberLoginMap");
		// 로그인 세션 체크
		if ( sessionMap == null || sessionMap.size() == 0 || sessionMap.isEmpty() )		{
			if ( isNotLoginRequiredPage(requestUri) )	{
				log.info("로그인 필요없음 ");
			}else {
				log.info("로그인 필요");
				String retUri = "/";
				new MemberSessionUtil(request).printMessageWithReturnUri(response, "로그인후에 이용해 주세요.\\n로그인페이지로 이동합니다.", retUri);
			}
		}
		
		return super.preHandle(request, response, handler);
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		if (log.isDebugEnabled()) {
			log.debug("======================================           END          ======================================\n");
		}
	}
	
	public boolean isNotLoginRequiredPage(String requestUri)	{
		
		boolean retVal	= false;
		
		List <String> istNotLoginUri	= new ArrayList<String>();
		istNotLoginUri.add("/login.do");
		istNotLoginUri.add("/join.do");
		

		for (String notLoginUri : istNotLoginUri) {
			
			if ( notLoginUri.indexOf(requestUri) >= 0 )			
				retVal	= true;
		}
		
		return retVal;
	}
}