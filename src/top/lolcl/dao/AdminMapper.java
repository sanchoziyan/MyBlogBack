package top.lolcl.dao;

import top.lolcl.entity.Admin;

public interface AdminMapper {
    int deleteByPrimaryKey(String uname);

    int insert(Admin record);

    int insertSelective(Admin record);

    Admin selectByPrimaryKey(String uname);

    int updateByPrimaryKeySelective(Admin record);

    int updateByPrimaryKey(Admin record);
}