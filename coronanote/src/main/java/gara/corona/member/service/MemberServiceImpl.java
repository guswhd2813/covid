package gara.corona.member.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.imageio.ImageIO;
import javax.xml.bind.DatatypeConverter;

import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.multipart.MultipartFile;

import gara.corona.common.util.FileUtils;
import gara.corona.member.dao.MemberDAO;

@Service("memberService")
public class MemberServiceImpl implements MemberService{
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="memberDAO")
	private MemberDAO memberDAO;
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	@Value("#{props['anniver.imgFolder.path']}")
	private String imgFolderPath;
	
	@Value("#{props['anniver.imgLoader.url']}")
	private String imgLoaderUrl;

	@Override
	public String insertImageUpload(Map<String, Object> map, HttpSession session) throws Exception {
		
		int img_seq = 0;
		String img_path = "";
		String seq = "";
		
		//List<MultipartFile> fileList = request.getFiles("input-image-file");
		Image image;
		int newWidth = 600;                                  // 변경 할 넓이
        int newHeight = 700;                                 // 변경 할 높이
        String mainPosition = "W"; 
        int imageWidth;
        int imageHeight;
        double ratio;
        int w;
        int h;
		//for (MultipartFile mf : fileList) {
			//String originFileName = mf.getOriginalFilename(); // 원본 파일 명
			String ext = "";
			
			byte[] imageBytes = null;

			String imgSrc = (String) map.get("content");
			if(imgSrc != null) {
				if (imgSrc.contains("data:image/jpeg;base64,")) {
					imgSrc = imgSrc.replaceAll("data:image/jpeg;base64,", "");
					ext = "jpg";
				} else if (imgSrc.contains("data:image/png;base64,")) {
					imgSrc = imgSrc.replaceAll("data:image/png;base64,", "");
					ext = "png";
				} else if (imgSrc.contains("data:image/gif;base64,")) {
					imgSrc = imgSrc.replaceAll("data:image/gif;base64,", "");
					ext = "gif";
				}
	
				String newImgName = "shared_img_" + UUID.randomUUID().toString() + "." + ext;
	
				imageBytes = DatatypeConverter.parseBase64Binary(imgSrc); 
				BufferedImage bufImg;
				bufImg = ImageIO.read(new ByteArrayInputStream(imageBytes));
				File file = new File(imgFolderPath + newImgName);
				img_path = imgFolderPath + newImgName;
				map.put("img_path", img_path);
				ImageIO.write(bufImg, ext, file);
				// 크기조정 //
				
				 try{
		            // 원본 이미지 가져오기
		            image = ImageIO.read(file);
		 
		            // 원본 이미지 사이즈 가져오기
		            imageWidth = image.getWidth(null);
		            imageHeight = image.getHeight(null);
		 
		            if(mainPosition.equals("W")){    // 넓이기준
		 
		                ratio = (double)newWidth/(double)imageWidth;
		                w = (int)(imageWidth * ratio);
		                h = (int)(imageHeight * ratio);
		 
		            }else if(mainPosition.equals("H")){ // 높이기준
		 
		                ratio = (double)newHeight/(double)imageHeight;
		                w = (int)(imageWidth * ratio);
		                h = (int)(imageHeight * ratio);
		 
		            }else{ //설정값 (비율무시)
		 
		                w = newWidth;
		                h = newHeight;
		            }
		 
		            // 이미지 리사이즈
		            // Image.SCALE_DEFAULT : 기본 이미지 스케일링 알고리즘 사용
		            // Image.SCALE_FAST    : 이미지 부드러움보다 속도 우선
		            // Image.SCALE_REPLICATE : ReplicateScaleFilter 클래스로 구체화 된 이미지 크기 조절 알고리즘
		            // Image.SCALE_SMOOTH  : 속도보다 이미지 부드러움을 우선
		            // Image.SCALE_AREA_AVERAGING  : 평균 알고리즘 사용
		            Image resizeImage = bufImg.getScaledInstance(w, h, Image.SCALE_SMOOTH);
		 
		            // 새 이미지  저장하기
		            BufferedImage newImage = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
		            Graphics g = newImage.getGraphics();
		            g.drawImage(resizeImage, 0, 0, null);
		            g.dispose();
		            ImageIO.write(newImage, ext, file);
		            
		            img_seq = memberDAO.insertFileInfo(map);
		    		map.put("img_seq", img_seq);
		    	
		    		seq = Integer.toString(img_seq);
		 
		        }catch (Exception e){
		 
		            e.printStackTrace();
		 
		        }
			}else{
				seq = "failed";
			};
			
		//}
		
		
		
		
		return seq;
	}

	@Override
	public String insertGroupInfo(Map<String, Object> map, HttpServletRequest request, HttpSession session) throws Exception {
		memberDAO.insertGroupInfo(map);
		return null;
	}
	
	@Override
	public String insertFriendRequest(Map<String, Object> map, HttpServletRequest request, HttpSession session) throws Exception {
	
		String resultMsg = "";
		int c = memberDAO.selectMemberCount(map);
		int c2 = memberDAO.selectMemberCount2(map);
		int c3 = memberDAO.selectMemberCount3(map);
		int c4 = memberDAO.selectMemberCount4(map);
		if(c==0) {
			resultMsg = "없는 아이디 입니다.";
		}else {
			
			if(c2==1) {
				resultMsg = "이미 친구가 되어 있습니다.";
			} else if (c3 == 1) {
				resultMsg = "이미 친구 초대 요청이 되어 있습니다.";
			} else if (c4 == 1) {
				resultMsg = "상대방이 친구 초대 요청을 한 상태입니다.";
			} else {
				memberDAO.insertFriendRequest(map);
				resultMsg = "친구 추가 요청이 완료 되었습니다.";	
			}
			
		}
		return resultMsg;
	}

	@Override
	public Map<String, Object> selectGroupFriendAdd(Map<String, Object> map, HttpServletRequest request, HttpSession session)
			throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> result = new HashMap<String,Object>();
		List<Map<String, Object>> list = memberDAO.selectGroupFriendAdd(map);
		result.put("groupFriendList", list);
		return result;
	}
	
	@Override
	public String insertGroupAdd(Map<String, Object> map, HttpServletRequest request, HttpSession session)
			throws Exception {
		// TODO Auto-generated method stub
		memberDAO.insertGroupAdd(map);		
		return null;
	}
	
	@Override
	public String deleteGroupMember(Map<String, Object> map, HttpServletRequest request, HttpSession session)
			throws Exception {
		// TODO Auto-generated method stub
		String member_seq = "0";
    	String[] member_seq_list = map.get("member_seq_list").toString().split(",");
    	
    	for(int i = 0; i < member_seq_list.length; i ++) {
    		member_seq = member_seq_list[i];
    		map.put("member_seq", member_seq);
    		try {   
    			memberDAO.deleteGroupMember(map);
			} catch (Exception e) {
				
			}	
    	}
		return null;
	}
	
	@Override
	public String deleteGroupAll(Map<String, Object> map, HttpServletRequest request, HttpSession session)
			throws Exception {
		// TODO Auto-generated method stub
		memberDAO.deleteGroupMemberAll(map);
		memberDAO.deleteGroupAll(map);	
		
		return null;
	}
	
	@Override
	public String updateGroupName(Map<String, Object> map, HttpServletRequest request, HttpSession session)
			throws Exception {
		// TODO Auto-generated method stub
		memberDAO.updateGroupName(map);
		
		return null;
	}

	@Override
	public String imgDelete(Map<String, Object> map, HttpServletRequest request, HttpSession session)
			throws Exception {
		// TODO Auto-generated method stub
		memberDAO.deleteImg_send_info(map);
		memberDAO.deleteImg_info(map);
		return null;
	}

	@Override
	public String updateImgRequest(Map<String, Object> map, HttpServletRequest request, HttpSession session)
			throws Exception {
		// TODO Auto-generated method stub
		memberDAO.updateImgRequest(map);
		
		return null;
	}
	
	@Override
	public String friendCancelRequest(Map<String, Object> map, HttpServletRequest request, HttpSession session)
			throws Exception {
		// TODO Auto-generated method stub
		String useYn = memberDAO.friendStateChk(map);
		
		String state = "";
		
		if("N".equals(useYn)) {
			
			state = "false";
		}else {
			state = "true";
			memberDAO.friendCancelRequest(map);
		}
		return state;
	}

	@Override
	public int friendAddedSelect(Map<String, Object> map, HttpServletRequest request, HttpSession session) {
		int cnt = memberDAO.friendAddedSelect(map);
		return cnt;
	}

	@Override
	public String friendAddedRequest(Map<String, Object> map, HttpServletRequest request, HttpSession session) {
		memberDAO.friendAddedRequest(map);
		return null;
	}
}
