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

@WebServlet("/DeleteItemServlet")
public class DeleteItemServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null) {
            response.getWriter().println("<h2 style='color:red;'>Item ID Not Found!</h2>");
            return;
        }

        int itemId = Integer.parseInt(idParam);

        try {
            Connection con = DBConnection.getConnection();

            // delete from order_items first (avoid foreign key error)
            PreparedStatement ps1 = con.prepareStatement("DELETE FROM order_items WHERE item_id=?");
            ps1.setInt(1, itemId);
            ps1.executeUpdate();

            // delete from menu_items
            PreparedStatement ps2 = con.prepareStatement("DELETE FROM menu_items WHERE item_id=?");
            ps2.setInt(1, itemId);

            ps2.executeUpdate();

            // redirect back to admin dashboard
            response.sendRedirect(request.getContextPath() + "/adminDashboard.jsp");


        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h2 style='color:red;'>Delete Failed!</h2>");
        }
    }
    
}
