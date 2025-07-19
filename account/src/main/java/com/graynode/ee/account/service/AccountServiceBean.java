package com.graynode.ee.account.service;

import com.graynode.ee.core.entity.Status;
import com.graynode.ee.core.service.AccountService;
import jakarta.ejb.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import com.graynode.ee.core.entity.Account;
import com.graynode.ee.core.entity.Transaction;
import com.graynode.ee.core.exception.InsufficientFundsException;


import java.util.List;

@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
public class AccountServiceBean implements AccountService {

    @PersistenceContext(unitName = "bankUnit")
    private EntityManager em;

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void processTransaction(int sourceAccountId, int destinationAccountId, Double amount, String type) throws InsufficientFundsException {
        System.out.println("START: Transfer from " + sourceAccountId + " to " + destinationAccountId + " amount=" + amount);

        Account source = em.find(Account.class, sourceAccountId);
        Account destination = em.find(Account.class, destinationAccountId);

        if (source == null) {
            throw new IllegalArgumentException("Source account not found: " + sourceAccountId);
        }
        if (destination == null) {
            throw new IllegalArgumentException("Destination account not found: " + destinationAccountId);
        }

        if (source.getBalance() < amount) {
            throw new InsufficientFundsException("Insufficient balance in source account");
        }

        source.setBalance(source.getBalance() - amount);
        destination.setBalance(destination.getBalance() + amount);

        em.merge(source);
        em.merge(destination);

        Transaction txn = new Transaction();
        txn.setSourceAccount(source);
        txn.setDestinationAccount(destination);
        txn.setAmount(amount);
        txn.setType(type);
        txn.setTimestamp(java.time.LocalDateTime.now());

        em.persist(txn);

        System.out.println("SUCCESS: Transfer completed.");
    }

    @Override
    public List<Account> getAllAccounts() {
        return em.createQuery("SELECT a FROM Account a", Account.class).getResultList();
    }

    @Override
    public void updateAccountStatus(int accountId, int newStatusId) {
        Account account = em.find(Account.class, accountId);
        Status newStatus = em.find(Status.class, newStatusId);

        if (account != null && newStatus != null) {
            account.setStatus(newStatus);
            em.merge(account);
        }
    }

    @Override
    public List<Transaction> getTransactionsByAccount(int accountId) {
        return em.createQuery(
                "SELECT t FROM Transaction t WHERE t.sourceAccount.id = :id OR t.destinationAccount.id = :id ORDER BY t.timestamp DESC",
                Transaction.class
        ).setParameter("id", accountId).getResultList();
    }

    @Override
    public Account getAccountByUserId(int userId) {
        List<Account> results = em.createQuery("SELECT a FROM Account a WHERE a.user.id = :userId", Account.class)
                .setParameter("userId", userId)
                .getResultList();

        return results.isEmpty() ? null : results.get(0);
    }
}



