package top.lolcl.entity;

public class HotNews {
    private String nid;

    public String getNid() {
        return nid;
    }

    public void setNid(String nid) {
        this.nid = nid == null ? null : nid.trim();
    }
}