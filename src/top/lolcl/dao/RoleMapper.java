package top.lolcl.dao;

import top.lolcl.entity.Role;

public interface RoleMapper {
    int deleteByPrimaryKey(String roid);

    int insert(Role record);

    int insertSelective(Role record);

    Role selectByPrimaryKey(String roid);

    int updateByPrimaryKeySelective(Role record);

    int updateByPrimaryKey(Role record);
}