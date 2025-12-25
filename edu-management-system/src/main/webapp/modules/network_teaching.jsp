<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.management.model.User" %>
<%@ page import="edu.management.dao.CourseDAO" %>
<%@ page import="edu.management.model.Course" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    CourseDAO courseDAO = new CourseDAO();
    List<Course> selectedCourses = courseDAO.getSelectedCourses(user.getId());
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>网络教学平台 - 校园业务系统</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa;
            color: #333;
        }

        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px 40px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo h1 {
            font-size: 24px;
            font-weight: 600;
        }

        .logo p {
            font-size: 14px;
            opacity: 0.9;
            margin-top: 5px;
        }

        .nav-buttons {
            display: flex;
            gap: 10px;
        }

        .nav-btn {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            padding: 8px 16px;
            border-radius: 6px;
            text-decoration: none;
            transition: background 0.3s;
            font-size: 14px;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .nav-btn:hover {
            background: rgba(255, 255, 255, 0.3);
        }

        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .page-title {
            font-size: 28px;
            color: #333;
            margin-bottom: 10px;
        }

        .page-subtitle {
            color: #666;
            font-size: 16px;
            margin-bottom: 30px;
        }

        .courses-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .course-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            border: 1px solid #eee;
            transition: transform 0.3s;
        }

        .course-card:hover {
            transform: translateY(-5px);
        }

        .course-header {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
            padding: 20px;
        }

        .course-header h3 {
            font-size: 18px;
            margin-bottom: 5px;
        }

        .course-header .course-code {
            font-size: 14px;
            opacity: 0.9;
        }

        .course-content {
            padding: 20px;
        }

        .course-info {
            margin-bottom: 15px;
        }

        .course-info p {
            margin-bottom: 8px;
            color: #555;
            font-size: 14px;
        }

        .course-actions {
            padding: 15px 20px 20px;
            border-top: 1px solid #eee;
        }

        .btn-course {
            background: #3b82f6;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            width: 100%;
            transition: background 0.3s;
        }

        .btn-course:hover {
            background: #2563eb;
        }

        .empty-state {
            grid-column: 1 / -1;
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .empty-state h3 {
            color: #666;
            font-size: 20px;
            margin-bottom: 15px;
        }

        .empty-state p {
            color: #888;
            font-size: 16px;
            margin-bottom: 20px;
        }

        .empty-state a {
            display: inline-block;
            background: #667eea;
            color: white;
            padding: 12px 24px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 500;
        }

        @media (max-width: 768px) {
            .courses-grid {
                grid-template-columns: 1fr;
            }

            .header-content {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
        }
    </style>
</head>
<body>
<div class="header">
    <div class="header-content">
        <div class="logo">
            <h1>网络教学平台</h1>
            <p>通过互联网进行开发，支持在线学习与互动</p>
        </div>
        <div class="nav-buttons">
            <a href="../main.jsp" class="nav-btn">返回主页</a>
            <a href="../courses" class="nav-btn">去选课</a>
            <a href="../logout" class="nav-btn">退出登录</a>
        </div>
    </div>
</div>

<div class="container">
    <h1 class="page-title">网络教学平台</h1>
    <p class="page-subtitle">欢迎，<%= user.getName() %>！这里是您已选课程的网络教学平台。</p>

    <div class="courses-grid">
        <% if (selectedCourses != null && !selectedCourses.isEmpty()) { %>
        <% for (Course course : selectedCourses) { %>
        <div class="course-card">
            <div class="course-header">
                <h3><%= course.getCourseName() %></h3>
                <div class="course-code"><%= course.getCourseCode() %> - <%= course.getCredit() %>学分</div>
            </div>

            <div class="course-content">
                <div class="course-info">
                    <p><strong>授课教师：</strong><%= course.getTeacherName() %></p>
                    <p><strong>上课时间：</strong><%= course.getScheduleTime() %></p>
                    <p><strong>上课地点：</strong><%= course.getClassroom() %></p>
                    <p><%= course.getDescription() %></p>
                </div>
            </div>

            <div class="course-actions">
                <button class="btn-course" onclick="enterCourse('<%= course.getCourseName() %>')">
                    进入课程学习
                </button>
            </div>
        </div>
        <% } %>
        <% } else { %>
        <div class="empty-state">
            <h3>您还没有选择任何课程</h3>
            <p>网络教学平台将显示您已选的所有课程，包括必修课和选修课</p>
            <a href="../courses">去选课页面选择课程</a>
        </div>
        <% } %>
    </div>
</div>

<script>
    function enterCourse(courseName) {
        alert(`欢迎进入 ${courseName} 的网络教学平台！\n\n课程资料、作业提交、在线测试等功能将在后续版本中实现。`);
    }
</script>
</body>
</html>