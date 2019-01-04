package top.lolcl.control;

import javax.servlet.ServletContext;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ContextLoader;

import top.lolcl.constant.Constant;
import top.lolcl.util.FileUtil;

/**
 * 页面生成控制层
 * @author sanch
 *
 */
@Controller
@RequestMapping("/pagecreate")
public class PageCreateControl {
	
	@RequestMapping("/create")
	@ResponseBody
	public String create(HttpServletRequest request) throws Exception{
		String rootPath = ContextLoader.getCurrentWebApplicationContext().getServletContext().getRealPath("/");
		String fromPath = rootPath+"Template\\template.html";
		String toPath = rootPath+"Template\\demo.html";
		String oldStr = FileUtil.readFile(fromPath);
		String newStr = oldStr.replace(Constant.DEMO, "我是新的");
		FileUtil.writeFile(newStr, toPath);
		return "success";
	}
	
}
