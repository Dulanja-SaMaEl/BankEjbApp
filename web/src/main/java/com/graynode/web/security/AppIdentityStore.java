package com.graynode.web.security;

import com.graynode.ee.core.entity.User;
import com.graynode.ee.core.service.AuthService;
import com.graynode.ee.core.service.UserService;
import jakarta.ejb.EJB;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.security.enterprise.credential.Credential;
import jakarta.security.enterprise.credential.UsernamePasswordCredential;
import jakarta.security.enterprise.identitystore.CredentialValidationResult;
import jakarta.security.enterprise.identitystore.IdentityStore;


import java.util.Set;

@ApplicationScoped
public class AppIdentityStore implements IdentityStore {

    @EJB
    private UserService userService;

    @Override
    public CredentialValidationResult validate(Credential credential) {
        if (credential instanceof UsernamePasswordCredential){
            UsernamePasswordCredential upc = (UsernamePasswordCredential) credential;



            if (userService.validate(upc.getCaller(), upc.getPasswordAsString())){
                User user = userService.getUserByEmail(upc.getCaller());
                if (user != null && user.getRole() != null) {
                    System.out.println(user.getName());
                    return new CredentialValidationResult(user.getEmail(), Set.of(user.getRole().getName()));
                }
            }

        }
        return CredentialValidationResult.INVALID_RESULT;
    }
}
