package top.lolcl.dao;

import top.lolcl.entity.Right;

public interface RightMapper {
    int deleteByPrimaryKey(String rid);

    int insert(Right record);

    int insertSelective(Right record);

    Right selectByPrimaryKey(String rid);

    int updateByPrimaryKeySelective(Right record);

    int updateByPrimaryKey(Right record);
}