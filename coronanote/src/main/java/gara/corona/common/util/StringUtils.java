package gara.corona.common.util;

import java.util.Map;

public class StringUtils {
	
	public String nullToStr(String paramStr)	{
		
		if ( paramStr == null || paramStr.length() == 0 )	
			return "";
		else
			return paramStr.trim();
	}
	
	@SuppressWarnings("unchecked")
	public String getValueFromMap(Object obj, String keyName)	{
		
		Map<String, Object> paramMap = (Map<String, Object>)obj;
		
		String retVal	= "";
		
		if ( paramMap == null || paramMap.isEmpty() || ! paramMap.containsKey(keyName) || paramMap.get(keyName) == null )	{
			
		}else{
			retVal	= (String) paramMap.get(keyName) == null ? "" : (String) paramMap.get(keyName);
			
			if ( retVal == null || retVal.length() ==0 )	{
				retVal	= "";
			}else	{
				retVal.trim();
			}
		}
		return retVal;
	}
}
