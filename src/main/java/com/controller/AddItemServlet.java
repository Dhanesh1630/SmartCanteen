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

@WebServlet("/AddItemServlet")
public class AddItemServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String itemName = request.getParameter("item_name");
        String priceStr = request.getParameter("price");
        String category = request.getParameter("category");
        String available = request.getParameter("available");

        try {
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO menu_items(item_name, price, category, available) VALUES(?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, itemName);
            ps.setDouble(2, Double.parseDouble(priceStr));
            ps.setString(3, category);
            ps.setString(4, available);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                response.sendRedirect(request.getContextPath() + "/adminDashboard.jsp?msg=added");
            } else {
                response.sendRedirect(request.getContextPath() + "/adminDashboard.jsp?msg=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h2 style='color:red;'>Error Adding Item!</h2>");
        }
    }
}
