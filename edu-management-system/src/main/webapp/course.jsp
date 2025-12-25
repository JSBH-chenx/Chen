<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.management.model.User" %>
<%@ page import="edu.management.model.Course" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Course> courses = (List<Course>) request.getAttribute("courses");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>教务管理系统 - 选课/退课</title>
    <link rel="stylesheet" href="css/style.css">
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
            margin: 30px auto;
            padding: 0 20px;
        }

        .page-title {
            font-size: 28px;
            color: #333;
            margin-bottom: 20px;
        }

        .page-subtitle {
            color: #666;
            font-size: 16px;
            margin-bottom: 30px;
        }

        .courses-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
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
            padding: 20px;
            border-bottom: 1px solid #eee;
            background: #f8f9fa;
        }

        .course-code {
            font-size: 14px;
            color: #666;
            margin-bottom: 5px;
        }

        .course-name {
            font-size: 18px;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
        }

        .course-info {
            display: flex;
            gap: 15px;
            font-size: 13px;
            color: #666;
        }

        .course-info span {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .course-content {
            padding: 20px;
        }

        .course-description {
            color: #666;
            font-size: 14px;
            line-height: 1.6;
            margin-bottom: 15px;
        }

        .course-details {
            font-size: 13px;
            color: #555;
            margin-bottom: 15px;
        }

        .course-details p {
            margin-bottom: 8px;
        }

        .course-status {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-required {
            background: #fef3c7;
            color: #92400e;
        }

        .status-selected {
            background: #d1fae5;
            color: #065f46;
        }

        .status-available {
            background: #dbeafe;
            color: #1e40af;
        }

        .course-actions {
            padding: 15px 20px 20px;
            border-top: 1px solid #eee;
            text-align: right;
        }

        .btn-course {
            padding: 8px 20px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            border: none;
            transition: all 0.3s;
        }

        .btn-select {
            background: #10b981;
            color: white;
        }

        .btn-select:hover {
            background: #059669;
        }

        .btn-select:disabled {
            background: #9ca3af;
            cursor: not-allowed;
        }

        .btn-drop {
            background: #ef4444;
            color: white;
        }

        .btn-drop:hover {
            background: #dc2626;
        }

        .btn-view {
            background: #3b82f6;
            color: white;
        }

        .btn-view:hover {
            background: #2563eb;
        }

        .back-btn {
            background: #6b7280;
            color: white;
            padding: 10px 20px;
            border-radius: 6px;
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;
        }

        .back-btn:hover {
            background: #4b5563;
        }

        .capacity-bar {
            height: 6px;
            background: #e5e7eb;
            border-radius: 3px;
            margin-top: 10px;
            overflow: hidden;
        }

        .capacity-fill {
            height: 100%;
            background: #10b981;
            border-radius: 3px;
            transition: width 0.3s;
        }

        .capacity-text {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
            text-align: right;
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
            <h1>教务管理系统 - 选课/退课</h1>
        </div>
        <div class="nav-buttons">
            <a href="main.jsp" class="nav-btn">返回主页</a>
            <a href="schedule" class="nav-btn">查看课表</a>
            <a href="logout" class="nav-btn">退出登录</a>
        </div>
    </div>
</div>

<div class="container">
    <h1 class="page-title">课程列表</h1>
    <p class="page-subtitle">欢迎，<%= user.getName() %>！您可以在此选择或退选课程。必修课必须选择且不能退选。</p>

    <% if (request.getAttribute("errorMessage") != null) { %>
    <div style="background: #fee; color: #c00; padding: 15px; border-radius: 6px; margin-bottom: 20px; border: 1px solid #fcc;">
        <%= request.getAttribute("errorMessage") %>
    </div>
    <% } %>

    <div class="courses-grid">
        <% if (courses != null && !courses.isEmpty()) { %>
        <% for (Course course : courses) {
            double capacityPercent = (double) course.getEnrolledCount() / course.getCapacity() * 100;
            boolean isFull = course.getEnrolledCount() >= course.getCapacity();
        %>
        <div class="course-card">
            <div class="course-header">
                <div class="course-code"><%= course.getCourseCode() %></div>
                <div class="course-name"><%= course.getCourseName() %></div>
                <div class="course-info">
                    <span><%= course.getCredit() %> 学分</span>
                    <span><%= course.getTeacherName() %></span>
                    <span class="course-status <%= course.isRequired() ? "status-required" : (course.isSelected() ? "status-selected" : "status-available") %>">
                                    <%= course.isRequired() ? "必修课" : (course.isSelected() ? "已选" : "可选") %>
                                </span>
                </div>
            </div>

            <div class="course-content">
                <p class="course-description"><%= course.getDescription() %></p>
                <div class="course-details">
                    <p><strong>上课时间：</strong><%= course.getScheduleTime() %></p>
                    <p><strong>上课地点：</strong><%= course.getClassroom() %></p>
                    <p><strong>授课教师：</strong><%= course.getTeacherName() %></p>

                    <div class="capacity-bar">
                        <div class="capacity-fill" style="width: <%= capacityPercent %>%"></div>
                    </div>
                    <div class="capacity-text">
                        已选 <%= course.getEnrolledCount() %> / <%= course.getCapacity() %> 人
                        <%= isFull ? "（已满）" : "" %>
                    </div>
                </div>
            </div>

            <div class="course-actions">
                <% if (course.isRequired()) { %>
                <button class="btn-course btn-select" disabled>必修课程</button>
                <% } else if (course.isSelected()) { %>
                <form action="courses" method="POST" style="display: inline;">
                    <input type="hidden" name="courseId" value="<%= course.getId() %>">
                    <input type="hidden" name="action" value="drop">
                    <button type="submit" class="btn-course btn-drop"
                            <%= isFull && !course.isSelected() ? "disabled" : "" %>>
                        退选课程
                    </button>
                </form>
                <% } else { %>
                <form action="courses" method="POST" style="display: inline;">
                    <input type="hidden" name="courseId" value="<%= course.getId() %>">
                    <input type="hidden" name="action" value="select">
                    <button type="submit" class="btn-course btn-select"
                            <%= isFull ? "disabled" : "" %>>
                        选择课程
                    </button>
                </form>
                <% } %>

                <button class="btn-course btn-view"
                        onclick="showCourseDetails('<%= course.getCourseName() %>', '<%= course.getDescription() %>', '<%= course.getScheduleTime() %>', '<%= course.getClassroom() %>')">
                    查看详情
                </button>
            </div>
        </div>
        <% } %>
        <% } else { %>
        <div style="grid-column: 1 / -1; text-align: center; padding: 40px; background: white; border-radius: 12px;">
            <p style="color: #666; font-size: 16px;">暂无课程数据</p>
        </div>
        <% } %>
    </div>

    <a href="main.jsp" class="back-btn">返回主页面</a>
</div>

<script>
    function showCourseDetails(name, description, time, location) {
        alert(`课程详情：\n\n课程名称：${name}\n\n课程描述：${description}\n\n上课时间：${time}\n\n上课地点：${location}`);
    }

    // 确认退选操作
    document.querySelectorAll('form').forEach(form => {
        form.addEventListener('submit', function(e) {
            const action = this.querySelector('input[name="action"]').value;
            if (action === 'drop') {
                if (!confirm('确定要退选此课程吗？')) {
                    e.preventDefault();
                }
            }
        });
    });
</script>
</body>
</html>
