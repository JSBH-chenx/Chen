package edu.management.controller;

import edu.management.dao.UserDAO;
import edu.management.model.User;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 检查是否已登录
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect("main.jsp");
        } else {
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.authenticate(username, password);

        if (user != null) {
            // 登录成功，创建session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(30 * 60); // 30分钟

            response.sendRedirect("main.jsp");
        } else {
            // 登录失败
            request.setAttribute("errorMessage", "用户名或密码错误！");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}