package com.graynode.web.servlet;


import com.graynode.ee.core.entity.Account;
import com.graynode.ee.core.entity.ScheduledTransfer;
import com.graynode.ee.core.service.ScheduledTransferService;
import jakarta.ejb.EJB;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/schedule-transfer")
public class ScheduleTransferServlet extends HttpServlet {

    @EJB
    private ScheduledTransferService timerService;

    @PersistenceContext
    private EntityManager em;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Extract form parameters
            int sourceAccountId = Integer.parseInt(request.getParameter("scheduleSourceAccountId"));
            int destinationAccountId = Integer.parseInt(request.getParameter("scheduleDestinationAccountId"));
            double amount = Double.parseDouble(request.getParameter("scheduleAmount"));
            String scheduledTimeStr = request.getParameter("scheduledTime");

            // Parse the datetime
            LocalDateTime scheduledTime = LocalDateTime.parse(scheduledTimeStr);

            // Basic validation
            if (amount <= 0) {
                request.setAttribute("error", "Amount must be greater than 0");
                request.getRequestDispatcher("/user/index.jsp").forward(request, response);
                return;
            }

            if (scheduledTime.isBefore(LocalDateTime.now())) {
                request.setAttribute("error", "Scheduled time must be in the future");
                request.getRequestDispatcher("/user/index.jsp").forward(request, response);
                return;
            }

            if (sourceAccountId == destinationAccountId) {
                request.setAttribute("error", "Source and destination accounts cannot be the same");
                request.getRequestDispatcher("/user/index.jsp").forward(request, response);
                return;
            }

            // Get accounts
            Account sourceAccount = em.find(Account.class, sourceAccountId);
            Account destinationAccount = em.find(Account.class, destinationAccountId);

            if (sourceAccount == null || destinationAccount == null) {
                request.setAttribute("error", "Invalid account ID(s)");
                request.getRequestDispatcher("/user/index.jsp").forward(request, response);
                return;
            }

            // Check balance
            if (sourceAccount.getBalance() < amount) {
                request.setAttribute("error", "Insufficient balance in source account");
                request.getRequestDispatcher("/user/index.jsp").forward(request, response);
                return;
            }

            // Create scheduled transfer
            ScheduledTransfer scheduledTransfer = new ScheduledTransfer();
            scheduledTransfer.setSourceAccount(sourceAccount);
            scheduledTransfer.setDestinationAccount(destinationAccount);
            scheduledTransfer.setAmount(amount);
            scheduledTransfer.setScheduledTime(scheduledTime);
            scheduledTransfer.setProcessed(false);

            // Save using EJB service
            timerService.saveScheduledTransfer(scheduledTransfer);

            request.setAttribute("success", "Transfer scheduled successfully! It will be processed automatically.");
            request.getRequestDispatcher("/user/index.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Error scheduling transfer: " + e.getMessage());
            request.getRequestDispatcher("/user/index.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Show scheduled transfers
        request.setAttribute("transfers", timerService.getAllScheduledTransfers());
        request.getRequestDispatcher("/user/index.jsp").forward(request, response);
    }
}