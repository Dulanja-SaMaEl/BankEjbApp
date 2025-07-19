package com.graynode.web.servlet;

import com.graynode.ee.core.entity.User;
import com.graynode.ee.core.service.UserService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


@WebServlet("/register")
public class Register extends HttpServlet {

    @EJB
    private UserService userService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");


        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);


        userService.addUser(user);


        response.sendRedirect(request.getContextPath() + "/admin/index.jsp");
    }
}
