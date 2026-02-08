<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.util.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Orders - Smart Canteen</title>

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
        margin-bottom: 30px;
    }

    .header h1 {
        font-size: 32px;
        margin-bottom: 15px;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
    }

    .action-buttons {
        display: flex;
        gap: 12px;
        justify-content: center;
        margin-bottom: 30px;
        flex-wrap: wrap;
    }

    .action-btn {
        padding: 12px 24px;
        border: none;
        border-radius: 8px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        text-decoration: none;
        transition: all 0.3s ease;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    }

    .back-btn {
        background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        color: white;
    }

    .back-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 16px rgba(79, 172, 254, 0.3);
    }

    .logout-btn {
        background: linear-gradient(135deg, #ff6b6b 0%, #ee5a6f 100%);
        color: white;
    }

    .logout-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 16px rgba(255, 107, 107, 0.3);
    }

    .table-container {
        max-width: 1300px;
        margin: 0 auto;
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

    .status-form {
        display: flex;
        gap: 8px;
        align-items: center;
    }

    select {
        padding: 8px 12px;
        border: 2px solid #e0e0e0;
        border-radius: 6px;
        font-size: 13px;
        background: white;
        color: #333;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    select:focus {
        outline: none;
        border-color: #667eea;
        box-shadow: 0 0 8px rgba(102, 126, 234, 0.2);
    }

    .update-btn {
        padding: 8px 16px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-size: 13px;
        font-weight: 600;
        transition: all 0.3s ease;
        box-shadow: 0 2px 8px rgba(102, 126, 234, 0.2);
    }

    .update-btn:hover {
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
    }

    .status-badge {
        display: inline-block;
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 600;
        text-transform: capitalize;
    }

    .status-pending {
        background: rgba(255, 152, 0, 0.2);
        color: #e65100;
    }

    .status-accepted {
        background: rgba(76, 175, 80, 0.2);
        color: #2e7d32;
    }

    .status-preparing {
        background: rgba(33, 150, 243, 0.2);
        color: #0d47a1;
    }

    .status-ready {
        background: rgba(156, 39, 176, 0.2);
        color: #6a1b9a;
    }

    .status-delivered {
        background: rgba(76, 175, 80, 0.2);
        color: #2e7d32;
    }

    .error-message {
        background: rgba(244, 67, 54, 0.95);
        color: white;
        padding: 15px 20px;
        border-radius: 12px;
        text-align: center;
        margin-bottom: 30px;
    }

    .price {
        font-weight: 600;
        color: #f5576c;
    }

    .id-column {
        font-weight: 600;
        color: #667eea;
    }

    @media (max-width: 1024px) {
        th, td {
            padding: 12px;
            font-size: 13px;
        }

        .status-form {
            flex-direction: column;
        }

        select,
        .update-btn {
            width: 100%;
        }
    }

    @media (max-width: 768px) {
        .header h1 {
            font-size: 24px;
        }

        table {
            font-size: 12px;
        }

        th, td {
            padding: 10px;
        }

        .status-form {
            flex-direction: column;
        }

        select,
        .update-btn {
            width: 100%;
        }
    }
</style>

</head>
<body>

<div class="header">
    <h1>📦 All Orders Management</h1>
</div>

<div class="action-buttons">
    <a href="../adminDashboard.jsp" class="action-btn back-btn">⬅ Back to Dashboard</a>
    <a href="../LogoutServlet" class="action-btn logout-btn">🚪 Logout</a>
</div>

<div class="table-container">
    <table>
        <thead>
            <tr>
                <th>Order ID</th>
                <th>User ID</th>
                <th>Order Date</th>
                <th>Item Name</th>
                <th>Price</th>
                <th>Status</th>
                <th>Update Status</th>
            </tr>
        </thead>
        <tbody>
<%
    try {
        Connection con = DBConnection.getConnection();
        Statement st = con.createStatement();

        ResultSet rs = st.executeQuery(
            "SELECT o.order_id, o.user_id, o.order_date, o.status, " +
            "m.item_name, m.price, oi.quantity, oi.total_price " +
            "FROM orders o " +
            "JOIN order_items oi ON o.order_id = oi.order_id " +
            "JOIN menu_items m ON oi.item_id = m.item_id " +
            "WHERE o.status!='Cancelled' " +
            "ORDER BY o.order_id DESC"
        );

        while(rs.next()) {
            String status = rs.getString("status");
            String statusClass = "status-" + status.toLowerCase().replace(" ", "-");
%>
            <tr>
                <td><span class="id-column">#<%= rs.getInt("order_id") %></span></td>
                <td><strong><%= rs.getInt("user_id") %></strong></td>
                <td><%= rs.getTimestamp("order_date") %></td>
                <td><strong><%= rs.getString("item_name") %></strong></td>
                <td class="price">₹<%= rs.getDouble("price") %></td>
                <td><span class="status-badge <%= statusClass %>"><%= status %></span></td>
                <td>
                    <form action="../UpdateOrderStatusServlet" method="post" class="status-form">
                        <input type="hidden" name="orderId" value="<%= rs.getInt("order_id") %>">
                        <select name="status" required>
                            <option value="Pending" <%= "Pending".equals(status) ? "selected" : "" %>>Pending</option>
                            <option value="Accepted" <%= "Accepted".equals(status) ? "selected" : "" %>>Accepted</option>
                            <option value="Preparing" <%= "Preparing".equals(status) ? "selected" : "" %>>Preparing</option>
                            <option value="Ready" <%= "Ready".equals(status) ? "selected" : "" %>>Ready</option>
                            <option value="Delivered" <%= "Delivered".equals(status) ? "selected" : "" %>>Delivered</option>
                        </select>
                        <button type="submit" class="update-btn">✓ Update</button>
                    </form>
                </td>
            </tr>
<%
        }
    } catch(Exception e) {
        out.println("<tr><td colspan='7'><div class='error-message'>❌ Error Fetching Orders!</div></td></tr>");
        e.printStackTrace();
    }
%>
        </tbody>
    </table>
</div>

</body>
</html>
