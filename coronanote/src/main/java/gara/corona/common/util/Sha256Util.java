package gara.corona.common.util;

import java.security.MessageDigest;

/**
 * 
 * SHA256 암호화 
 * 
 * @author fredy
 *
 */
public class Sha256Util {
	
	/**
	 * SHA256 암호화
	 * 
	 * @param plainStr 평문 
	 * @return
	 * @throws Exception
	 */
	public String getEncSha256(String plainStr) throws Exception	{
		
		StringBuffer sbuf = new StringBuffer();
		
		MessageDigest mDigest = MessageDigest.getInstance("SHA-256");
		mDigest.update(plainStr.getBytes());
		
		byte[] msgStr = mDigest.digest() ;
		
		for(int i=0; i < msgStr.length; i++){
		byte tmpStrByte = msgStr[i];
		String tmpEncTxt = Integer.toString((tmpStrByte & 0xff) + 0x100, 16).substring(1);
		
		sbuf.append(tmpEncTxt) ;
		}
		
		return sbuf.toString();
	}
}

