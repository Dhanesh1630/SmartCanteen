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

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);

        UserDAO dao = new UserDAOImpl();
        boolean status = dao.register(user);

        if (status) {
            response.sendRedirect("login.jsp");
        } else {
            response.getWriter().println("Registration Failed!");
        }
    }
}
