package com.controller;

import java.io.IOException;

import com.dao.UserDAO;
import com.dao.UserDAOImpl;
import com.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO dao = new UserDAOImpl();
        User user = dao.login(email, password);

        if (user != null) {

            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            if (user.getRole().equalsIgnoreCase("admin")) {
                response.sendRedirect("adminDashboard.jsp");
            } else {
                response.sendRedirect("studentMenu.jsp");
            }

        } else {
            response.getWriter().println("Invalid Login Credentials!");
        }
    }
}
