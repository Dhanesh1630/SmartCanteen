package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.model.User;
import com.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int itemId = Integer.parseInt(request.getParameter("itemId"));

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            Connection con = DBConnection.getConnection();

            // Step 1: Create order
            String orderSql = "INSERT INTO orders(user_id, status) VALUES(?, 'Pending')";
            PreparedStatement ps1 = con.prepareStatement(orderSql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps1.setInt(1, user.getUserId());
            ps1.executeUpdate();

            // Get generated order_id
            java.sql.ResultSet rs = ps1.getGeneratedKeys();
            int orderId = 0;

            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            // Step 2: Insert into order_items (quantity = 1 default)
            String itemSql = "INSERT INTO order_items(order_id, item_id, quantity, total_price) " +
                             "VALUES(?, ?, 1, (SELECT price FROM menu_items WHERE item_id=?))";

            PreparedStatement ps2 = con.prepareStatement(itemSql);
            ps2.setInt(1, orderId);
            ps2.setInt(2, itemId);
            ps2.setInt(3, itemId);

            ps2.executeUpdate();

            response.sendRedirect("student/studentOrders.jsp");



        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h2 style='color:red;'>Order Failed!</h2>");
        }
    }
}
