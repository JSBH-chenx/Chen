<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.management.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VPN服务 - 校园业务系统</title>
    <link rel="stylesheet" href="../css/style.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
        }

        .container {
            max-width: 800px;
            margin: 50px auto;
            padding: 40px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h1 {
            color: #333;
            margin-bottom: 20px;
            font-size: 32px;
        }

        .subtitle {
            color: #666;
            font-size: 18px;
            margin-bottom: 30px;
        }

        .module-content {
            background: #f8f9fa;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 30px;
            text-align: left;
        }

        .module-content h2 {
            color: #667eea;
            margin-bottom: 15px;
            font-size: 24px;
        }

        .module-content p {
            color: #555;
            line-height: 1.6;
            margin-bottom: 15px;
            font-size: 16px;
        }

        .feature-list {
            list-style: none;
            margin: 20px 0;
        }

        .feature-list li {
            padding: 10px 0;
            border-bottom: 1px solid #eee;
            color: #666;
        }

        .feature-list li:before {
            content: "✓";
            color: #10b981;
            margin-right: 10px;
            font-weight: bold;
        }

        .back-btn {
            display: inline-block;
            background: #667eea;
            color: white;
            padding: 12px 30px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 16px;
            font-weight: 500;
            transition: background 0.3s;
        }

        .back-btn:hover {
            background: #5a67d8;
        }

        .status-indicator {
            display: inline-block;
            padding: 8px 16px;
            background: #d1fae5;
            color: #065f46;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
            margin-top: 20px;
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

        .logo h2 {
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
    </style>
</head>
<body>
<div class="header">
    <div class="header-content">
        <div class="logo">
            <h2>VPN服务模块</h2>
        </div>
        <div class="nav-buttons">
            <a href="../main.jsp" class="nav-btn">返回主页</a>
            <a href="../logout" class="nav-btn">退出登录</a>
        </div>
    </div>
</div>

<div class="container">
    <h1>VPN服务</h1>
    <p class="subtitle">财务信息管理系统（IP）的用户界面是透明化</p>

    <div class="module-content">
        <h2>VPN服务概览</h2>
        <p>子分布的数据显示，业务系统的行为在数据库中。我们的VPN服务提供安全、稳定的网络连接，确保您能够随时随地访问校园内部资源。</p>

        <h3>主要功能</h3>
        <ul class="feature-list">
            <li>安全加密的网络连接</li>
            <li>远程访问校园内部系统</li>
            <li>多设备同时连接支持</li>
            <li>实时流量监控</li>
            <li>连接日志记录</li>
        </ul>

        <h3>使用说明</h3>
        <p>VPN服务目前处于展示阶段，具体功能将在后续版本中实现。您可以通过校园网认证系统获取VPN访问权限。</p>

        <h3>连接状态</h3>
        <p>当前用户：<strong><%= user.getName() %></strong> (<%= user.getUsername() %>)</p>
        <p>连接时间：<span id="current-time"></span></p>
    </div>

    <div class="status-indicator">展示模块 - 功能开发中</div>
    <br><br>
    <a href="../main.jsp" class="back-btn">返回主页面</a>
</div>

<script>
    // 显示当前时间
    function updateTime() {
        const now = new Date();
        const timeString = now.toLocaleString('zh-CN', {
            year: 'numeric',
            month: '2-digit',
            day: '2-digit',
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit'
        });
        document.getElementById('current-time').textContent = timeString;
    }

    // 每秒更新时间
    updateTime();
    setInterval(updateTime, 1000);

    // 模拟VPN连接状态
    let isConnected = false;

    function toggleConnection() {
        isConnected = !isConnected;
        const statusText = isConnected ? '已连接' : '已断开';
        const buttonText = isConnected ? '断开连接' : '连接VPN';
        alert(`VPN ${statusText}`);
    }
</script>
</body>
</html>