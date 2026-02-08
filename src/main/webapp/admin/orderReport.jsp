<%@ page import="java.sql.*" %>
<%@ page import="com.util.DBConnection" %>
<%@ page import="com.model.User" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Daily Order Report</title>

<style>
    body{
        font-family: Arial;
        background:#f4f4f4;
        padding:20px;
    }
    h2{
        text-align:center;
        color:darkblue;
    }
    .card{
        width:60%;
        margin:auto;
        padding:25px;
        background:white;
        border-radius:12px;
        box-shadow:0px 6px 15px rgba(0,0,0,0.2);
    }
    .box{
        padding:12px;
        margin:12px 0;
        background:#e8f0ff;
        border-left:6px solid darkblue;
        border-radius:8px;
        font-size:18px;
        font-weight:bold;
    }
    a{
        text-decoration:none;
        padding:10px 18px;
        background:orange;
        color:black;
        border-radius:8px;
        font-weight:bold;
    }
    a:hover{
        background:black;
        color:white;
    }
</style>
</head>

<body>

<%
    User user = (User) session.getAttribute("user");

    if(user == null || !user.getRole().equalsIgnoreCase("admin")){
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<h2>📊 Daily Orders Report</h2>

<div class="card">

<%
    try{
        Connection con = DBConnection.getConnection();

        // Total Orders Today
        PreparedStatement ps1 = con.prepareStatement(
            "SELECT COUNT(*) FROM orders WHERE DATE(order_date)=CURDATE()"
        );
        ResultSet rs1 = ps1.executeQuery();
        rs1.next();
        int totalOrders = rs1.getInt(1);

        // Cancelled Orders Today
        PreparedStatement ps2 = con.prepareStatement(
            "SELECT COUNT(*) FROM orders WHERE DATE(order_date)=CURDATE() AND status='Cancelled'"
        );
        ResultSet rs2 = ps2.executeQuery();
        rs2.next();
        int cancelledOrders = rs2.getInt(1);

        // Delivered Orders Today
        PreparedStatement ps3 = con.prepareStatement(
            "SELECT COUNT(*) FROM orders WHERE DATE(order_date)=CURDATE() AND status='Delivered'"
        );
        ResultSet rs3 = ps3.executeQuery();
        rs3.next();
        int deliveredOrders = rs3.getInt(1);

        // Total Amount Received Today (Delivered Only)
        PreparedStatement ps4 = con.prepareStatement(
            "SELECT SUM(total_price) FROM order_items oi " +
            "JOIN orders o ON oi.order_id=o.order_id " +
            "WHERE DATE(o.order_date)=CURDATE() AND o.status='Delivered'"
        );
        ResultSet rs4 = ps4.executeQuery();
        rs4.next();
        double totalAmount = rs4.getDouble(1);
%>

    <div class="box">📌 Total Orders Today: <%= totalOrders %></div>
    <div class="box">❌ Cancelled Orders Today: <%= cancelledOrders %></div>
    <div class="box">✅ Delivered Orders Today: <%= deliveredOrders %></div>
    <div class="box">💰 Total Amount Received Today: ₹ <%= totalAmount %></div>

<%
    }catch(Exception e){
        out.println("<h3 style='color:red;'>Error Loading Report!</h3>");
        e.printStackTrace();
    }
%>

<center>
    <br>
    <a href="../adminDashboard.jsp">⬅ Back to Dashboard</a>
</center>

</div>

</body>
</html>
