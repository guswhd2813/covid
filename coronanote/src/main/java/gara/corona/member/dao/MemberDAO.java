package gara.corona.member.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Repository;
import gara.corona.common.dao.AbstractDAO;

@Repository("memberDAO")
public class MemberDAO extends AbstractDAO {

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("memberDAO.selectFileInfo", map);
	}

	public int selectIdCnt(Map<String, Object> map) throws Exception {
		return (int) selectOne("memberDAO.selectIdCnt", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectMemberInfo(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("memberDAO.selectMemberInfo", map);
	}

	public int insertMemberJoin(Map<String, Object> map) throws Exception {
		insert("memberDAO.insertMemberJoin", map);
		return (int) map.get("member_seq");
	}
		
	public int selectIdChk(Map<String, Object> map) throws Exception {
		return (int) selectOne("memberDAO.selectIdChk", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectFriendRequest(Map<String, Object> map) throws Exception {
		return selectList("memberDAO.selectFriendRequest", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectGroupInfo(Map<String, Object> map) throws Exception {
		return selectList("memberDAO.selectGroupInfo", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectFriendInfo(Map<String, Object> map) throws Exception {
		return selectList("memberDAO.selectFriendInfo", map);
	}

	public void insertFriendInfo(Map<String, Object> map) throws Exception {
		insert("memberDAO.insertFriendInfo", map);

	}

	public void insertFriendInfo2(Map<String, Object> map) throws Exception {
		insert("memberDAO.insertFriendInfo2", map);

	}
	
	public void updateFriendRequestInfo(Map<String, Object> map) throws Exception {
		update("memberDAO.updateFriendRequestInfo", map);

	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectGroupMemberInfo(Map<String, Object> map) throws Exception {
		return selectList("memberDAO.selectGroupMemberInfo", map);
	}

	public int insertFileInfo(Map<String, Object> map) throws Exception {
		insert("memberDAO.insertFileInfo", map);
		return (int) map.get("img_seq");
	}

	public void deleteFileInfo(Map<String, Object> map) throws Exception {
		insert("memberDAO.deleteFileInfo", map);
	}

	public void insertSendShareInfo(Map<String, Object> map) throws Exception {
		insert("memberDAO.insertSendShareInfo", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSharedImageInfo(Map<String, Object> map) throws Exception {
		return selectList("memberDAO.selectSharedImageInfo", map);
	}

	public void insertGroupInfo(Map<String, Object> map) throws Exception {
		insert("memberDAO.insertGroupInfo", map);

	}

	public void insertFriendRequest(Map<String, Object> map) throws Exception {
		insert("memberDAO.insertFriendRequest", map);

	}

	public int selectMemberCount(Map<String, Object> map) throws Exception  {
		return (int) selectOne("memberDAO.selectMemberCount", map);
	}
	
	public int selectMemberCount2(Map<String, Object> map) throws Exception  {
		return (int) selectOne("memberDAO.selectMemberCount2", map);
	}
	
	public int selectMemberCount3(Map<String, Object> map) throws Exception  {
		return (int) selectOne("memberDAO.selectMemberCount3", map);
	}
	
	public int selectMemberCount4(Map<String, Object> map) throws Exception  {
		return (int) selectOne("memberDAO.selectMemberCount4", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectGroupFriendAdd(Map<String, Object> map) throws Exception {
		return selectList("memberDAO.selectGroupFriendAdd", map);
	}
	
	public void insertGroupAdd(Map<String, Object> map) throws Exception {
		update("memberDAO.insertGroupAdd", map);

	}
	
	public void deleteGroupMember(Map<String, Object> map) throws Exception {
		update("memberDAO.deleteGroupMember", map);

	}
	
	public void deleteGroupMemberAll(Map<String, Object> map) throws Exception {
		update("memberDAO.deleteGroupMemberAll", map);

	}
	
	public void deleteGroupAll(Map<String, Object> map) throws Exception {
		update("memberDAO.deleteGroupAll", map);

	}
	
	public void updateGroupName(Map<String, Object> map) throws Exception {
		update("memberDAO.updateGroupName", map);

	}

	public List<Map<String, Object>> selectFriendSearch(Map<String, Object> map) {
		return selectList("memberDAO.selectFriendSearch", map);
	}
	
	public void deleteImg_send_info(Map<String, Object> map) throws Exception {
		update("memberDAO.deleteImg_send_info", map);

	}
	
	public void deleteImg_info(Map<String, Object> map) throws Exception {
		update("memberDAO.deleteImg_info", map);

	}

	public int selectImgCnt(Map<String, Object> map) {
		return (int) selectOne("memberDAO.selectImgCnt", map);
	}
	
	public void updateImgRequest(Map<String, Object> map) throws Exception {
		update("memberDAO.updateImgRequest", map);

	}

	public List<Map<String, Object>> selectFriendSendRequest(Map<String, Object> map) {
		return selectList("memberDAO.selectFriendSendRequest", map);
	}
	
	public void friendCancelRequest(Map<String, Object> map) throws Exception {
		update("memberDAO.friendCancelRequest", map);

	}

	public String friendStateChk(Map<String, Object> map) {
		return (String) selectOne("memberDAO.friendStateChk", map);
	}
	
	public int friendAddedSelect(Map<String, Object> map) {
		return (int) selectOne("memberDAO.friendAddedSelect", map);
	}
	
	public void friendAddedRequest(Map<String, Object> map) {
		update("memberDAO.friendAddedRequest", map);
	}

	public String deletefriendInfo(Map<String, Object> map, HttpServletRequest request, HttpSession session) {
		delete("memberDAO.deletefriendInfo", map);
		return null;
	}
	
	public String deletefriendInfo2(Map<String, Object> map, HttpServletRequest request, HttpSession session) {
		delete("memberDAO.deletefriendInfo2", map);
		return null;
	}

	public String deletefriendGroupInfo(Map<String, Object> map, HttpServletRequest request, HttpSession session) {
		delete("memberDAO.deletefriendGroupInfo", map);
		return null;
	}
}
