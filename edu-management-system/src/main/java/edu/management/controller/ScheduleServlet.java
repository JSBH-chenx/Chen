package edu.management.controller;

import edu.management.dao.ScheduleDAO;
import edu.management.model.User;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/schedule")
public class ScheduleServlet extends HttpServlet {

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
        ScheduleDAO scheduleDAO = new ScheduleDAO();

        // 获取学生课表
        request.setAttribute("schedules", scheduleDAO.getStudentSchedule(user.getId()));
        request.getRequestDispatcher("/schedule.jsp").forward(request, response);
    }
}