<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Register - Smart Canteen</title>

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
    }

    .container {
        width: 100%;
        max-width: 420px;
        padding: 40px;
    }

    .card {
        padding: 45px;
        border-radius: 20px;
        background: rgba(255, 255, 255, 0.1);
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
        backdrop-filter: blur(15px);
        border: 1px solid rgba(255, 255, 255, 0.2);
        text-align: center;
        color: white;
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

    h2 {
        margin-bottom: 8px;
        font-size: 28px;
        font-weight: 700;
    }

    .subtitle {
        margin-bottom: 30px;
        font-size: 14px;
        opacity: 0.85;
        letter-spacing: 0.3px;
    }

    .form-group {
        margin-bottom: 18px;
    }

    input {
        width: 100%;
        padding: 14px 16px;
        border: 2px solid rgba(255, 255, 255, 0.3);
        outline: none;
        border-radius: 10px;
        font-size: 14px;
        background: rgba(255, 255, 255, 0.1);
        color: white;
        transition: all 0.3s ease;
    }

    input::placeholder {
        color: rgba(255, 255, 255, 0.7);
    }

    input:focus {
        border-color: rgba(255, 255, 255, 0.8);
        background: rgba(255, 255, 255, 0.15);
        box-shadow: 0 0 10px rgba(255, 255, 255, 0.2);
    }

    button {
        width: 100%;
        padding: 14px;
        margin-top: 10px;
        border: none;
        border-radius: 10px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        color: white;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(79, 172, 254, 0.3);
    }

    button:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(79, 172, 254, 0.4);
    }

    button:active {
        transform: translateY(0);
    }

    .link {
        margin-top: 20px;
        font-size: 14px;
    }

    .link a {
        color: #f093fb;
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s ease;
    }

    .link a:hover {
        color: #f5576c;
        text-decoration: underline;
    }

    .back-btn {
        display: inline-block;
        margin-top: 20px;
        padding: 10px 20px;
        background: rgba(255, 255, 255, 0.2);
        border-radius: 8px;
        color: white;
        text-decoration: none;
        font-size: 13px;
        font-weight: 600;
        transition: all 0.3s ease;
        border: 1px solid rgba(255, 255, 255, 0.3);
    }

    .back-btn:hover {
        background: rgba(255, 255, 255, 0.3);
        transform: translateX(-3px);
    }

    @media (max-width: 480px) {
        .card {
            padding: 35px 25px;
        }
        
        h2 {
            font-size: 24px;
        }
    }
</style>

</head>
<body>

<div class="container">
    <div class="card">
        <h2>📝 Student Registration</h2>
        <p class="subtitle">Create account and start ordering</p>

        <form action="RegisterServlet" method="post">
            <div class="form-group">
                <input type="text" name="name" placeholder="Enter Full Name" required>
            </div>

            <div class="form-group">
                <input type="email" name="email" placeholder="Enter Email" required>
            </div>

            <div class="form-group">
                <input type="password" name="password" placeholder="Create Password" required>
            </div>

            <button type="submit">Register</button>
        </form>

        <div class="link">
            Already have an account? <a href="login.jsp">Login</a>
        </div>

        <a class="back-btn" href="index.jsp">⬅ Back to Home</a>
    </div>
</div>

</body>
</html>
