<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.management.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>校园业务系统 - 主页</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        /* 使用之前提供的完整CSS样式 */
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
            position: sticky;
            top: 0;
            z-index: 1000;
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

        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #667eea;
            font-weight: bold;
            font-size: 18px;
        }

        .user-details {
            text-align: right;
        }

        .user-name {
            font-weight: 600;
            font-size: 16px;
        }

        .user-role {
            font-size: 12px;
            opacity: 0.8;
            margin-top: 2px;
        }

        .logout-btn {
            background: rgba(255, 255, 255, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.3s;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
        }

        .logout-btn:hover {
            background: rgba(255, 255, 255, 0.3);
        }

        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .welcome-section {
            background: white;
            border-radius: 12px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .welcome-title {
            font-size: 24px;
            color: #333;
            margin-bottom: 10px;
        }

        .welcome-subtitle {
            color: #666;
            font-size: 16px;
        }

        .modules-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
            margin-top: 20px;
        }

        .module-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s, box-shadow 0.3s;
            cursor: pointer;
            border: 1px solid #eee;
        }

        .module-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        }

        .module-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
        }

        .module-header h3 {
            font-size: 18px;
            margin-bottom: 5px;
        }

        .module-header p {
            font-size: 12px;
            opacity: 0.9;
        }

        .module-content {
            padding: 20px;
        }

        .module-content p {
            color: #666;
            font-size: 14px;
            line-height: 1.6;
        }

        .module-actions {
            padding: 15px 20px 20px;
            border-top: 1px solid #eee;
            text-align: right;
        }

        .btn-module {
            background: #667eea;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            transition: background 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .btn-module:hover {
            background: #5a67d8;
        }

        .btn-module.secondary {
            background: #48bb78;
        }

        .btn-module.secondary:hover {
            background: #38a169;
        }

        .footer {
            text-align: center;
            padding: 30px;
            color: #666;
            font-size: 14px;
            border-top: 1px solid #eee;
            margin-top: 50px;
        }

        @media (max-width: 768px) {
            .modules-grid {
                grid-template-columns: 1fr;
            }

            .header-content {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }

            .user-info {
                flex-direction: column;
                text-align: center;
            }

            .user-details {
                text-align: center;
            }
        }
    </style>
</head>
<body>
<div class="header">
    <div class="header-content">
        <div class="logo">
            <h1>校园业务系统</h1>
            <p>快速访问校园管理业务系统，一站式服务学习、工作性互动需求</p>
        </div>

        <div class="user-info">
            <div class="user-avatar">
                <%= user.getName().charAt(0) %>
            </div>
            <div class="user-details">
                <div class="user-name"><%= user.getName() %></div>
                <div class="user-role"><%= user.getRole() %></div>
            </div>
            <a href="logout" class="logout-btn">退出登录</a>
        </div>
    </div>
</div>

<div class="container">
    <div class="welcome-section">
        <h1 class="welcome-title">欢迎回来，<%= user.getName() %>！</h1>
        <p class="welcome-subtitle">请选择您要使用的系统模块</p>
    </div>

    <div class="modules-grid">
        <!-- VPN服务 -->
        <div class="module-card" onclick="showModuleInfo('VPN服务')">
            <div class="module-header">
                <h3>VPN服务</h3>
                <p>财务信息管理系统（IP）的用户界面是透明化</p>
            </div>
            <div class="module-content">
                <p>子分布的数据显示，业务系统的行为在数据库中。</p>
            </div>
            <div class="module-actions">
                <a href="modules/vpn.jsp" class="btn-module" onclick="event.stopPropagation()">
                    进入系统
                </a>
            </div>
        </div>

        <!-- 财务收费系统 -->
        <div class="module-card" onclick="showModuleInfo('财务收费系统')">
            <div class="module-header">
                <h3>财务收费系统</h3>
                <p>财务数据系统</p>
            </div>
            <div class="module-content">
                <p>服务于特定的客户管理平台，包括流量、流量模块、终端管理功能。</p>
            </div>
            <div class="module-actions">
                <a href="modules/finance.jsp" class="btn-module" onclick="event.stopPropagation()">
                    进入系统
                </a>
            </div>
        </div>

        <!-- 教务管理系统 -->
        <div class="module-card" onclick="showModuleInfo('教务管理系统')">
            <div class="module-header">
                <h3>教务管理系统</h3>
                <p>学生选课与课表管理</p>
            </div>
            <div class="module-content">
                <p>提供学生选课、退课功能，以及个人课表查看功能。</p>
            </div>
            <div class="module-actions">
                <a href="courses" class="btn-module secondary" onclick="event.stopPropagation()">
                    选课/退课
                </a>
                <a href="schedule" class="btn-module" onclick="event.stopPropagation()">
                    查看课表
                </a>
            </div>
        </div>

        <!-- 财务系统 -->
        <div class="module-card" onclick="showModuleInfo('财务系统')">
            <div class="module-header">
                <h3>财务系统</h3>
                <p>网上查询、线上查询、账户分析</p>
            </div>
            <div class="module-content">
                <p>网上查询、线上查询、账户分析等流程，提供内部反馈。</p>
            </div>
            <div class="module-actions">
                <a href="modules/finance_system.jsp" class="btn-module" onclick="event.stopPropagation()">
                    进入系统
                </a>
            </div>
        </div>

        <!-- 网络教学平台 -->
        <div class="module-card" onclick="showModuleInfo('网络教学平台')">
            <div class="module-header">
                <h3>网络教学平台</h3>
                <p>在线学习与互动</p>
            </div>
            <div class="module-content">
                <p>网络教学平台通过互联网进行开发，支持在线学习与互动。</p>
            </div>
            <div class="module-actions">
                <a href="modules/network_teaching.jsp" class="btn-module" onclick="event.stopPropagation()">
                    进入系统
                </a>
            </div>
        </div>

        <!-- 学生离校系统 -->
        <div class="module-card" onclick="showModuleInfo('学生离校系统')">
            <div class="module-header">
                <h3>学生离校系统</h3>
                <p>班主任系统</p>
            </div>
            <div class="module-content">
                <p>本科生、研究生学生家长共享一对一培训服务。</p>
            </div>
            <div class="module-actions">
                <a href="modules/leave_school.jsp" class="btn-module" onclick="event.stopPropagation()">
                    进入系统
                </a>
            </div>
        </div>
    </div>
</div>

<div class="footer">
    <p>© 2024 校园信息化 | 技术支持：移动办公云</p>
</div>

<script>
    function showModuleInfo(moduleName) {
        alert(`您选择了 ${moduleName}\n\n此模块${moduleName == '教务管理系统' ? '提供选课退课和课表查看功能' : '为展示模块，具体功能暂未实现'}`);
    }
</script>
</body>
</html>