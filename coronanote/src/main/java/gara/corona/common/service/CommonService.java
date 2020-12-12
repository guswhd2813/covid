package gara.corona.common.service;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface CommonService {

	Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception;

	String insertImageUpload2(Map<String, Object> map, MultipartHttpServletRequest request, HttpSession session)  throws Exception;

}