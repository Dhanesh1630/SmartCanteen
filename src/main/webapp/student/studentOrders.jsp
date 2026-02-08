<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.util.DBConnection" %>
<%@ page import="com.model.User" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Orders - Smart Canteen</title>

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

    .message {
        text-align: center;
        padding: 15px 20px;
        border-radius: 12px;
        margin-bottom: 30px;
        max-width: 500px;
        margin-left: auto;
        margin-right: auto;
        font-weight: 600;
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

    .msgSuccess {
        background: rgba(76, 175, 80, 0.95);
        color: white;
    }

    .msgError {
        background: rgba(244, 67, 54, 0.95);
        color: white;
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
        max-width: 1200px;
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

    .action-cell {
        text-align: center;
    }

    .cancel-btn {
        padding: 8px 14px;
        background: linear-gradient(135deg, #ff6b6b 0%, #ee5a6f 100%);
        color: white;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        text-decoration: none;
        font-size: 13px;
        font-weight: 600;
        transition: all 0.3s ease;
        display: inline-block;
        box-shadow: 0 2px 8px rgba(255, 107, 107, 0.2);
    }

    .cancel-btn:hover {
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(255, 107, 107, 0.3);
    }

    .not-allowed {
        padding: 8px 14px;
        background: #ccc;
        color: #666;
        border-radius: 6px;
        font-size: 13px;
        font-weight: 600;
        display: inline-block;
        cursor: not-allowed;
    }

    .price {
        color: #f5576c;
        font-weight: 600;
    }

    .quantity {
        font-weight: 600;
        color: #667eea;
    }

    .error-message {
        background: rgba(244, 67, 54, 0.95);
        color: white;
        padding: 15px 20px;
        border-radius: 12px;
        text-align: center;
    }

    .empty-state {
        text-align: center;
        padding: 40px;
        color: #666;
        font-size: 16px;
    }

    @media (max-width: 1024px) {
        th, td {
            padding: 12px;
            font-size: 13px;
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

        .action-buttons {
            flex-direction: column;
            align-items: stretch;
        }

        .action-btn {
            width: 100%;
            text-align: center;
        }
    }
</style>

</head>
<body>

<%
    User user = (User) session.getAttribute("user");

    // Only student can access
    if(user == null || !user.getRole().equalsIgnoreCase("student")){
        response.sendRedirect("../login.jsp");
        return;
    }

    String msg = request.getParameter("msg");
    if(msg != null){
        if(msg.equals("cancelled")){
%>
            <div class="message msgSuccess">✅ Order Cancelled Successfully!</div>
<%
        } else if(msg.equals("notallowed")){
%>
            <div class="message msgError">❌ You cannot cancel this order (Already Accepted by Admin).</div>
<%
        }
        else if(msg.equals("alreadycancelled")){
%>
            <div class="message msgError">⚠️ This order is already cancelled.</div>
<%
        }
    }
%>

<div class="header">
    <h1>🧾 My Orders</h1>
</div>

<div class="action-buttons">
    <a href="../studentMenu.jsp" class="action-btn back-btn">⬅ Back to Menu</a>
    <a href="../LogoutServlet" class="action-btn logout-btn">🚪 Logout</a>
</div>

<div class="table-container">
    <table>
        <thead>
            <tr>
                <th>Order ID</th>
                <th>Order Date</th>
                <th>Item Name</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Total Price</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
<%
    try {
        Connection con = DBConnection.getConnection();

        PreparedStatement ps = con.prepareStatement(
            "SELECT o.order_id, o.order_date, o.status, m.item_name, m.price, oi.quantity, oi.total_price " +
            "FROM orders o " +
            "JOIN order_items oi ON o.order_id = oi.order_id " +
            "JOIN menu_items m ON oi.item_id = m.item_id " +
            "WHERE o.user_id=? AND o.status!='Cancelled' " +
            "ORDER BY o.order_id DESC"
        );

        ps.setInt(1, user.getUserId());
        ResultSet rs = ps.executeQuery();

        boolean hasOrders = false;

        while(rs.next()) {
            hasOrders = true;
            String status = rs.getString("status");
            String statusClass = "status-" + status.toLowerCase().replace(" ", "-");
%>
            <tr>
                <td><strong>#<%= rs.getInt("order_id") %></strong></td>
                <td><%= rs.getTimestamp("order_date") %></td>
                <td><strong><%= rs.getString("item_name") %></strong></td>
                <td class="price">₹<%= String.format("%.2f", rs.getDouble("price")) %></td>
                <td class="quantity"><%= rs.getInt("quantity") %> units</td>
                <td class="price">₹<%= String.format("%.2f", rs.getDouble("total_price")) %></td>
                <td><span class="status-badge <%= statusClass %>"><%= status %></span></td>
                <td class="action-cell">
                    <% if(rs.getString("status").equalsIgnoreCase("Pending")) { %>
                        <a class="cancel-btn" href="../CancelOrderServlet?orderId=<%= rs.getInt("order_id") %>" onclick="return confirm('Are you sure you want to cancel this order?');">
                            🗑 Cancel
                        </a>
                    <% } else { %>
                        <span class="not-allowed">✓ Cannot Cancel</span>
                    <% } %>
                </td>
            </tr>
<%
        }

        if(!hasOrders) {
%>
            <tr>
                <td colspan="8" class="empty-state">📭 No Active Orders</td>
            </tr>
<%
        }

    } catch(Exception e) {
        out.println("<tr><td colspan='8'><div class='error-message'>❌ Error Fetching Orders!</div></td></tr>");
        e.printStackTrace();
    }
%>
        </tbody>
    </table>
</div>

</body>
</html>
