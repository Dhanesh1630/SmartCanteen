<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.util.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard - Smart Canteen</title>

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

    .quick-actions {
        display: flex;
        flex-wrap: wrap;
        gap: 15px;
        justify-content: center;
        margin-bottom: 40px;
        max-width: 1200px;
        margin-left: auto;
        margin-right: auto;
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

    .add-btn {
        background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        color: white;
    }

    .add-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 20px rgba(79, 172, 254, 0.4);
    }

    .view-btn {
        background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        color: white;
    }

    .view-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 20px rgba(245, 87, 108, 0.4);
    }

    .report-btn {
        background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
        color: #333;
    }

    .report-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 20px rgba(250, 112, 154, 0.4);
    }

    .logout-btn {
        background: linear-gradient(135deg, #ff6b6b 0%, #ee5a6f 100%);
        color: white;
    }

    .logout-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 20px rgba(255, 107, 107, 0.4);
    }

    .menu-section {
        max-width: 1200px;
        margin: 0 auto;
    }

    .section-title {
        color: white;
        font-size: 28px;
        font-weight: 700;
        margin-bottom: 25px;
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

    th {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 18px;
        text-align: left;
        font-weight: 600;
        border-bottom: 2px solid rgba(0, 0, 0, 0.1);
    }

    td {
        padding: 15px 18px;
        border-bottom: 1px solid #f0f0f0;
        color: #333;
    }

    tr:hover {
        background: rgba(102, 126, 234, 0.05);
    }

    tr:last-child td {
        border-bottom: none;
    }

    .delete-btn {
        background: linear-gradient(135deg, #ff6b6b 0%, #ee5a6f 100%);
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 6px;
        cursor: pointer;
        text-decoration: none;
        font-size: 13px;
        font-weight: 600;
        transition: all 0.3s ease;
        display: inline-block;
    }

    .delete-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(255, 107, 107, 0.3);
    }

    .status-available {
        background: rgba(76, 175, 80, 0.2);
        color: #2e7d32;
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 13px;
        font-weight: 600;
    }

    .status-unavailable {
        background: rgba(244, 67, 54, 0.2);
        color: #c62828;
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 13px;
        font-weight: 600;
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

    .category-badge {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 600;
        text-transform: capitalize;
        display: inline-block;
    }

    @media (max-width: 768px) {
        .quick-actions {
            flex-direction: column;
            align-items: stretch;
        }

        .action-btn {
            width: 100%;
            text-align: center;
        }

        table {
            font-size: 13px;
        }

        th, td {
            padding: 12px;
        }

        .header h1 {
            font-size: 28px;
        }
    }
</style>

</head>
<body>

<div class="header">
    <h1>👨‍💼 Admin Dashboard</h1>
</div>

<div class="quick-actions">
    <a class="action-btn add-btn" href="admin/addItem.jsp">➕ Add Menu Item</a>
    <a class="action-btn view-btn" href="admin/viewOrders.jsp">📦 View Orders</a>
    <a class="action-btn report-btn" href="admin/dailyReport.jsp">📊 Daily Report</a>
    <a class="action-btn logout-btn" href="index.jsp">🚪 Logout</a>
</div>

<div class="menu-section">
    <h2 class="section-title">📋 Menu Items List</h2>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Item ID</th>
                    <th>Item Name</th>
                    <th>Price</th>
                    <th>Category</th>
                    <th>Availability</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
<%
    try {
        Connection con = DBConnection.getConnection();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM menu_items");

        while(rs.next()) {
            boolean isAvailable = rs.getString("available").equalsIgnoreCase("yes");
%>
                <tr>
                    <td><strong>#<%= rs.getInt("item_id") %></strong></td>
                    <td><strong><%= rs.getString("item_name") %></strong></td>
                    <td class="price">₹<%= rs.getDouble("price") %></td>
                    <td><span class="category-badge"><%= rs.getString("category") %></span></td>
                    <td>
                        <span class="<%= isAvailable ? "status-available" : "status-unavailable" %>">
                            <%= isAvailable ? "✓ Available" : "✗ Out of Stock" %>
                        </span>
                    </td>
                    <td>
                        <a class="delete-btn" href="<%= request.getContextPath() %>/DeleteItemServlet?id=<%= rs.getInt("item_id") %>" onclick="return confirm('Are you sure you want to delete this item?');">🗑 Delete</a>
                    </td>
                </tr>
<%
        }
    } catch(Exception e) {
        out.println("<tr><td colspan='6'><div class='error-message'>❌ Error Loading Menu Items!</div></td></tr>");
        e.printStackTrace();
    }
%>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
