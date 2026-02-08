package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.model.User;
import com.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CancelOrderServlet")
public class CancelOrderServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("orderId"));

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            Connection con = DBConnection.getConnection();

            // Step 1: Check current status
            String checkSql = "SELECT status FROM orders WHERE order_id=? AND user_id=?";
            PreparedStatement psCheck = con.prepareStatement(checkSql);
            psCheck.setInt(1, orderId);
            psCheck.setInt(2, user.getUserId());

            ResultSet rs = psCheck.executeQuery();

            if (rs.next()) {
                String status = rs.getString("status");

                // If already cancelled
                if (status.equalsIgnoreCase("Cancelled")) {
                    response.sendRedirect(request.getContextPath() + "/student/studentOrders.jsp?msg=alreadycancelled");
                    return;
                }

                // If order is not pending, cannot cancel
                if (!status.equalsIgnoreCase("Pending")) {
                    response.sendRedirect(request.getContextPath() + "/student/studentOrders.jsp?msg=notallowed");
                    return;
                }
            }

            // Step 2: Cancel the order (only pending)
            String sql = "UPDATE orders SET status='Cancelled' WHERE order_id=? AND user_id=? AND status='Pending'";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, orderId);
            ps.setInt(2, user.getUserId());

            int rows = ps.executeUpdate();

            if (rows > 0) {
                response.sendRedirect(request.getContextPath() + "/student/studentOrders.jsp?msg=cancelled");
            } else {
                response.sendRedirect(request.getContextPath() + "/student/studentOrders.jsp?msg=notallowed");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
