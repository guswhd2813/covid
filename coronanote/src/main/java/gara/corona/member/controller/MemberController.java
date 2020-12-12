package gara.corona.member.controller;

import java.io.Console;
import java.io.File;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import gara.corona.common.common.CommandMap;
import gara.corona.common.util.Sha256Util;
import gara.corona.member.dao.MemberDAO;
import gara.corona.member.service.MemberService;

@Controller
public class MemberController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	MemberDAO memberDAO;
	
	@Resource(name="memberService")
	private MemberService memberService;
	
	/**
	 * 로그인 페이지
	 * @param map
	 * @return Redirect
	 * @throws Exception
	 */
	@RequestMapping(value="/login.do")
	public ModelAndView memberLogin(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception{
    	ModelAndView mv = new ModelAndView("member/login/login");

    	return mv;
    }
	
	/**
	 * 회원가입 페이지
	 * @param map
	 * @return Redirect
	 * @throws Exception
	 */
	@RequestMapping(value="/join.do")
	public ModelAndView memberJoin(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception{
    	ModelAndView mv = new ModelAndView("member/login/join");

    	return mv;
    }
	
	/**
	 * 메인 페이지
	 * @param map
	 * @return Redirect
	 * @throws Exception
	 */
	@RequestMapping(value="/main.do")
	public ModelAndView memberMain(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception{
    	ModelAndView mv = new ModelAndView("member/main");
    	Map<String, Object> sessionMap = (Map<String, Object>) session.getAttribute("memberLoginMap");
    	map.put("member_seq", sessionMap == null ? "0" : sessionMap.get("member_seq"));
    	int imgCnt = memberDAO.selectImgCnt(map);
    	mv.addObject("imgCnt", imgCnt);
    	return mv;
    }
	
	/**
	 * 친구 페이지
	 * @param map
	 * @return Redirect
	 * @throws Exception
	 */
	@RequestMapping(value="/friend.do")
	public ModelAndView memberFriend(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception{
    	ModelAndView mv = new ModelAndView("member/content/friend");
    	Map<String, Object> sessionMap = (Map<String, Object>) session.getAttribute("memberLoginMap");
    	map.put("member_seq", sessionMap == null ? "0" : sessionMap.get("member_seq"));
    	List<Map<String,Object>> friend_send_request = memberDAO.selectFriendSendRequest(map);
    	List<Map<String,Object>> friend_request = memberDAO.selectFriendRequest(map);
    	List<Map<String,Object>> group_info = memberDAO.selectGroupInfo(map);
    	List<Map<String,Object>> friend_info = memberDAO.selectFriendInfo(map);
    	int imgCnt = memberDAO.selectImgCnt(map);
    	mv.addObject("imgCnt", imgCnt);
    	
    	mv.addObject("sessionMap", sessionMap);
    	mv.addObject("friend_send_request", friend_send_request);
    	mv.addObject("friend_request", friend_request);
    	mv.addObject("group_info", group_info);
    	mv.addObject("friend_info", friend_info);
    	
    	return mv;
    }
	
	/**
	 * 이미지 공유 페이지
	 * @param map
	 * @return Redirect
	 * @throws Exception
	 */
	@RequestMapping(value="/image.do")
	public ModelAndView memberImage(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception{
    	ModelAndView mv = new ModelAndView("member/content/image");
    	Map<String, Object> sessionMap = (Map<String, Object>) session.getAttribute("memberLoginMap");
    	map.put("member_seq", sessionMap == null ? "0" : sessionMap.get("member_seq"));
    	List<Map<String,Object>> list = memberDAO.selectSharedImageInfo(map);
    	int imgCnt = memberDAO.selectImgCnt(map);
    	mv.addObject("imgCnt", imgCnt);
    	mv.addObject("img_list", list);
    	return mv;
    }
	
	/**
	 * 로그인 체크
	 * @param map
	 * @return jsonView
	 * @throws Exception
	 */
	@RequestMapping(value="/ajax/member/select/selectIdChk.do")
	public ModelAndView selectIdChk(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception{
    	ModelAndView mv = new ModelAndView("jsonView");
    	String result = "";
    	Sha256Util sha256Util = new Sha256Util();
    	String pw = sha256Util.getEncSha256((String) map.get("pw"));
    	map.put("pw", pw);
    	int count = memberDAO.selectIdCnt(map);
    	Map<String,Object> memberLoginMap = memberDAO.selectMemberInfo(map);
    	if(count == 1) {
    		result = "passed";
    		session.setAttribute("memberLoginMap", memberLoginMap);
			session.setMaxInactiveInterval(60*60*24*365);
    	}else {
    		result = "failed";   
    	}
    	mv.addObject("result", result);
    	return mv;
    }
	
	/**
	 * 회원 가입
	 * @param map
	 * @return jsonView
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	@RequestMapping(value="/ajax/member/insert/insertMemberJoin.do")
	public ModelAndView insertMemberJoin(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception{
    	ModelAndView mv = new ModelAndView("jsonView");
    	String result = "";
    	int member_seq = 0;
    	int idChk = memberDAO.selectIdChk(map);
    	String[] group_name = {"가족", "연인", "친구"};
    	if(idChk == 0) {
	    	Sha256Util sha256Util = new Sha256Util();
	    	String pw = sha256Util.getEncSha256((String) map.get("pw"));
	    	map.put("pw", pw);
	    	try {
	    		member_seq = memberDAO.insertMemberJoin(map);
	    		
	    		for(int i=0; i<3; i++) {
	    			
	    			map.put("group_name", group_name[i]);
	    			
	    			memberDAO.insertGroupInfo(map);
	    		}
	    		
	    		result = "passed";
			} catch (Exception e) {
				result = "failed";
			}
    	}else {
    		result = "duplication";
    	}
    	
    	mv.addObject("result", result);
    	return mv;
    }
	
	/**
	 * 친구 추가 
	 * @param map
	 * @return jsonView
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	@RequestMapping(value="/ajax/member/insert/insertFriendInfo.do")
	public ModelAndView insertFriendInfo(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception{
    	ModelAndView mv = new ModelAndView("jsonView");
    	Map<String, Object> sessionMap = (Map<String, Object>) session.getAttribute("memberLoginMap");
    	map.put("member_seq", sessionMap == null ? "0" : sessionMap.get("member_seq"));
    	String result = "";
    	String useYn ="";
    	String state = "";
    	try {
    		useYn = memberDAO.friendStateChk(map);
    		
    		
    		
    		if("Y".equals(useYn)) {
    			memberDAO.insertFriendInfo(map);
        		memberDAO.insertFriendInfo2(map);
        		memberDAO.updateFriendRequestInfo(map);
    			state = "false";
    		}else {
    			state = "true";
    		}

    		result = "passed";
		} catch (Exception e) {
			// TODO: handle exception
		}
    	
    	mv.addObject("result", result);
    	mv.addObject("state", state);
    	return mv;
    }
	
	/**
	 * 그룹 맴버 호출
	 * @param map
	 * @return jsonView
	 * @throws Exception
	 */
	@RequestMapping(value="/ajax/member/select/selectGroupMemberInfo.do")
	public ModelAndView selectGroupMemberInfo(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception{
    	ModelAndView mv = new ModelAndView("jsonView");
    	Map<String, Object> sessionMap = (Map<String, Object>) session.getAttribute("memberLoginMap");
    	map.put("member_seq", sessionMap == null ? "0" : sessionMap.get("member_seq"));
    	String result = "";
    	List<Map<String,Object>> group_friend_list = memberDAO.selectGroupMemberInfo(map);
    	
    	mv.addObject("group_friend_list", group_friend_list);
    	return mv;
    }
	
	/**
	 * 사진 업로드
	 * @param map
	 * @return jsonView
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	@PostMapping(value="/ajax/member/insert/insertImageUpload.do")
	public ModelAndView insertImageUpload(@RequestParam Map<String, Object> map,  HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("jsonView");
		String resultCnt = memberService.insertImageUpload(map, session);
		mv.addObject("img_seq", resultCnt);
		return mv;
	}
	
	/**
	 * 사진 공유
	 * @param map
	 * @return jsonView
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	@RequestMapping(value="/ajax/member/insert/insertSendImage.do")
	public ModelAndView insertSendImage(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception{
    	ModelAndView mv = new ModelAndView("jsonView");
    	Map<String, Object> sessionMap = (Map<String, Object>) session.getAttribute("memberLoginMap");
    	map.put("member_seq", sessionMap == null ? "0" : sessionMap.get("member_seq"));
    	String friend_seq = "0";
    	String[] friend_seq_list = null;
    	if(map.get("friend_seq_list").toString().contains(",")) {
    		friend_seq_list = map.get("friend_seq_list").toString().split(",");
    		for(int i = 0; i < friend_seq_list.length; i ++) {
        		friend_seq = friend_seq_list[i];
        		map.put("friend_seq", friend_seq);
        		try {
        			memberDAO.insertSendShareInfo(map);
    			} catch (Exception e) {
    				
    			}
        	}
    	}else {
    		friend_seq = map.get("friend_seq_list").toString();
    		map.put("friend_seq", friend_seq);
    		try {
    			memberDAO.insertSendShareInfo(map);
			} catch (Exception e) {
				
			}
    	}
    	
    	return mv;
    }
	
	/*그룹 추가 */ 
	@Transactional(rollbackFor = Exception.class)
	@PostMapping(value="/ajax/member/insert/insertGroupInfo.do")
	public ModelAndView insertGroupInfo(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("jsonView");  
		Map<String, Object> sessionMap = (Map<String, Object>) session.getAttribute("memberLoginMap");
    	map.put("member_seq", sessionMap == null ? "0" : sessionMap.get("member_seq"));
    	String resultCnt = memberService.insertGroupInfo(map,request, session);
    	return mv;
	}
	
	/* 친구 추가 요청 */
	@Transactional(rollbackFor = Exception.class)
	@PostMapping(value="/ajax/member/insert/insertFriendRequest.do")
	public ModelAndView insertFriendRequest(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("jsonView");  
		Map<String, Object> sessionMap = (Map<String, Object>) session.getAttribute("memberLoginMap");
    	map.put("member_seq", sessionMap == null ? "0" : sessionMap.get("member_seq"));
    	String resultCnt = memberService.insertFriendRequest(map,request, session);
    	mv.addObject("msg", resultCnt);
    	return mv;
	}
	
	/* 그룹 추가 친구 출력 */
	@Transactional(rollbackFor = Exception.class)
	@PostMapping(value="/ajax/member/select/selectGroupFriendAdd.do")
	public ModelAndView updateGroupFriendAdd(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("jsonView");  
		Map<String, Object> sessionMap = (Map<String, Object>) session.getAttribute("memberLoginMap");
    	map.put("member_seq", sessionMap == null ? "0" : sessionMap.get("member_seq"));
    	Map<String, Object> friend_list = memberService.selectGroupFriendAdd(map, request, session);
    	mv.addObject("friend_list", friend_list.get("groupFriendList"));
    	return mv;
	}
	
	/*그룹 추가 */ 
	@Transactional(rollbackFor = Exception.class)
	@PostMapping(value="/ajax/member/insert/insertGroupAdd.do")
	public ModelAndView insertGroupAdd(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("jsonView");  
		Map<String, Object> sessionMap = (Map<String, Object>) session.getAttribute("memberLoginMap");
    	map.put("member_seq", sessionMap == null ? "0" : sessionMap.get("member_seq"));
    	String resultCnt = memberService.insertGroupAdd(map,request, session);
    	return mv;
	}

	/*그룹 맴버 삭제 */ 
	@Transactional(rollbackFor = Exception.class)
	@PostMapping(value="/ajax/member/delete/deleteGroupMember.do")
	public ModelAndView deleteGroupMember(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("jsonView");  
		Map<String, Object> sessionMap = (Map<String, Object>) session.getAttribute("memberLoginMap");
    	map.put("member_seq", sessionMap == null ? "0" : sessionMap.get("member_seq"));
    	String member_seq_list = memberService.deleteGroupMember(map, request, session);
    	
    	return mv;
	}
	
	@RequestMapping(value="/ajax/member/select/selectGroupInfo.do")
	public ModelAndView selectGroupInfo(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception{
    	ModelAndView mv = new ModelAndView("jsonView");
    	Map<String, Object> sessionMap = (Map<String, Object>) session.getAttribute("memberLoginMap");
    	map.put("member_seq", sessionMap == null ? "0" : sessionMap.get("member_seq"));
    	String result = "";
    	List<Map<String,Object>> group_info = memberDAO.selectGroupInfo(map);
    	
    	mv.addObject("group_info", group_info);
    	return mv;
    }
	
	/*그룹 맴버 삭제 */ 
	@Transactional(rollbackFor = Exception.class)
	@PostMapping(value="/ajax/member/delete/deleteGroupAll.do")
	public ModelAndView deleteGroupAll(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("jsonView");  
		Map<String, Object> sessionMap = (Map<String, Object>) session.getAttribute("memberLoginMap");
    	map.put("member_seq", sessionMap == null ? "0" : sessionMap.get("member_seq"));
    	String member_seq_list = memberService.deleteGroupAll(map, request, session);
    	
    	return mv;
	}
	
	@Transactional(rollbackFor = Exception.class)
	@PostMapping(value="/ajax/member/update/updateGroupName.do")
	public ModelAndView updateGroupName(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("jsonView");  
		Map<String, Object> sessionMap = (Map<String, Object>) session.getAttribute("memberLoginMap");
    	map.put("member_seq", sessionMap == null ? "0" : sessionMap.get("member_seq"));
    	String friend_list = memberService.updateGroupName(map, request, session);
    	return mv;
	}
	
	/*친구검색*/
	@RequestMapping(value="/ajax/member/select/selectAddFriendInfo.do")
	public ModelAndView selectAddFriendInfo(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception{
    	ModelAndView mv = new ModelAndView("jsonView");
    	Map<String, Object> sessionMap = (Map<String, Object>) session.getAttribute("memberLoginMap");
    	map.put("member_seq", sessionMap == null ? "0" : sessionMap.get("member_seq"));
    	List<Map<String,Object>> member_info = memberDAO.selectFriendSearch(map);
    	mv.addObject("member_info", member_info);
    	return mv;
    }
	
	/*친구검색*/
	@RequestMapping(value="/ajax/member/update/imgDelete.do")
	public ModelAndView imgDelete(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception{
    	ModelAndView mv = new ModelAndView("jsonView");
    	Map<String, Object> sessionMap = (Map<String, Object>) session.getAttribute("memberLoginMap");
    	map.put("member_seq", sessionMap == null ? "0" : sessionMap.get("member_seq"));
    	String imageDelete = memberService.imgDelete(map, request, session);
    	return mv;
    }
	
	@RequestMapping(value="/ajax/member/update/updateImgRequest.do")
	public ModelAndView updateImgRequest(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception{
    	ModelAndView mv = new ModelAndView("jsonView");
    	Map<String, Object> sessionMap = (Map<String, Object>) session.getAttribute("memberLoginMap");
    	map.put("member_seq", sessionMap == null ? "0" : sessionMap.get("member_seq"));
    	String imageDelete = memberService.updateImgRequest(map, request, session);
    	return mv;
    }
	
	@RequestMapping(value="/ajax/member/delete/friendCancelRequest.do")
	public ModelAndView friendCancelRequest(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception{
    	ModelAndView mv = new ModelAndView("jsonView");
    	Map<String, Object> sessionMap = (Map<String, Object>) session.getAttribute("memberLoginMap");
    	map.put("member_seq", sessionMap == null ? "0" : sessionMap.get("member_seq"));
    	String friendCancelRequest = memberService.friendCancelRequest(map, request, session);
    	mv.addObject("state", friendCancelRequest);
    	return mv;
    }
	
	@RequestMapping(value="/ajax/member/select/friendAddedSelect.do")
	public ModelAndView friendAddedSelect(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception{
    	ModelAndView mv = new ModelAndView("jsonView");
    	Map<String, Object> sessionMap = (Map<String, Object>) session.getAttribute("memberLoginMap");
    	map.put("member_seq", sessionMap == null ? "0" : sessionMap.get("member_seq"));
    	int friendCancelRequest = memberService.friendAddedSelect(map, request, session);
    	mv.addObject("cnt", friendCancelRequest);
    	return mv;
    }
	
	@RequestMapping(value="/ajax/member/update/friendAddedRequest.do")
	public ModelAndView friendAddedRequest(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception{
    	ModelAndView mv = new ModelAndView("jsonView");
    	Map<String, Object> sessionMap = (Map<String, Object>) session.getAttribute("memberLoginMap");
    	map.put("member_seq", sessionMap == null ? "0" : sessionMap.get("member_seq"));
    	String friendAddedRequest = memberService.friendAddedRequest(map, request, session);
    	return mv;
    }
	
	@RequestMapping(value="/ajax/member/select/friendSelectList.do")
	public ModelAndView friendSelectList(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception{
    	ModelAndView mv = new ModelAndView("jsonView");
    	Map<String, Object> sessionMap = (Map<String, Object>) session.getAttribute("memberLoginMap");
    	map.put("member_seq", sessionMap == null ? "0" : sessionMap.get("member_seq"));
    	String friendAddedRequest = memberService.friendAddedRequest(map, request, session);
    	List<Map<String,Object>> friend_info = memberDAO.selectFriendInfo(map);
    	mv.addObject("friend_info", friend_info);
    	return mv;
    }
    	
	@RequestMapping(value="/ajax/member/delete/deletefriend.do")
	public ModelAndView deletefriend(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception{
    	ModelAndView mv = new ModelAndView("jsonView");
    	Map<String, Object> sessionMap = (Map<String, Object>) session.getAttribute("memberLoginMap");
    	map.put("member_seq", sessionMap == null ? "0" : sessionMap.get("member_seq"));
    	String deletefriendInfo = memberDAO.deletefriendInfo(map, request, session);
    	String deletefriendInfo2 = memberDAO.deletefriendInfo2(map, request, session);
    
    	return mv;
    }
	
	@RequestMapping(value="/webcatting.do")
	public ModelAndView webcatting(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception{
    	ModelAndView mv = new ModelAndView("webchatting");

    	return mv;
    }
	
	@RequestMapping(value="/webcattingdemo.do")
	public ModelAndView webcattingdemo(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpSession session) throws Exception{
    	ModelAndView mv = new ModelAndView("publishing");

    	return mv;
    }
}	

