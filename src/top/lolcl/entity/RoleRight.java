package top.lolcl.entity;

public class RoleRight {
    private String roid;

    private String rid;

    public String getRoid() {
        return roid;
    }

    public void setRoid(String roid) {
        this.roid = roid == null ? null : roid.trim();
    }

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid == null ? null : rid.trim();
    }
}