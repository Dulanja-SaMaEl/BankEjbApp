package com.graynode.ee.core.service;


import jakarta.ejb.Remote;

@Remote
public interface InterestCreditingService {
    void creditAnnualInterest();
}
