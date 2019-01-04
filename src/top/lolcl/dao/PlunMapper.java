package top.lolcl.dao;

import top.lolcl.entity.Plun;

public interface PlunMapper {
    int deleteByPrimaryKey(Integer pid);

    int insert(Plun record);

    int insertSelective(Plun record);

    Plun selectByPrimaryKey(Integer pid);

    int updateByPrimaryKeySelective(Plun record);

    int updateByPrimaryKey(Plun record);
}