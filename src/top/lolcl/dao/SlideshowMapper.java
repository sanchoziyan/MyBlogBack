package top.lolcl.dao;

import java.util.List;

import top.lolcl.entity.Slideshow;

public interface SlideshowMapper {
    int deleteByPrimaryKey(String uuid);

    int insert(Slideshow record);

    int insertSelective(Slideshow record);

    Slideshow selectByPrimaryKey(String uuid);

    int updateByPrimaryKeySelective(Slideshow record);

    int updateByPrimaryKey(Slideshow record);
    List<Slideshow> selectAll();
}