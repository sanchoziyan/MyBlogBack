package top.lolcl.control;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import top.lolcl.constant.Constant;
import top.lolcl.dao.AdminMapper;
import top.lolcl.dao.UserMapper;
import top.lolcl.entity.Admin;
import top.lolcl.entity.User;
import top.lolcl.util.CookieUtil;

@Controller
@RequestMapping("/user")
public class UserControl {
	@Autowired
	AdminMapper adminmapper;
	
	@Autowired
	UserMapper usermapper;
	
	/**
	 * 登陆功能
	 * @return
	 */
	@RequestMapping("/login")
	public String login(@Param("uname")String uname,@Param("pwd")String pwd,Model model,
			HttpServletRequest req,HttpServletResponse res){
	
		if(!uname.isEmpty() && !pwd.isEmpty()){
			User admin = usermapper.selectByPrimaryKey(uname);
			if(admin != null){
				if(admin.getPwd().equals(pwd)){
					//登陆成功
					req.getSession().setAttribute(Constant.SESSION_USER_KEY, admin);
					CookieUtil.addCookie(res, Constant.COOKIE_USER_KEY, admin.getUname()+","+admin.getPwd(), Constant.COOKIE_AGE);
					return "redirect:/back/index"; //重定向到 
				}
			}
			
		}
		model.addAttribute("msg","登陆失败，用户名，密码不正确");
		model.addAttribute("uname",uname);
		return "forward:/back/login"; //转发
		
	}
	
	/**
	 * 退出登陆
	 * @return
	 */
	@RequestMapping("/logout")
	public String logout(HttpServletRequest req,HttpServletResponse res){
		req.getSession().invalidate();//清除session
		Cookie  killcookie = CookieUtil.getCookieByName(req, Constant.COOKIE_USER_KEY);
		CookieUtil.killCookie(res, killcookie);
		return "/back/login.jsp";
	}
	
	/**
	 * 打开模态框
	 * @return
	 */
	@RequestMapping("/edit")
	public String edit(){
		return "/back/user/edit.jsp";
	}
	
	/**
	 * 提交用户信息
	 * @param user
	 * @return
	 */
	@RequestMapping("/submit")
	@ResponseBody
	public String submit(User user){
		usermapper.insert(user);
		return "success";
	}

	/**
	 * 删除
	 * @param uname
	 * @return
	 */
	@RequestMapping("/remove")
	@ResponseBody
	public String remove(@Param("uname")String uname){
		@SuppressWarnings("unused")
		int i = usermapper.deleteByPrimaryKey(uname);
		return "success";
	}
}
