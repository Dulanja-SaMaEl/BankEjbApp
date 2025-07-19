package com.graynode.ee.core.service;

import com.graynode.ee.core.entity.User;
import jakarta.ejb.Remote;


@Remote
public interface UserService {
    User getUserById(Long id);
    User getUserByEmail(String email);
    void addUser(User user);
    void updateUser(User user);
    void deleteUser(User user);
    boolean validate(String email, String password);
}
