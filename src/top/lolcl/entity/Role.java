package top.lolcl.entity;

public class Role {
    private String roid;

    private String roname;

    public String getRoid() {
        return roid;
    }

    public void setRoid(String roid) {
        this.roid = roid == null ? null : roid.trim();
    }

    public String getRoname() {
        return roname;
    }

    public void setRoname(String roname) {
        this.roname = roname == null ? null : roname.trim();
    }
}