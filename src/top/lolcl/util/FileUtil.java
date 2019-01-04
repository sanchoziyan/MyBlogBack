package top.lolcl.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * 文件工具类
 * @author sanch
 *
 */
public class FileUtil {
	//系统换行符
	private static final String  LINE_SEPARATOR = System.getProperty("line.separator");
	/**
	 * 读取路径下文档返回字符串
	 * @param fromPath
	 * @return
	 * @throws Exception 
	 */
	public static String readFile(String fromPath) throws Exception{
		File file = new File(fromPath);
		FileReader fr = new FileReader(file);
		BufferedReader buf = new BufferedReader(fr);
		String ch = null;
		StringBuffer content = new StringBuffer();
		while((ch=buf.readLine() )!= null){
			content.append(ch).append(LINE_SEPARATOR);
		}	
		buf.close();
		return content.toString();
	}
	
	/**
	 * 根据字符串 写出到路径下文件
	 * @param str
	 * @param toPath
	 * @throws Exception 
	 */
	public static void writeFile(String str,String toPath) throws Exception{
		File file = new File(toPath);
		if(!file.exists()){
			file.createNewFile();
		}
		PrintWriter out = new PrintWriter(file);
		out.write(str);
//		out.flush();
		out.close();
	}
}
