package gara.corona.common.service;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import javax.imageio.ImageIO;
import javax.xml.bind.DatatypeConverter;

import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import gara.corona.common.dao.CommonDAO;

@Service("commonService")
public class CommonServiceImpl implements CommonService{
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="commonDAO")
	private CommonDAO commonDAO;
	
	@Value("#{props['anniver.imgFolder.path']}")
	private String imgFolderPath;
	
	@Value("#{props['anniver.imgLoader.url']}")
	private String imgLoaderUrl;
	
	@Override
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {

		return commonDAO.selectFileInfo(map);
	}

	@Override
	public String insertImageUpload2(Map<String, Object> map, MultipartHttpServletRequest multiRequest, HttpSession session)  throws Exception{
		List<MultipartFile> fileList = multiRequest.getFiles("input-image-file");
		String resultMsg = null;
		Image image;
		int newWidth = 600;                                  // 변경 할 넓이
        int newHeight = 700;                                 // 변경 할 높이
        String mainPosition = "W"; 
        int imageWidth;
        int imageHeight;
        double ratio;
        int w;
        int h;
		for (MultipartFile mf : fileList) {
			String originFileName = mf.getOriginalFilename(); // 원본 파일 명
			log.debug("originFileName==" + originFileName);
			String ext = FilenameUtils.getExtension(originFileName);
			
			byte[] imageBytes = null;

			String imgSrc = (String) map.get("content");

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
		 
		        }catch (Exception e){
		 
		            e.printStackTrace();
		 
		        }
			 
			resultMsg = "정상등록";
			
		}

		return resultMsg;
	}

}
