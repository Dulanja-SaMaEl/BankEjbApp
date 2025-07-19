package com.graynode.ee.core.service;

import com.graynode.ee.core.entity.User;
import jakarta.ejb.Remote;

@Remote  // This marks the interface as a Remote EJB interface
public interface AuthService  {

    User loginByEmail(String email, String password);

    boolean hasRole(User user, String roleName);

    boolean registerUser(String name, String email, String password, String roleName);


}