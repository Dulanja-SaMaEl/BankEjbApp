package com.graynode.ee.account.job;

import com.graynode.ee.core.entity.Account;
import com.graynode.ee.core.entity.Transaction;
import com.graynode.ee.core.service.InterestCreditingService;
import jakarta.ejb.Schedule;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.logging.Logger;

@Stateless
public class InterestCreditingBean implements InterestCreditingService {

    private static final Logger logger = Logger.getLogger(InterestCreditingBean.class.getName());

    @PersistenceContext
    private EntityManager em;

    // This will run once a year on January 1st at midnight
    @Schedule(dayOfMonth = "1", month = "1", hour = "0", minute = "0", second = "0", persistent = false)
    @Override
    public void creditAnnualInterest() {
        logger.info("⏰ Starting annual interest credit process...");
        creditInterestToAllAccounts();
    }

    @Transactional
    public void creditInterestToAllAccounts() {
        List<Account> accounts = em.createQuery("SELECT a FROM Account a", Account.class).getResultList();
        double interestRate = 0.05; // Example: 5% interest

        for (Account account : accounts) {
            double balance = account.getBalance();
            double interest = balance * interestRate;

            account.setBalance(balance + interest);
            em.merge(account);

            // Save transaction record
            Transaction txn = new Transaction();
            txn.setSourceAccount(null); // Bank is the source
            txn.setDestinationAccount(account);
            txn.setAmount(interest);
            txn.setType("INTEREST");
            txn.setTimestamp(LocalDateTime.now());
            em.persist(txn);

            logger.info("Credited interest of " + interest + " to account ID: " + account.getId());
        }

        logger.info("✅ Interest crediting completed.");
    }
}
