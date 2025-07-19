package com.graynode.web.servlet;

import com.graynode.ee.core.entity.Account;
import com.graynode.ee.core.entity.User;
import com.graynode.ee.core.service.AccountService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/user/refresh-balance")
public class RefreshBalanceServlet extends HttpServlet {

    @EJB
    private AccountService accountService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Check if user is logged in
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            // Fetch the latest account data from database
            Account updatedAccount = accountService.getAccountByUserId(user.getId());

            if (updatedAccount != null) {
                // Update the account in session with fresh data
                session.setAttribute("account", updatedAccount);

                // Set a success message
                request.setAttribute("message", "Balance refreshed successfully!");
            } else {
                // Set an error message if account not found
                request.setAttribute("message", "Error: Could not retrieve account information.");
            }

        } catch (Exception e) {
            // Handle any database or service errors
            System.err.println("Error refreshing balance: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("message", "Error refreshing balance. Please try again.");
        }

        // Redirect back to the dashboard
        response.sendRedirect(request.getContextPath() + "/user/index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Support both GET and POST requests
        doGet(request, response);
    }
}
