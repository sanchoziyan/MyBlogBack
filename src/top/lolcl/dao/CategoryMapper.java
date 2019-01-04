package top.lolcl.dao;

import java.util.List;

import top.lolcl.entity.Category;

public interface CategoryMapper {
    int deleteByPrimaryKey(String cid);

    int insert(Category record);

    int insertSelective(Category record);

    Category selectByPrimaryKey(String cid);

    int updateByPrimaryKeySelective(Category record);

    int updateByPrimaryKey(Category record);
    List<Category> selectAll();
}