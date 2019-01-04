package top.lolcl.dao;

import top.lolcl.entity.HotNews;

public interface HotNewsMapper {
    int deleteByPrimaryKey(String nid);

    int insert(HotNews record);

    int insertSelective(HotNews record);
}