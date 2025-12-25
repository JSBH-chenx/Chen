package edu.management.filter;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class LoginFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 初始化方法
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String requestURI = req.getRequestURI();

        // 允许访问的页面（不需要登录）
        if (requestURI.endsWith("login.jsp") ||
                requestURI.endsWith("login") ||
                requestURI.contains("/css/") ||
                requestURI.contains("/js/") ||
                requestURI.contains("/images/")) {
            chain.doFilter(request, response);
            return;
        }

        // 检查是否已登录
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // 销毁方法
    }
}