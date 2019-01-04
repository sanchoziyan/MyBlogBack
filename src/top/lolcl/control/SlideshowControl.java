package top.lolcl.control;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URISyntaxException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import top.lolcl.dao.SlideshowMapper;
import top.lolcl.entity.Slideshow;
import top.lolcl.util.CommonUtil;
import top.lolcl.util.PropertyUtil;
import top.lolcl.util.ReadXmlUtil;

@Controller
@RequestMapping("/slideshow")
public class SlideshowControl {
	@Autowired
	SlideshowMapper slideshowmapper; //图片对象
	
	/**
	 * 新增轮播图界面
	 * @param model
	 * @return
	 */
	@RequestMapping("/edit")
	public String index(Model model){
		return "/back/slideshow/edit.jsp";
	}
	
	/**
	 * 提交保存 上传图片
	 * @param file
	 * @throws IOException
	 * @throws URISyntaxException 
	 */
	@RequestMapping(value="/uploadImg",method=RequestMethod.POST)
	@ResponseBody
	public String upload(Slideshow model ,@RequestParam("image") MultipartFile file) throws Exception{
		/*读取xml文件中对应元素的值*/
		String imgPath = ReadXmlUtil.getInstance("SysConfig.xml").getTextContent("imgPath");
		String imgServerUrl = ReadXmlUtil.getInstance("SysConfig.xml").getTextContent("imgServerUrl");
		File fileDir = new File(imgPath+"/slideshow") ;//目录 ---》F:/img/slideshow 轮播图目录
		if(!fileDir.exists()){
			fileDir.mkdir(); //创建目录
		}
	
		File path = new File(fileDir,file.getOriginalFilename());
		
		if(!path.exists()){
			path.createNewFile();
		}
		model.setUuid(CommonUtil.uuid());
		model.setImgurl(imgServerUrl+"/slideshow/"+file.getOriginalFilename());
		model.setName(file.getOriginalFilename());
		slideshowmapper.insert(model);
		// 被保存到服务器的地址路径
		if (!file.isEmpty()) {
			final InputStream is = file.getInputStream();
			final byte[] buf = new byte[1024];
			int ch = 0;
			final OutputStream fos = new FileOutputStream(path);
			while ((ch = is.read(buf)) != -1) {
				fos.write(buf, 0, ch);
				fos.flush();
			}
			fos.close();
			is.close();
		}
		return "success";
	}
	
	@RequestMapping("/remove")
	@ResponseBody
	public String remove(String uuid){
		slideshowmapper.deleteByPrimaryKey(uuid);
		return "success";
	}
	
	/**
	 * 提交保存 上传图片 原始方法
	 * @param file
	 * @throws IOException
	 *//*
	@RequestMapping(value="/uploadImg",method=RequestMethod.POST)
	@ResponseBody
	public String upload(Slideshow model ,@RequestParam("image") MultipartFile file) throws IOException{
		String dir = BackControl.class.getClassLoader().getResource("\\").toString().replace("classes", "static").replace("file:/", "");
		System.out.println(dir);
		File path = new File(dir+"\\images",file.getOriginalFilename());
		System.out.println(path.getAbsolutePath());
		
		if(!path.exists()){
			path.createNewFile();
		}
		model.setUuid(CommonUtil.uuid());
		model.setImgurl(path.getAbsolutePath());
		model.setName(file.getOriginalFilename());
		slideshowmapper.insert(model);
		// 被保存到服务器的地址路径
		if (!file.isEmpty()) {
			final InputStream is = file.getInputStream();
			final byte[] buf = new byte[1024];
			int ch = 0;
			final OutputStream fos = new FileOutputStream(path);
			while ((ch = is.read(buf)) != -1) {
				fos.write(buf, 0, ch);
				fos.flush();
			}
			fos.close();
			is.close();
		}
		return "success";
	}*/
	
}
