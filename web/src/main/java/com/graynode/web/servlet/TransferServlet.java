package com.graynode.web.servlet;

import com.graynode.ee.core.exception.InsufficientFundsException;
import com.graynode.ee.core.service.AccountService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/transfer")
public class TransferServlet extends HttpServlet {

    @EJB
    private AccountService accountService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int sourceId = Integer.parseInt(request.getParameter("sourceAccountId"));
            int destId = Integer.parseInt(request.getParameter("destinationAccountId"));
            double amount = Double.parseDouble(request.getParameter("amount"));

            // Reuse the same method for transfer
            accountService.processTransaction(sourceId, destId, amount, "TRANSFER");

            request.setAttribute("message", "Transfer successful!");
        } catch (InsufficientFundsException e) {
            request.setAttribute("message", "Transfer failed: " + e.getMessage());
        } catch (Exception e) {
            request.setAttribute("message", "Transfer failed: " + e.getMessage());
        }

        request.getRequestDispatcher("/user/index.jsp").forward(request, response);
    }
}






