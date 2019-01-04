package top.lolcl.dao;

import java.util.List;
import top.lolcl.entity.RoleRight;

public interface RoleRightMapper {
    int insert(RoleRight record);

    int insertSelective(RoleRight record);
    
    List<RoleRight> selectByROID(String roid);
}