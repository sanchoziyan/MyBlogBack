package top.lolcl.dao;

import java.util.List;

import top.lolcl.entity.User;

public interface UserMapper {
    int deleteByPrimaryKey(String uname);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(String uname);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
    
    List<User> selectAll();
}