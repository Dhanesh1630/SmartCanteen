<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login - Smart Canteen</title>

<style>
    body {
        margin: 0;
        padding: 0;
        font-family: Arial, sans-serif;
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        background: linear-gradient(to right, #141E30, #243B55);
    }

    .container {
        width: 400px;
        padding: 35px;
        border-radius: 15px;
        background: rgba(255, 255, 255, 0.12);
        box-shadow: 0px 8px 25px rgba(0, 0, 0, 0.4);
        backdrop-filter: blur(12px);
        text-align: center;
        color: white;
    }

    h2 {
        margin-bottom: 10px;
        font-size: 26px;
        color: orange;
    }

    p {
        margin-bottom: 25px;
        font-size: 14px;
        opacity: 0.85;
    }

    input {
        width: 90%;
        padding: 12px;
        margin: 10px 0;
        border: none;
        outline: none;
        border-radius: 8px;
        font-size: 14px;
    }

    input:focus {
        border: 2px solid orange;
    }

    button {
        width: 95%;
        padding: 12px;
        margin-top: 15px;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        background: orange;
        color: black;
        transition: 0.3s;
    }

    button:hover {
        background: black;
        color: white;
        transform: scale(1.03);
    }

    .back {
        display: inline-block;
        margin-top: 15px;
        padding: 8px 15px;
        background: rgba(0,0,0,0.4);
        border-radius: 8px;
        color: white;
        text-decoration: none;
        font-size: 13px;
        transition: 0.3s;
    }

    .back:hover {
        background: black;
    }
</style>

</head>
<body>

<div class="container">
    <h2>🔐 Admin Login</h2>
    <p>Login to manage orders and users</p>

    <form action="LoginServlet" method="post">

        <input type="email" name="email" placeholder="Enter Admin Email" required>

        <input type="password" name="password" placeholder="Enter Admin Password" required>

        <button type="submit">Login as Admin</button>

    </form>

    <a class="back" href="index.jsp">⬅ Back to Home</a>
</div>

</body>
</html>
