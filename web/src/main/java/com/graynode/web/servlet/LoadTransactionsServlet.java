package com.graynode.web.servlet;

import com.graynode.ee.core.entity.Account;
import com.graynode.ee.core.entity.Transaction;
import com.graynode.ee.core.entity.User;
import com.graynode.ee.core.service.AccountService;
import jakarta.ejb.EJB;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/user/transactions")
public class LoadTransactionsServlet extends HttpServlet {

    @PersistenceContext
    private EntityManager em;

    @EJB
    private AccountService accountService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Load transactions by account ID
        List<Transaction> transactions = accountService.getTransactionsByAccount(account.getId());

        // Add to request attribute for JSP
        request.setAttribute("transactions", transactions);

        // Forward back to user index page to display transactions
        request.getRequestDispatcher("/user/index.jsp").forward(request, response);
    }
}


