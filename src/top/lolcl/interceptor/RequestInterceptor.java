package top.lolcl.interceptor;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import top.lolcl.annotation.AnnotationParse;
import top.lolcl.constant.Constant;
import top.lolcl.dao.RightMapper;
import top.lolcl.dao.RoleMapper;
import top.lolcl.dao.RoleRightMapper;
import top.lolcl.entity.Right;
import top.lolcl.entity.Role;
import top.lolcl.entity.RoleRight;
import top.lolcl.entity.User;
import top.lolcl.util.SysContent;


/**
 * 
 * 请求拦截器 切面编程
 * @author sanch
 *
 */
@Aspect // 表示该类是一个通知类
@Component //spring注解方式bean注入 交给spring管理
public class RequestInterceptor {
	private  final static Logger logger = Logger.getLogger(RequestInterceptor.class);
	
	@Autowired
	RoleMapper rolemapper;
	
	@Autowired
	RightMapper rightmapper;
	
	@Autowired
	RoleRightMapper rrmapper;
	
	//定义一个空方法 借用其注解抽取切点表达式 
	@Pointcut("execution (* top.lolcl.control.*.*(..)) && @annotation(top.lolcl.annotation.PrivilegeAnn) ")
	public void point() {} 
	
	@Before("point()")
	public void permissCommon(JoinPoint joinPoint) throws Exception{
		HttpServletRequest request = getRequest();
		String path = request.getContextPath();
		String basePath = request.getScheme() + "://"
				+ request.getServerName() + ":" + request.getServerPort()
				+ path + "/";
        // 获取方法
        Class targetClass = joinPoint.getTarget().getClass();
		String methodName = joinPoint.getSignature().getName();
        String methodAccess = AnnotationParse.parse(targetClass, methodName);        
        
        Object admin = SysContent.getSession().getAttribute(Constant.SESSION_USER_KEY);
        if(admin == null){ //进行拦截处理
        	SysContent.getResponse().sendRedirect(basePath+"back/login");
        }else {
        	//对登陆用户进行权限控制
        	User user = (User)admin; 
        	Short role = user.getRole(); //获取角色
        	
        		List<RoleRight> list = rrmapper.selectByROID(String.valueOf(role));
        		Map<String, List<Right>> map = new HashMap<String, List<Right>>();
        		List<Right> rights = new ArrayList<Right>(); //一级菜单
        		for (RoleRight li : list){
        			Right right = rightmapper.selectByPrimaryKey(li.getRid());
//        			System.out.println(right.getRname()+";;"+right.getPid() + ";;"+right.getRid());
        			if(right.getPid().equals("0")){
        				rights.add(right); //一级菜单
        			}
        			
        		}
        		//二级菜单
        		for(Right ri : rights){
        			List<Right> ris = new ArrayList<Right>(); 
        			String rid = ri.getRid();
        			for (RoleRight li : list){
                		Right right = rightmapper.selectByPrimaryKey(li.getRid());
//                		System.out.println(right.getRname()+";;"+right.getPid() + ";;"+right.getRid());
        				if(rid.equals(right.getPid())){
        					ris.add(right);
        				}
        			}
        			map.put(ri.getRname(), ris);
        		}
        		
        		request.setAttribute("map", map);
        	
        }
	}
	
	/*@Before("")
	public void before(JoinPoint joinPoint){}
	@Around("")
	public void around(ProceedingJoinPoint pjp){}
	@After("")
	public void after(JoinPoint joinPoint){}
	@AfterReturning("")
	public void afterRunning(JoinPoint joinPoint){}
	@AfterThrowing("")
    public void afterThrowing(JoinPoint joinPoint) {}*/
	
	/** * 在切面中获取http请求 * @return */ 
    private HttpServletRequest getRequest() { 
        return ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest(); 
    }
  

}
