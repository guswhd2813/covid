package gara.corona.common.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.apache.maven.model.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import gara.corona.common.common.CommandMap;
import gara.corona.common.service.CommonService;
import gara.corona.member.dao.MemberDAO;

@Controller
public class CommonController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="memberDAO")
	private MemberDAO memberDAO;
	
	@Resource(name="commonService")
	private CommonService commonService;
	
	@RequestMapping(value="/common/downloadFile.do")
	public void downloadFile(CommandMap commandMap, HttpServletResponse response) throws Exception{
		Map<String,Object> map = commonService.selectFileInfo(commandMap.getMap());
		String storedFileName = (String)map.get("STORED_FILE_NAME");
		String originalFileName = (String)map.get("ORIGINAL_FILE_NAME");
		
		byte fileByte[] = FileUtils.readFileToByteArray(new File("C:\\dev\\file\\"+storedFileName));
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(originalFileName,"UTF-8")+"\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.getOutputStream().write(fileByte);
		
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}
	
	@RequestMapping(value="/test.do")
    public ModelAndView selectBoardList(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("test");
    	
    	return mv;
    }
	
	@ResponseBody
	@RequestMapping(value="/sharedImage.do", method = RequestMethod.GET, produces = MediaType.IMAGE_JPEG_VALUE )
	public byte[] showProfileThumbnailImage( Model model
								, HttpServletRequest req
								, HttpServletResponse res
								, HttpSession session
								, @RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String,Object> map = memberDAO.selectFileInfo(paramMap);

		if(map == null) {
			return null;
		}else {

			String imgDir	=(String) map.get("img_path");
			String thumbExt		= imgDir.substring(imgDir.lastIndexOf(".") + 1);
			log.debug("imgDir - " + imgDir);

			ByteArrayOutputStream bos	= null;
			try {
				String imageFullPath	= imgDir ;
				InputStream is = new FileInputStream( imageFullPath );
				BufferedImage img = ImageIO.read(is);
				bos = new ByteArrayOutputStream();
				ImageIO.write(img, thumbExt, bos);

			} catch (FileNotFoundException e) {
				return null;
			} catch (IOException ex)	{
				ex.toString();
			}

			return bos.toByteArray();
		}
	}
	
	/**
	 * 사진 업로드
	 * @param map
	 * @return jsonView
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	@PostMapping(value="/ajax/member/insert/insertImageUpload2.do")
	public ModelAndView insertImageUpload2(MultipartHttpServletRequest request,@RequestParam Map<String, Object> map,  HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("jsonView");
		String resultCnt = commonService.insertImageUpload2(map,request, session);
		mv.addObject("img_seq", resultCnt);
		return mv;
	}
}
