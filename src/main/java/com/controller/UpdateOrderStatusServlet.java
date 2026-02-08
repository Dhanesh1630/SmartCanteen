package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateOrderStatusServlet")
public class UpdateOrderStatusServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String status = request.getParameter("status");

        try {
            Connection con = DBConnection.getConnection();

            String sql = "UPDATE orders SET status=? WHERE order_id=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, status);
            ps.setInt(2, orderId);

            ps.executeUpdate();

            // Redirect back to same admin page
            response.sendRedirect(request.getContextPath() + "/admin/viewOrders.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Status Update Failed!");
        }
    }
}
