package top.lolcl.Enum;

public enum StateEnum {
	NORMAL("正常",new Short("1")),SHELVES("下架",new Short("0"));
	private final String name;
	private final Short num;
	
	
	private StateEnum(String name,Short num)
    {
        this.num = num;
        this.name=name;
    }
	public String getName() {
		return this.name;
	}
	public Short getNum() {
		return this.num;
	}

	public static StateEnum getStateEnum(Short num){
	    for (StateEnum s : StateEnum.values()) {
	      if (s.getNum()-num ==0) {
	        return s;
	      }
	    }
	    return null;
	}
	
	public static StateEnum getStateEnum(String name){
		for (StateEnum s : StateEnum.values()) {
			if (s.getName() == name) {
				return s;
			}
		}
		return null;
	}
}
