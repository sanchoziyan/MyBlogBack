package top.lolcl.util;

import java.io.File;
import java.io.IOException;
import java.util.Properties;

/**
 * 读取properties文件的工具类
 * @author sanch
 *
 */
public class PropertyUtil {
	private static PropertyUtil propUtil;
	private static Properties props;
	private PropertyUtil(String path) throws IOException{
		init(path);
	}
	private void init(String path) throws IOException{
		props = new Properties();
		props.load(PropertyUtil.class.getClassLoader().getResourceAsStream(path));
	}
	
	public static PropertyUtil getInstance(String path) throws IOException{
		if(propUtil == null){
			propUtil = new PropertyUtil(path);
		}
		return propUtil;
	}
	
	public static String getProperties(String key){
		return props.getProperty(key);
	}
}
