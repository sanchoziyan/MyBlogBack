package top.lolcl.util;

import java.util.UUID;

/**
 * 生成uuid
 * @author sanch
 *
 */
public class CommonUtil {

	public static String uuid()
	  {
	    return UUID.randomUUID().toString().replace("-", "").toUpperCase();
	  }
}
