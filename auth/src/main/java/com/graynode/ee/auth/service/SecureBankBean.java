package com.graynode.ee.auth.service;


import com.graynode.ee.core.service.SecureBankService;
import jakarta.annotation.Resource;
import jakarta.annotation.security.DeclareRoles;
import jakarta.annotation.security.DenyAll;
import jakarta.annotation.security.PermitAll;
import jakarta.annotation.security.RolesAllowed;
import jakarta.ejb.Stateless;
import jakarta.ejb.SessionContext;

@Stateless
@DeclareRoles({"Admin", "User"})
public class SecureBankBean implements SecureBankService {

    @Resource
    private SessionContext ctx;

    @RolesAllowed("Admin")
    public String adminOnlyAction() {
        return "Hello Admin: " + ctx.getCallerPrincipal().getName();
    }

    @RolesAllowed({"Admin", "User"})
    public String whoAmI() {
        String username = ctx.getCallerPrincipal().getName();
        if (ctx.isCallerInRole("Admin")) {
            return "You are Admin, " + username;
        } else if (ctx.isCallerInRole("User")) {
            return "You are User, " + username;
        } else {
            return "Unknown role for " + username;
        }
    }

    @PermitAll
    public String anyoneCanAccess() {
        return "This endpoint is public to any logged-in user.";
    }

    @DenyAll
    public String noOneCanAccess() {
        return "This should never be called.";
    }
}

