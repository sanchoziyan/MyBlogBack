package top.lolcl.util;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GetContent implements Filter {
    public void destroy() {
    }
 
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        SysContent.setRequest((HttpServletRequest)req);
        SysContent.setResponse((HttpServletResponse)resp);
        chain.doFilter(req, resp);
    }
 
    public void init(FilterConfig config) throws ServletException {
 
    }
 

}
