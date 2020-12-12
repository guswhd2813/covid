package gara.corona.member.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface MemberService {

	String insertImageUpload(Map<String, Object> map, HttpSession session)  throws Exception;

	String insertGroupInfo(Map<String, Object> map, HttpServletRequest request, HttpSession session) throws Exception;
	
	String insertFriendRequest(Map<String, Object> map, HttpServletRequest request, HttpSession session) throws Exception;
	
	Map<String, Object> selectGroupFriendAdd(Map<String, Object> map, HttpServletRequest request, HttpSession session) throws Exception;
	
	String insertGroupAdd(Map<String, Object> map, HttpServletRequest request, HttpSession session) throws Exception;

	String deleteGroupMember (Map<String, Object> map, HttpServletRequest request, HttpSession session) throws Exception;
	
	String deleteGroupAll (Map<String, Object> map, HttpServletRequest request, HttpSession session) throws Exception;
	
	String updateGroupName (Map<String, Object> map, HttpServletRequest request, HttpSession session) throws Exception;
	
	String imgDelete (Map<String, Object> map, HttpServletRequest request, HttpSession session) throws Exception;

	String updateImgRequest (Map<String, Object> map, HttpServletRequest request, HttpSession session) throws Exception;
	
	String friendCancelRequest (Map<String, Object> map, HttpServletRequest request, HttpSession session) throws Exception;

	int friendAddedSelect(Map<String, Object> map, HttpServletRequest request, HttpSession session);

	String friendAddedRequest(Map<String, Object> map, HttpServletRequest request, HttpSession session);
}
