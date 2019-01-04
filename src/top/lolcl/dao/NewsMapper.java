package top.lolcl.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import top.lolcl.entity.News;

public interface NewsMapper {
    int deleteByPrimaryKey(String nid);

    int insert(News record);

    int insertSelective(News record);

    News selectByPrimaryKey(String nid);

    int updateByPrimaryKeySelective(News record);

    int updateByPrimaryKeyWithBLOBs(News record);

    int updateByPrimaryKey(News record);
    
    List<News> selectAll();
    
    int getCounts(@Param("title")String title); //根据条件返回数量
    
    List<News> query(@Param("iStart") int iStart,@Param("iEnd") int iEnd, @Param("title")String title);//分页查询
}