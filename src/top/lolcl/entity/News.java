package top.lolcl.entity;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import top.lolcl.Enum.StateEnum;

public class News {
    private String nid;

    private String cid;

    private String title;
    
    private Date pubtime;

    private Short state;

    private String info;
    
    private Category category;
    
    private StateEnum stateEnum;
    
    private String pubtimeStr;
    
    public String getPubtimeStr() {
		return pubtimeStr;
	}

	public void setPubtimeStr(String pubtimeStr) {
		this.pubtimeStr = pubtimeStr;
	}

	public StateEnum getStateEnum() {
		return stateEnum;
	}

	public void setStateEnum(StateEnum stateEnum) {
		this.stateEnum = stateEnum;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public String getNid() {
        return nid;
    }

    public void setNid(String nid) {
        this.nid = nid == null ? null : nid.trim();
    }

    public String getCid() {
        return cid;
    }

    public void setCid(String cid) {
        this.cid = cid == null ? null : cid.trim();
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public Date getPubtime() {
        return pubtime;
    }

    public void setPubtime(Date pubtime) {
        this.pubtime = pubtime;
    }

    public Short getState() {
        return state;
    }

    public void setState(Short state) {
        this.state = state;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info == null ? null : info.trim();
    }
}