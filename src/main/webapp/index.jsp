<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Smart Canteen - Home</title>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        text-align: center;
    }

    .container {
        width: 100%;
        max-width: 700px;
        padding: 40px;
    }

    .box {
        padding: 60px 40px;
        border-radius: 20px;
        background: rgba(255, 255, 255, 0.1);
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
        backdrop-filter: blur(15px);
        border: 1px solid rgba(255, 255, 255, 0.2);
        animation: slideUp 0.6s ease-out;
    }

    @keyframes slideUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    h1 {
        font-size: 48px;
        margin-bottom: 15px;
        font-weight: 700;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
    }

    h3 {
        font-size: 18px;
        font-weight: 300;
        opacity: 0.95;
        margin-bottom: 40px;
        letter-spacing: 0.5px;
    }

    .button-group {
        display: flex;
        flex-wrap: wrap;
        gap: 15px;
        justify-content: center;
        margin-bottom: 30px;
    }

    .btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        padding: 14px 28px;
        border-radius: 12px;
        text-decoration: none;
        font-size: 16px;
        font-weight: 600;
        transition: all 0.3s ease;
        border: 2px solid transparent;
        cursor: pointer;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
    }

    .student-login {
        background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        color: white;
    }

    .student-login:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 20px rgba(245, 87, 108, 0.4);
    }

    .student-register {
        background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        color: white;
    }

    .student-register:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 20px rgba(79, 172, 254, 0.4);
    }

    .admin {
        background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
        color: #333;
        width: 100%;
    }

    .admin:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 20px rgba(250, 112, 154, 0.4);
    }

    .footer {
        margin-top: 30px;
        font-size: 13px;
        opacity: 0.85;
        letter-spacing: 0.3px;
    }

    @media (max-width: 600px) {
        .box {
            padding: 40px 25px;
        }
        
        h1 {
            font-size: 36px;
        }
        
        .button-group {
            flex-direction: column;
        }
        
        .btn {
            width: 100%;
        }
    }
</style>

</head>
<body>

<div class="container">
    <div class="box">
        <h1>🍔 Smart Canteen System</h1>
        <h3>Order food online • Skip long queues • Save time</h3>

        <div class="button-group">
            <a class="btn student-login" href="login.jsp">👨‍🎓 Student Login</a>
            <a class="btn student-register" href="register.jsp">📝 Register</a>
        </div>

        <a class="btn admin" href="admin/adminLogin.jsp">👨‍💼 Admin Login</a>

        <div class="footer">
            <p>🚀 Java Full Stack Project Developed by CSE Students</p>
    </div>
</div>

</body>
</html>
<!-- create a modern navbar with dark theme -->

