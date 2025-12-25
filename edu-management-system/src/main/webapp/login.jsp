<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>校园业务系统 - 登录</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .login-container {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
        }

        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .login-header h1 {
            color: #333;
            margin-bottom: 10px;
            font-size: 28px;
        }

        .login-header p {
            color: #666;
            font-size: 14px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        .form-group input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .btn-login {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .btn-login:active {
            transform: translateY(0);
        }

        .error-message {
            color: #e74c3c;
            text-align: center;
            margin-top: 15px;
            padding: 10px;
            background: #ffeaea;
            border-radius: 6px;
            display: none;
        }

        .user-list {
            margin-top: 20px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .user-list h3 {
            font-size: 14px;
            color: #666;
            margin-bottom: 10px;
        }

        .user-list ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .user-list li {
            padding: 8px;
            border-bottom: 1px solid #eee;
            font-size: 13px;
            color: #555;
        }

        .user-list li:last-child {
            border-bottom: none;
        }

        .user-list strong {
            color: #333;
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="login-header">
        <h1>校园业务系统</h1>
        <p>快速访问校园管理业务系统，一站式服务学习、工作性互动需求</p>
    </div>

    <form action="login" method="POST">
        <div class="form-group">
            <label for="username">用户名</label>
            <input type="text" id="username" name="username" placeholder="请输入用户名" required>
        </div>

        <div class="form-group">
            <label for="password">密码</label>
            <input type="password" id="password" name="password" placeholder="请输入密码" required>
        </div>

        <button type="submit" class="btn-login">登录</button>
    </form>

    <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="error-message" style="display: block;">
        <%= request.getAttribute("errorMessage") %>
    </div>
    <% } %>

    <div class="user-list">
        <h3>测试用户账号 (密码都是: password123)</h3>
        <ul>
            <li><strong>张三</strong> - 用户名: zhangsan</li>
            <li><strong>李四</strong> - 用户名: lisi</li>
            <li><strong>王五</strong> - 用户名: wangwu</li>
            <li><strong>赵六</strong> - 用户名: zhaoliu</li>
        </ul>
    </div>
</div>

<script>
    // 简单的表单验证
    document.querySelector('form').addEventListener('submit', function(e) {
        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value.trim();

        if (!username || !password) {
            e.preventDefault();
            alert('请填写用户名和密码！');
        }
    });
</script>
</body>
</html>