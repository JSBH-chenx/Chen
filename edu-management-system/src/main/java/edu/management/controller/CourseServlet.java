package edu.management.controller;

import edu.management.dao.CourseDAO;
import edu.management.model.User;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/courses")
public class CourseServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 检查是否已登录
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        CourseDAO courseDAO = new CourseDAO();

        // 获取所有课程，并标记哪些是学生已选的
        request.setAttribute("courses", courseDAO.getCoursesByStudentId(user.getId()));
        request.getRequestDispatcher("/course.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 检查是否已登录
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");
        int courseId = Integer.parseInt(request.getParameter("courseId"));

        CourseDAO courseDAO = new CourseDAO();
        boolean success = false;

        if ("select".equals(action)) {
            success = courseDAO.selectCourse(user.getId(), courseId);
        } else if ("drop".equals(action)) {
            success = courseDAO.dropCourse(user.getId(), courseId);
        }

        if (success) {
            response.sendRedirect("courses");
        } else {
            request.setAttribute("errorMessage", "操作失败，请重试！");
            request.getRequestDispatcher("/course.jsp").forward(request, response);
        }
    }
}