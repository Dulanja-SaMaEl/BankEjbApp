package com.graynode.ee.core.service;

import com.graynode.ee.core.entity.Account;
import com.graynode.ee.core.entity.Transaction;
import com.graynode.ee.core.exception.InsufficientFundsException;
import jakarta.ejb.Remote;

import java.math.BigDecimal;
import java.util.List;

@Remote
public interface AccountService {
    void processTransaction(int sourceAccountId, int destinationAccountId, Double amount, String type) throws InsufficientFundsException;
    List<Account> getAllAccounts();
    void updateAccountStatus(int accountId, int newStatusId);
    List<Transaction> getTransactionsByAccount(int accountId);
    Account getAccountByUserId(int userId);
}
