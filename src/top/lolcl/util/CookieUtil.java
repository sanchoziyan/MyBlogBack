package top.lolcl.util;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * cookie工具类 获取 设置cookie
 * @author sanch
 *
 */
public class CookieUtil {
	
	/**
	 * 添加cookie
	 * @param res 返回cookie  response对象
	 * @param name Cookie的key
	 * @param value Cookie的value
	 * @param maxAge Cookie的有效时长 默认-1
	 */
	public static void addCookie(HttpServletResponse res,String name,String value,int maxAge){
		Cookie cookie = new Cookie(name,value);
		if(maxAge > 0){
			cookie.setMaxAge(maxAge);
		}
		res.addCookie(cookie);
	}

	/**
	 * 根据cookie的key 获取Cookie对象
	 * @param req
	 * @param name
	 * @return
	 */
	public static Cookie getCookieByName(HttpServletRequest req,String name){
		Cookie cookie = null;
		Map<String, Cookie> cookieMap = ReadCookieMap(req);
		if(cookieMap.containsKey(name)){
			return cookieMap.get(name);
		}
		
		return null;
	}
	
	/**
	 * 读取Cookie
	 * @param req
	 * @return 返回cookie的map集合
	 */
	public static Map<String, Cookie> ReadCookieMap(HttpServletRequest req){
		Map<String, Cookie> map = new HashMap<String, Cookie>();
		Cookie[] cookies = req.getCookies();
		for(Cookie cookie : cookies){
			map.put(cookie.getName(), cookie);
		}
		return map;
	}
	
	/**
	 * 清除cookie
	 * @param response
	 * @param killcookie
	 */
	public static void killCookie(HttpServletResponse response,Cookie killcookie){
		killcookie.setValue(null);
		killcookie.setMaxAge(0);
		killcookie.setPath("/");
		response.addCookie(killcookie);
	}
}
