package top.lolcl.control;



import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URISyntaxException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.ibatis.annotations.Param;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import top.lolcl.Enum.StateEnum;
import top.lolcl.dao.CategoryMapper;
import top.lolcl.dao.NewsMapper;
import top.lolcl.entity.Category;
import top.lolcl.entity.News;
import top.lolcl.util.CommonUtil;
import top.lolcl.util.PageBean;
import top.lolcl.util.ReadXmlUtil;

@Controller
@RequestMapping(value = "/news")
public class NewsController {
	private static Logger logger = Logger.getLogger(NewsController.class);
	
	@Autowired
	NewsMapper mapper;
	
	@Autowired
	CategoryMapper categorymapper;
	
	SimpleDateFormat formate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	/**
	 * 返回新闻列表界面
	 * @return
	 */
	@RequestMapping(value="/list")
	@ResponseBody
	public String list(Model model,HttpServletRequest req){//返回的参数必须是total和rows，total返回数据集总个数，rows返回table的json格式
		String limit = req.getParameter("limit"); //页面大小
		String offset = req.getParameter("offset"); //条数偏移量
		String search = req.getParameter("search"); //搜索查询条件
		
//		System.out.println(limit+";;"+offset+";;"+search);
//		List<News> list = mapper.selectAll();
		int offset1 = Integer.parseInt(offset);
		int limit1 = Integer.parseInt(limit);
		//当前页面
		int currentPage = offset1/limit1+1;
		int istart = offset1+1;
		int iend = limit1*currentPage+1;
		List<News> list = mapper.query(istart, iend, search);
		int total = mapper.getCounts(search);
		
		for(News n : list){
			n.setPubtimeStr(formate.format(n.getPubtime()));
		}
		
		JSONObject json = new JSONObject();
		json.put("total", total); //总记录数
		json.put("rows", list); //列表数据
		return json.toString();
	}

	/**
	 * 新闻编辑
	 * @return
	 */
	@RequestMapping("/edit")
	public String index(Model model,@Param("nid") String nid){
		List<Category> categorys = categorymapper.selectAll();
		model.addAttribute("categorys",categorys);
		StateEnum[] statenums = StateEnum.values();
		model.addAttribute("statenums",statenums);
		if(!nid.isEmpty()){
			News n = mapper.selectByPrimaryKey(nid);
			n.setPubtimeStr(formate.format(n.getPubtime()));
			model.addAttribute("model",n);
		}
		return "/back/news/edit.jsp";
	}
	
	/**
	 * 上传图片
	 * @param file
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws IOException
	 * @throws URISyntaxException 
	 */
	@RequestMapping("/upload")
	@ResponseBody
    public String index(@RequestParam("file") MultipartFile file,
    		HttpServletRequest request, HttpServletResponse response,Model model) throws Exception {
		logger.debug("获取上传文件...");
		/*读取xml文件中对应元素的值*/
		String imgPath = ReadXmlUtil.getInstance("SysConfig.xml").getTextContent("imgPath");
		String imgServerUrl = ReadXmlUtil.getInstance("SysConfig.xml").getTextContent("imgServerUrl");
		File fileDir = new File(imgPath+"/news") ;//目录 ---》F:/img/news 新闻图片
		if(!fileDir.exists()){
			fileDir.mkdir(); //创建目录
		}
//		System.out.println(fileDir);
		File path = new File(fileDir,file.getOriginalFilename());
		if(!path.exists()){
			path.createNewFile();
		}
		if (!file.isEmpty()) {
			final InputStream is = file.getInputStream();
			final byte[] buf = new byte[1024];
			int ch = 0;
			final OutputStream fos = new FileOutputStream(path);
			while ((ch = is.read(buf)) != -1) {
				fos.write(buf, 0, ch);
				fos.flush();
			}
			fos.close();
			is.close();
		}
        JSONObject json = new JSONObject();
        String imgUrl = imgServerUrl+"/news/"+file.getOriginalFilename();
        json.put("imgUrl", imgUrl );
        return json.toString();
    }
	
	/**
	 * 新增/修改
	 * @param model
	 * @return
	 */
	@RequestMapping("/submit")
	@ResponseBody
	public String submit(News model){
		if(model.getNid().isEmpty()){
			//新增
			model.setNid(CommonUtil.uuid());
			int i = mapper.insert(model);
		}else{
			//修改
			mapper.updateByPrimaryKeySelective(model);
		}
		
		model.setCategory(categorymapper.selectByPrimaryKey(model.getCid()));
		model.setPubtimeStr(formate.format(model.getPubtime()));
		model.setStateEnum(StateEnum.getStateEnum(model.getState()));
		
		JSONObject json = new JSONObject();
		json.put("success", true );
		return json.toString();
	}
	
	/**
	 * 删除
	 * @param nid
	 * @return
	 */
	@RequestMapping("/remove")
	@ResponseBody
	public String remove(String nid){
		mapper.deleteByPrimaryKey(nid);
		return "success";
	}
	
	@RequestMapping("/show")
	public String show(String nid,Model model){
		News news = mapper.selectByPrimaryKey(nid);
		model.addAttribute("model",news);
		return "/back/news/show.jsp";
	}
}
