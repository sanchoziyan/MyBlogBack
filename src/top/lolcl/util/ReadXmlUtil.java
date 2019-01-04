package top.lolcl.util;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

/**
 * 读取xml工具类
 * @author sanch
 *
 */
public class ReadXmlUtil {
	
	private static ReadXmlUtil readXmlUtil;
	private static Document doc;
	private ReadXmlUtil(String filename) throws URISyntaxException{
		init(filename);
	}
	
	private void init(String filename) throws URISyntaxException {
		String path = ReadXmlUtil.class.getResource("/").toURI().getPath();	
		String fileName = path + filename;	
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = null;
		try {
			builder = factory.newDocumentBuilder();
			this.doc = builder.parse(new File(fileName));
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	public static ReadXmlUtil getInstance(String filename) throws URISyntaxException{
		if(readXmlUtil == null){
			readXmlUtil = new ReadXmlUtil(filename);
		}
		return readXmlUtil;
	}
	
	/**
	 * 返回第一个tagname元素的TextContent内容
	 * @param tagname
	 * @return
	 */
	public static String getTextContent(String tagname){
		NodeList elements = doc.getElementsByTagName(tagname);
		Element element = (Element)elements.item(0);//获取第一个元素
		return  element.getTextContent();	
	}
	
	/**
	 * 返回第一个tagname元素的属性的值的集合
	 * @return
	 */
	public static List<Map> getAttrVal(String tagname,String...attr){
		List<Map> list = new ArrayList<Map>();
		Node parentNode = doc.getElementsByTagName(tagname).item(0);
		NodeList childNodes = parentNode.getChildNodes();
		for(int i=0;i<childNodes.getLength();i++){
			Node n = childNodes.item(i);
			if(n instanceof Element){
				Element element = (Element)n;
				Map map = new HashMap();
				for(int j=0; j<attr.length;j++){
					map.put(attr[j],element.getAttribute(attr[j]));
					list.add(map);
				}
				
			}
		}
		return list;
	}
}
