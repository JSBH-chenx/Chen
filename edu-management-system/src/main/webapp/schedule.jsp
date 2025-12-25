<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.management.model.User" %>
<%@ page import="edu.management.model.Schedule" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Schedule> schedules = (List<Schedule>) request.getAttribute("schedules");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>教务管理系统 - 个人课表</title>
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

        .schedule-container {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 40px;
            overflow-x: auto;
        }

        .schedule-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 800px;
        }

        .schedule-table th {
            background: #f8f9fa;
            padding: 15px;
            text-align: center;
            font-weight: 600;
            color: #333;
            border: 1px solid #e5e7eb;
        }

        .schedule-table td {
            padding: 15px;
            border: 1px solid #e5e7eb;
            vertical-align: top;
            height: 120px;
            width: 16.66%;
        }

        .time-header {
            width: 100px;
            font-weight: 600;
            background: #f8f9fa;
        }

        .schedule-item {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 10px;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .schedule-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .schedule-item h4 {
            font-size: 14px;
            margin-bottom: 5px;
            font-weight: 600;
        }

        .schedule-item p {
            font-size: 12px;
            opacity: 0.9;
            margin-bottom: 3px;
        }

        .empty-cell {
            background: #f9fafb;
            color: #9ca3af;
            text-align: center;
            padding: 20px;
            font-size: 14px;
        }

        .day-header {
            font-size: 16px;
            color: #333;
        }

        .time-slot {
            font-size: 14px;
            color: #666;
            text-align: center;
            padding: 5px;
            border-bottom: 1px solid #e5e7eb;
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

        .legend {
            display: flex;
            gap: 20px;
            margin-top: 20px;
            flex-wrap: wrap;
        }

        .legend-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
        }

        .legend-color {
            width: 16px;
            height: 16px;
            border-radius: 4px;
        }

        .color-required {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .color-selected {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
        }

        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }

            .nav-buttons {
                flex-wrap: wrap;
                justify-content: center;
            }

            .schedule-container {
                padding: 15px;
            }
        }
    </style>
</head>
<body>
<div class="header">
    <div class="header-content">
        <div class="logo">
            <h1>教务管理系统 - 个人课表</h1>
        </div>
        <div class="nav-buttons">
            <a href="main.jsp" class="nav-btn">返回主页</a>
            <a href="courses" class="nav-btn">选课/退课</a>
            <a href="logout" class="nav-btn">退出登录</a>
        </div>
    </div>
</div>

<div class="container">
    <h1 class="page-title"><%= user.getName() %>的个人课表</h1>
    <p class="page-subtitle">以下是您本学期的课程安排</p>

    <div class="schedule-container">
        <table class="schedule-table">
            <thead>
            <tr>
                <th style="width: 100px;">时间</th>
                <th class="day-header">星期一</th>
                <th class="day-header">星期二</th>
                <th class="day-header">星期三</th>
                <th class="day-header">星期四</th>
                <th class="day-header">星期五</th>
            </tr>
            </thead>
            <tbody>
            <%
                // 定义时间段
                String[] timeSlots = {
                        "8:00-10:00",
                        "10:00-12:00",
                        "14:00-16:00",
                        "16:00-18:00",
                        "19:00-21:00"
                };

                // 初始化课表数据
                String[][] scheduleData = new String[5][6]; // 5个时间段，6列（1列时间+5列星期）

                // 填充时间列
                for (int i = 0; i < timeSlots.length; i++) {
                    scheduleData[i][0] = timeSlots[i];
                }

                // 填充课程数据
                if (schedules != null) {
                    for (Schedule schedule : schedules) {
                        String day = schedule.getDayOfWeek();
                        String startTime = schedule.getStartTime();
                        String courseInfo = schedule.getCourseName() + "\n" +
                                schedule.getClassroom() + "\n" +
                                schedule.getTeacherName();

                        // 将课程安排到对应的时间段
                        int dayIndex = -1;
                        switch(day) {
                            case "Monday": dayIndex = 1; break;
                            case "Tuesday": dayIndex = 2; break;
                            case "Wednesday": dayIndex = 3; break;
                            case "Thursday": dayIndex = 4; break;
                            case "Friday": dayIndex = 5; break;
                        }

                        int timeIndex = -1;
                        if (startTime.contains("09:00") || startTime.contains("8")) {
                            timeIndex = 0;
                        } else if (startTime.contains("10:00") || startTime.contains("14:00")) {
                            timeIndex = startTime.contains("10:00") ? 1 : 2;
                        } else if (startTime.contains("16:00") || startTime.contains("19:00")) {
                            timeIndex = startTime.contains("16:00") ? 3 : 4;
                        }

                        if (dayIndex != -1 && timeIndex != -1) {
                            scheduleData[timeIndex][dayIndex] = courseInfo;
                        }
                    }
                }
            %>

            <% for (int i = 0; i < timeSlots.length; i++) { %>
            <tr>
                <td class="time-slot"><%= timeSlots[i] %></td>
                <% for (int j = 1; j <= 5; j++) { %>
                <td>
                    <% if (scheduleData[i][j] != null && !scheduleData[i][j].isEmpty()) {
                        String[] courseDetails = scheduleData[i][j].split("\n");
                    %>
                    <div class="schedule-item" onclick="showCourseInfo('<%= courseDetails[0] %>', '<%= courseDetails[1] %>', '<%= courseDetails[2] %>', '<%= timeSlots[i] %>')">
                        <h4><%= courseDetails[0] %></h4>
                        <p><%= courseDetails[1] %></p>
                        <p><%= courseDetails[2] %></p>
                    </div>
                    <% } else { %>
                    <div class="empty-cell">无课程</div>
                    <% } %>
                </td>
                <% } %>
            </tr>
            <% } %>
            </tbody>
        </table>

        <div class="legend">
            <div class="legend-item">
                <div class="legend-color color-required"></div>
                <span>必修课程</span>
            </div>
            <div class="legend-item">
                <div class="legend-color color-selected"></div>
                <span>已选课程</span>
            </div>
        </div>
    </div>

    <a href="main.jsp" class="back-btn">返回主页面</a>
    <a href="courses" class="back-btn" style="background: #10b981; margin-left: 10px;">去选课</a>
</div>

<script>
    function showCourseInfo(name, location, teacher, time) {
        alert(`课程信息：\n\n课程名称：${name}\n\n上课地点：${location}\n\n授课教师：${teacher}\n\n上课时间：${time}`);
    }
</script>
</body>
</html>
