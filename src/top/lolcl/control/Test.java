package top.lolcl.control;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import top.lolcl.dao.AdminMapper;


@Controller
@RequestMapping("/lala")
public class Test {
	@Autowired
	AdminMapper adminmapper;
	
	
	
	@RequestMapping("/test")
	public String test(Model model){
		/*测试数据库连接问题
		Admin admin = new Admin();
		admin.setUname("admin");
		admin.setPwd("123");
		admin.setRole("1");
		int insert = adminmapper.insert(admin);*/
		String imgdir = BackControl.class.getClassLoader().getResource("\\").toString()
				.replace("classes", "static")
				.replace("file:/", "")+"\\images";
		File dir = new File(imgdir);
		File[] listFiles = dir.listFiles(new FilenameFilter() {
			String suffix = ".jpg";
			public boolean accept(File dir, String name) {
				// TODO Auto-generated method stub
				return name.endsWith(suffix);
			}
		});
		List<String> list = new ArrayList<String>();
	
		for (File file : listFiles) {
			list.add(file.getName());
		}
		model.addAttribute("model",list);
		return "/index.jsp";
	}
	
	@RequestMapping(value="/uploadPosdetailFile",method=RequestMethod.POST)
	public String uploadFile(Model model,@RequestParam("uploadFileCtrl") MultipartFile file) throws IOException{
		
		File dir = new File("F:/file/"+file.getOriginalFilename());
		if(!dir.exists()){
			dir.createNewFile();
		}
		//被保存到服务器的地址路径
		if(!file.isEmpty()){
			InputStream is = file.getInputStream();
			byte[] buf = new byte[1024];
			int ch = 0;
			OutputStream fos = new FileOutputStream(dir);
			while((ch=is.read(buf)) != -1){
				fos.write(buf, 0, ch);
				fos.flush();
			}
			fos.close();
			is.close();
		}
		return "";
	}
}
