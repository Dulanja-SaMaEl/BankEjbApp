package com.graynode.web.servlet;

import com.graynode.ee.core.entity.Account;
import com.graynode.ee.core.service.AccountService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/accounts")
public class AdminAccountServlet extends HttpServlet {

    @EJB
    private AccountService accountService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Account> accounts = accountService.getAllAccounts();
        request.setAttribute("accounts", accounts);
        request.getRequestDispatcher("/admin/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int accountId = Integer.parseInt(request.getParameter("accountId"));
        int newStatusId = Integer.parseInt(request.getParameter("newStatusId"));

        accountService.updateAccountStatus(accountId, newStatusId);

        response.sendRedirect(request.getContextPath() + "/admin/accounts");
    }
}

