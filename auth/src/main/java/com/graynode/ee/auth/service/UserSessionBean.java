package com.graynode.ee.auth.service;

import com.graynode.ee.core.entity.Account;
import com.graynode.ee.core.entity.Role;
import com.graynode.ee.core.entity.Status;
import com.graynode.ee.core.entity.User;
import com.graynode.ee.core.service.UserService;
import jakarta.annotation.security.RolesAllowed;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

@Stateless
public class UserSessionBean implements UserService {

    @PersistenceContext
    private EntityManager em;


    @Override
    public User getUserById(Long id) {
        return em.find(User.class, id);
    }

    @Override
    public User getUserByEmail(String email) {
        return em.createNamedQuery("User.findByEmail", User.class)
                .setParameter("email", email).getSingleResult();
    }

    @Override
    public void addUser(User user) {

        int roleId = 2;
        Role role = em.find(Role.class, roleId);
        if (role == null) {
            throw new IllegalArgumentException("Role not found with ID: " + roleId);
        }

        user.setRole(role);
        em.persist(user);
        em.flush();

        // No need to fetch again
        createAccount(user);
    }

    public void createAccount(User user) {
        Account account = new Account();
        account.setUser(user); // Direct reference is enough
        account.setBalance(1000.00);

        int statusId = 1;
        Status status = em.find(Status.class, statusId);
        if (status == null) {
            throw new IllegalArgumentException("Status not found with ID: " + status);
        }

        account.setStatus(status);
        em.persist(account);
    }

    //@RolesAllowed({"USER","ADMIN","SUPER_ADMIN"})
    @Override
    public void updateUser(User user) {
        em.merge(user);
    }

    @RolesAllowed({"User", "Admin"})
    @Override
    public void deleteUser(User user) {
        em.remove(user);
    }

    @Override
    public boolean validate(String email, String password) {
        User user = em.createNamedQuery("User.findByEmail", User.class)
                .setParameter("email", email).getSingleResult();

        System.out.println(user.getEmail());
        System.out.println(user.getPassword());
        System.out.println(password);
        return user != null && user.getPassword().equals(password);

        ///

//        User u = em.createNamedQuery("User.findByEmailAndPassword", User.class)
//                .setParameter("email", email)
//                .setParameter("password", password)
//                .getSingleResult();
//
//        return u!=null;

    }
}
