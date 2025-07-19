package com.graynode.ee.core.service;

import jakarta.ejb.Remote;

@Remote
public interface SecureBankService {

    String adminOnlyAction();

    String whoAmI();

    String anyoneCanAccess();

    String noOneCanAccess();

}
