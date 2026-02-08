<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.util.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Student Menu - Smart Canteen</title>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        padding: 30px 20px;
        min-height: 100vh;
    }

    .header {
        text-align: center;
        color: white;
        margin-bottom: 40px;
    }

    .header h1 {
        font-size: 36px;
        margin-bottom: 10px;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
    }

    .success-message {
        background: rgba(76, 175, 80, 0.95);
        color: white;
        padding: 15px 20px;
        border-radius: 12px;
        text-align: center;
        margin-bottom: 30px;
        max-width: 500px;
        margin-left: auto;
        margin-right: auto;
        box-shadow: 0 4px 15px rgba(76, 175, 80, 0.3);
        animation: slideDown 0.5s ease-out;
    }

    @keyframes slideDown {
        from {
            opacity: 0;
            transform: translateY(-20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .menu-container {
        max-width: 1200px;
        margin: 0 auto;
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 25px;
        margin-bottom: 40px;
    }

    .menu-card {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 15px;
        padding: 25px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
        border: 1px solid rgba(255, 255, 255, 0.3);
        animation: fadeIn 0.6s ease-out;
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .menu-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 12px 40px rgba(0, 0, 0, 0.2);
    }

    .card-header {
        display: flex;
        justify-content: space-between;
        align-items: start;
        margin-bottom: 15px;
    }

    .item-name {
        font-size: 20px;
        font-weight: 700;
        color: #333;
        margin-bottom: 5px;
    }

    .category-badge {
        display: inline-block;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 6px 14px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 600;
        text-transform: capitalize;
    }

    .price {
        font-size: 24px;
        font-weight: 700;
        color: #f5576c;
        margin-bottom: 15px;
    }

    .availability {
        display: inline-block;
        padding: 6px 12px;
        border-radius: 8px;
        font-size: 12px;
        font-weight: 600;
        margin-bottom: 15px;
    }

    .available {
        background: rgba(76, 175, 80, 0.2);
        color: #2e7d32;
    }

    .unavailable {
        background: rgba(244, 67, 54, 0.2);
        color: #c62828;
    }

    .order-btn {
        width: 100%;
        padding: 12px;
        border: none;
        border-radius: 10px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        color: white;
        box-shadow: 0 4px 15px rgba(245, 87, 108, 0.3);
    }

    .order-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(245, 87, 108, 0.4);
    }

    .order-btn:disabled {
        background: #ccc;
        cursor: not-allowed;
        box-shadow: none;
    }

    .actions {
        display: flex;
        gap: 12px;
        justify-content: center;
        flex-wrap: wrap;
        margin-top: 40px;
        padding: 30px;
        background: rgba(255, 255, 255, 0.1);
        border-radius: 15px;
        backdrop-filter: blur(15px);
    }

    .action-btn {
        padding: 14px 28px;
        border: none;
        border-radius: 10px;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
        text-decoration: none;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
    }

    .primary-btn {
        background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        color: white;
    }

    .primary-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 20px rgba(79, 172, 254, 0.4);
    }

    .secondary-btn {
        background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
        color: #333;
    }

    .secondary-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 20px rgba(250, 112, 154, 0.4);
    }

    .home-link {
        display: inline-block;
        margin-top: 20px;
        padding: 10px 20px;
        background: rgba(255, 255, 255, 0.2);
        border-radius: 8px;
        color: white;
        text-decoration: none;
        font-size: 14px;
        font-weight: 600;
        transition: all 0.3s ease;
        border: 1px solid rgba(255, 255, 255, 0.3);
    }

    .home-link:hover {
        background: rgba(255, 255, 255, 0.3);
        transform: translateX(-3px);
    }

    .error-message {
        background: rgba(244, 67, 54, 0.95);
        color: white;
        padding: 15px 20px;
        border-radius: 12px;
        text-align: center;
        margin-bottom: 30px;
        max-width: 500px;
        margin-left: auto;
        margin-right: auto;
    }

    @media (max-width: 768px) {
        .menu-container {
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
        }

        .header h1 {
            font-size: 28px;
        }

        .menu-card {
            padding: 20px;
        }
    }
</style>

</head>
<body>

<div class="header">
    <h1>🍔 Smart Canteen Menu</h1>
</div>

<%
    String msg = request.getParameter("msg");
    if(msg != null && msg.equals("success")) {
%>
    <div class="success-message">
        ✅ Order Placed Successfully! Check your orders below.
    </div>
<%
    }
%>

<div class="menu-container">
<%
    try {
        Connection con = DBConnection.getConnection();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM menu_items");

        while(rs.next()) {
            boolean isAvailable = rs.getString("available").equalsIgnoreCase("yes");
%>
    <div class="menu-card">
        <div class="card-header">
            <div>
                <div class="item-name"><%= rs.getString("item_name") %></div>
                <span class="category-badge"><%= rs.getString("category") %></span>
            </div>
        </div>

        <div class="price">₹ <%= rs.getDouble("price") %></div>

        <span class="availability <%= isAvailable ? "available" : "unavailable" %>">
            <%= isAvailable ? "✓ Available" : "✗ Out of Stock" %>
        </span>

        <% if(isAvailable) { %>
            <a class="order-btn" href="OrderServlet?itemId=<%= rs.getInt("item_id") %>">📦 Order Now</a>
        <% } else { %>
            <button class="order-btn" disabled>Not Available</button>
        <% } %>
    </div>

<%
        }
    } catch(Exception e) {
        out.println("<div class='error-message'>❌ Error Loading Menu! Please try again later.</div>");
        e.printStackTrace();
    }
%>
</div>

<div style="text-align: center;">
    <div class="actions">
        <a href="student/studentOrders.jsp" class="action-btn primary-btn">📦 My Orders</a>
        <a href="LogoutServlet" class="action-btn secondary-btn">🚪 Logout</a>
    </div>

    <a href="index.jsp" class="home-link">🏠 Back to Home</a>
</div>

</body>
</html>
