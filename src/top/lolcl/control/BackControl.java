package top.lolcl.control;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import top.lolcl.Enum.StateEnum;
import top.lolcl.annotation.PrivilegeAnn;
import top.lolcl.dao.CategoryMapper;
import top.lolcl.dao.NewsMapper;
import top.lolcl.dao.SlideshowMapper;
import top.lolcl.dao.UserMapper;
import top.lolcl.entity.Category;
import top.lolcl.entity.News;
import top.lolcl.entity.Slideshow;
import top.lolcl.entity.User;
import top.lolcl.util.PageBean;
import top.lolcl.util.PropertyUtil;
import top.lolcl.util.ReadXmlUtil;

/**
 * 后台逻辑控制层
 * @author sanch
 *
 */
@Controller
@RequestMapping("/back")
public class BackControl {
	
	@Autowired
	SlideshowMapper slideshowmapper; //图片对象
	
	@Autowired
	CategoryMapper categorymapper; //新闻分类
	
	@Autowired
	NewsMapper newsmapper;//新闻
	
	@Autowired
	UserMapper usermapper;//用户
	
	/**
	 * 后台登陆界面
	 * @return
	 */
	@RequestMapping("/login")
	public String login(){
		return "/back/login.jsp";
	}
	
	/**
	 * 进入主界面
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@PrivilegeAnn("user")
	@RequestMapping("/index")
	public String index(Model model) throws Exception{
		List<Slideshow> slideshows = slideshowmapper.selectAll();
		model.addAttribute("model", slideshows);
		model.addAttribute("loadpath","echarts.jsp");
		return "/back/index.jsp";
	}
	
	@RequestMapping("/user")
	public String user(Model model){
		List<User> users = usermapper.selectAll();
		model.addAttribute("model",users);
		return "/back/user/list.jsp";
	}
	
	/**
	 * 选项卡 返回轮播图管理
	 * @param model
	 * @return
	 */
	@RequestMapping("/slideshow")
	public String slideshow(Model model){
		List<Slideshow> slideshows = slideshowmapper.selectAll();
		model.addAttribute("model", slideshows);
		return "/back/slideshow/list.jsp";
	}
	
	/**
	 * 返回新闻分类列表界面
	 * @param model
	 * @return
	 */
	@RequestMapping("/category")
	public String category(Model model){
		List<Category> categorys = categorymapper.selectAll();
		model.addAttribute("model",categorys);
		return "/back/category/list.jsp";
	}
	/**
	 * 返回新闻选项卡
	 * @param model
	 * @return
	 */
	@RequestMapping("/news")
	public String news(Model model,HttpServletRequest req){
		String currentPage = req.getParameter("currentPage");
		PageBean<News> pageBean = new PageBean<News>();
		pageBean.setCurrentPage(Integer.parseInt(currentPage));//默认当前页是第一页
		pageBean.setPageSize(3);//每页显示条数
		
//		List<News> news = newsmapper.selectAll();
		int iStart = (pageBean.getCurrentPage()-1)*pageBean.getPageSize()+1;
		int iEnd = pageBean.getCurrentPage()*pageBean.getPageSize()+1;
		List<News> news = newsmapper.query(iStart, iEnd, null);
		for(News n : news){
			n.setCategory(categorymapper.selectByPrimaryKey(n.getCid()));
			n.setStateEnum(StateEnum.getStateEnum(n.getState()));
		}
		pageBean.setPageData(news);
		pageBean.setTotalCount(newsmapper.getCounts(null));
		model.addAttribute("model",news);
		model.addAttribute("pageBean",pageBean);
		model.addAttribute("pageCount",pageBean.getPageCount());
		model.addAttribute("NextPage",pageBean.getNextPage());
		model.addAttribute("PrevPage",pageBean.getPrevPage());
		return "/back/news/list.jsp";
	}
	
	/**
	 * 页面生成
	 * @return
	 */
	@RequestMapping("/pageCreate")
	public String pageCreate(){
		return "/back/pageCreate.jsp";
	}
	
	/** 
	 * 返回主页面
	 * @param model
	 * @return
	 */
	@RequestMapping("/main")
	public String test(Model model){
		
		List<Slideshow> list = slideshowmapper.selectAll();
		model.addAttribute("model",list);
		List<News> news = newsmapper.selectAll();
		for(News n : news){
			n.setCategory(categorymapper.selectByPrimaryKey(n.getCid()));
			n.setStateEnum(StateEnum.getStateEnum(n.getState()));
		}
		model.addAttribute("model1",news);
		return "main/index.jsp";
	}
	

}
