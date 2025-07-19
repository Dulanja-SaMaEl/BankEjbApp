package com.graynode.ee.auth.service;


import com.graynode.ee.core.entity.Role;
import com.graynode.ee.core.entity.User;
import com.graynode.ee.core.service.AuthService;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;


@Stateless
public class AuthServiceBean implements AuthService {

    @PersistenceContext
    private EntityManager em;

    @Override
    public User loginByEmail(String email, String password) {
        try {
            User user = em.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class)
                    .setParameter("email", email)
                    .getSingleResult();

            if (user.getPassword().equals(password)) {
                return user;
            } else {
                return null; // password mismatch
            }

        } catch (NoResultException e) {
            return null; // email not found
        }
    }

    @Override
    public boolean hasRole(User user, String roleName) {
        return user != null && user.getRole().getName().equalsIgnoreCase(roleName);
    }

    @Override
    public boolean registerUser(String name, String email, String password, String roleName) {
        Role role = em.createQuery("SELECT r FROM Role r WHERE r.name = :role", Role.class)
                .setParameter("role", roleName)
                .getSingleResult();

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);

        em.persist(user);
        return true;
    }

}
