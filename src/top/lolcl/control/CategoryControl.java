package top.lolcl.control;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import top.lolcl.dao.CategoryMapper;
import top.lolcl.entity.Category;

@Controller
@RequestMapping("/category")
public class CategoryControl {
	
	private static Logger logger = Logger.getLogger(CategoryControl.class);
	
	@Autowired
	CategoryMapper categorymapper;
	/**
	 * 新增轮播图界面
	 * @param model
	 * @return
	 */
	@RequestMapping("/edit")
	public String index(Model model){
		return "/back/category/edit.jsp";
	}
	
	@RequestMapping("/submit")
	@ResponseBody
	public String submit(Category model){
		categorymapper.insert(model);
		return "success";
	}
	
	@RequestMapping("/remove")
	@ResponseBody
	public String remove(String uuid){
		categorymapper.deleteByPrimaryKey(uuid);
		return "success";
	}
}
