package com.graynode.ee.core.service;

import jakarta.ejb.Schedule;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import com.graynode.ee.core.entity.Account;

import java.math.BigDecimal;
import java.util.List;

@Stateless
public class InterestTimerBean {

    @PersistenceContext
    private EntityManager em;

    @Schedule(hour = "0", minute = "0", second = "0", persistent = false)
    public void applyInterestToAccounts() {
        List<Account> accounts = em.createQuery("SELECT a FROM Account a", Account.class).getResultList();
        for (Account acc : accounts) {
            Double interest = acc.getBalance() * 0.01;
            acc.setBalance(acc.getBalance() + interest);
            em.merge(acc);
        }
        System.out.println("Interest applied to all accounts");
    }
}

