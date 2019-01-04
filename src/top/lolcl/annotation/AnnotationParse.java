package top.lolcl.annotation;

import java.lang.reflect.Method;

/**
 * 注解解析器
 * @author sanch
 *
 */
public class AnnotationParse {
	
	/**
	 * 解析注解
	 * @param targetClassName
	 * @param methodName
	 * @return 权限注解上的value值
	 * @throws Exception
	 */
	public static String parse(Class targetClassName,String methodName) throws Exception{
		String methodAccess = "";
		Method[] methods = targetClassName.getMethods(); //获得目标方法
		for(Method method : methods){
			if(method.getName().equals(methodName)){
				//判断目标方法上面是否存在@PrivilegeAnn注解
				if(method.isAnnotationPresent(PrivilegeAnn.class)){
					PrivilegeAnn annotation = method.getAnnotation(PrivilegeAnn.class);
					methodAccess = annotation.value(); //得到注解上的value值
					break;
				}
			}
		}
		
		return methodAccess;
	}
	
}