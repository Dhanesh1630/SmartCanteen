<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.util.DBConnection" %>
<%@ page import="com.model.User" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Daily Report - Smart Canteen</title>

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

    .stats-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
        gap: 20px;
        max-width: 1200px;
        margin: 0 auto 40px;
    }

    .stat-card {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 15px;
        padding: 25px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        border: 1px solid rgba(255, 255, 255, 0.3);
        text-align: center;
        animation: slideUp 0.6s ease-out;
    }

    @keyframes slideUp {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .stat-icon {
        font-size: 32px;
        margin-bottom: 12px;
    }

    .stat-label {
        color: #666;
        font-size: 13px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-bottom: 8px;
    }

    .stat-value {
        font-size: 32px;
        font-weight: 700;
        color: #667eea;
    }

    .table-section {
        max-width: 1200px;
        margin: 0 auto 40px;
    }

    .section-title {
        color: white;
        font-size: 26px;
        font-weight: 700;
        margin-bottom: 20px;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
    }

    .table-container {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        border: 1px solid rgba(255, 255, 255, 0.3);
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    thead {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    }

    th {
        color: white;
        padding: 16px;
        text-align: left;
        font-weight: 600;
        border-bottom: 2px solid rgba(0, 0, 0, 0.1);
    }

    td {
        padding: 14px 16px;
        border-bottom: 1px solid #f0f0f0;
        color: #333;
    }

    tbody tr {
        transition: all 0.3s ease;
    }

    tbody tr:hover {
        background: rgba(102, 126, 234, 0.05);
    }

    tbody tr:last-child td {
        border-bottom: none;
    }

    .currency {
        color: #f5576c;
        font-weight: 600;
    }

    .quantity {
        font-weight: 600;
        color: #667eea;
    }

    .no-data {
        text-align: center;
        padding: 40px;
        color: #666;
        font-size: 16px;
    }

    .error-message {
        background: rgba(244, 67, 54, 0.95);
        color: white;
        padding: 15px 20px;
        border-radius: 12px;
        text-align: center;
        margin-bottom: 30px;
    }

    .action-buttons {
        display: flex;
        justify-content: center;
        gap: 12px;
        margin-top: 40px;
        flex-wrap: wrap;
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

    .back-btn {
        background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        color: white;
    }

    .back-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 20px rgba(79, 172, 254, 0.4);
    }

    @media (max-width: 768px) {
        .header h1 {
            font-size: 28px;
        }

        .stat-card {
            padding: 20px;
        }

        .stat-value {
            font-size: 24px;
        }

        table {
            font-size: 13px;
        }

        th, td {
            padding: 12px;
        }
    }
</style>

</head>
<body>

<%
    User user = (User) session.getAttribute("user");

    // Redirect to admin login if session not found
    if(user == null){
        response.sendRedirect(request.getContextPath() + "/admin/adminLogin.jsp");
        return;
    }

    // Role check
    if(user.getRole() == null || !user.getRole().trim().equalsIgnoreCase("admin")){
        out.println("<div class='error-message'>🚫 Access Denied! Admin Only.</div>");
        return;
    }
%>

<div class="header">
    <h1>📊 Daily Sales Report</h1>
</div>

<!-- SUMMARY STATS -->
<div class="stats-container">
<%
    try{
        Connection con = DBConnection.getConnection();

        // Total orders today
        PreparedStatement ps1 = con.prepareStatement(
            "SELECT COUNT(*) FROM orders WHERE DATE(order_date)=CURDATE()"
        );
        ResultSet rs1 = ps1.executeQuery();
        rs1.next();
        int totalOrders = rs1.getInt(1);

        // Delivered orders today
        PreparedStatement ps2 = con.prepareStatement(
            "SELECT COUNT(*) FROM orders WHERE DATE(order_date)=CURDATE() AND status='Delivered'"
        );
        ResultSet rs2 = ps2.executeQuery();
        rs2.next();
        int deliveredOrders = rs2.getInt(1);

        // Total amount received today (only delivered)
        PreparedStatement ps3 = con.prepareStatement(
            "SELECT SUM(oi.total_price) " +
            "FROM order_items oi " +
            "JOIN orders o ON oi.order_id=o.order_id " +
            "WHERE DATE(o.order_date)=CURDATE() AND o.status='Delivered'"
        );
        ResultSet rs3 = ps3.executeQuery();
        rs3.next();
        double totalAmount = rs3.getDouble(1);

        if(totalAmount == 0){
            totalAmount = 0.0;
        }
%>

    <div class="stat-card">
        <div class="stat-icon">📦</div>
        <div class="stat-label">Total Orders</div>
        <div class="stat-value"><%= totalOrders %></div>
    </div>

    <div class="stat-card">
        <div class="stat-icon">✅</div>
        <div class="stat-label">Delivered Orders</div>
        <div class="stat-value"><%= deliveredOrders %></div>
    </div>

    <div class="stat-card">
        <div class="stat-icon">💰</div>
        <div class="stat-label">Total Revenue</div>
        <div class="stat-value" style="color: #f5576c;">₹<%= String.format("%.2f", totalAmount) %></div>
    </div>

<%
    }catch(Exception e){
        out.println("<div class='error-message'>❌ Error Loading Summary Report</div>");
        e.printStackTrace();
    }
%>
</div>

<!-- ITEM WISE TABLE -->
<div class="table-section">
    <h2 class="section-title">📈 Item-wise Delivery Report</h2>
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Item Name</th>
                    <th>Price</th>
                    <th>Quantity Delivered</th>
                    <th>Total Revenue</th>
                </tr>
            </thead>
            <tbody>
<%
    try{
        Connection con = DBConnection.getConnection();

        PreparedStatement ps = con.prepareStatement(
            "SELECT m.item_name, m.price, SUM(oi.quantity) AS total_qty, SUM(oi.total_price) AS revenue " +
            "FROM order_items oi " +
            "JOIN orders o ON oi.order_id=o.order_id " +
            "JOIN menu_items m ON oi.item_id=m.item_id " +
            "WHERE DATE(o.order_date)=CURDATE() AND o.status='Delivered' " +
            "GROUP BY m.item_id " +
            "ORDER BY revenue DESC"
        );

        ResultSet rs = ps.executeQuery();
        boolean found = false;

        while(rs.next()){
            found = true;
%>
                <tr>
                    <td><strong><%= rs.getString("item_name") %></strong></td>
                    <td class="currency">₹<%= String.format("%.2f", rs.getDouble("price")) %></td>
                    <td class="quantity"><%= rs.getInt("total_qty") %> units</td>
                    <td class="currency">₹<%= String.format("%.2f", rs.getDouble("revenue")) %></td>
                </tr>
<%
        }

        if(!found){
%>
                <tr>
                    <td colspan="4" class="no-data">📭 No Delivered Orders Today</td>
                </tr>
<%
        }

    }catch(Exception e){
        out.println("<tr><td colspan='4' class='error-message'>❌ Error Loading Item Report</td></tr>");
        e.printStackTrace();
    }
%>
            </tbody>
        </table>
    </div>
</div>

<div class="action-buttons">
    <a class="action-btn back-btn" href="../adminDashboard.jsp">⬅ Back to Dashboard</a>
</div>

</body>
</html>
