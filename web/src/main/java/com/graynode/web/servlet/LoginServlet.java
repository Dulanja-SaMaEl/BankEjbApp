package com.graynode.web.servlet;

import com.graynode.ee.core.entity.Account;
import com.graynode.ee.core.entity.User;
import com.graynode.ee.core.service.AccountService;
import com.graynode.ee.core.service.UserService;
import jakarta.ejb.EJB;
import jakarta.inject.Inject;
import jakarta.security.enterprise.AuthenticationStatus;
import jakarta.security.enterprise.authentication.mechanism.http.AuthenticationParameters;
import jakarta.security.enterprise.credential.UsernamePasswordCredential;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.security.enterprise.SecurityContext;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @EJB
    private UserService userService;

    @EJB
    private AccountService accountService;

    @Inject
    private SecurityContext securityContext;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        System.out.println(email + " " + password);

        //String encryptedPassword = Encryption.encrypt(password);

        AuthenticationParameters parameters = AuthenticationParameters.withParams()
                .credential(new UsernamePasswordCredential(email, password));

        System.out.println("parameters :" + parameters);
        AuthenticationStatus status = securityContext.authenticate(request, response, parameters);
        System.out.println("status:" + status);

        if (status == AuthenticationStatus.SUCCESS) {

            User user = userService.getUserByEmail(email);

            request.getSession().setAttribute("user", user);

            // ✅ Fetch account and store it in session
            Account account = accountService.getAccountByUserId(user.getId());
            if (account != null) {
                request.getSession().setAttribute("account", account);
            }

            if (user.getRole().getName().equals("Admin")) {
                response.sendRedirect(request.getContextPath() + "/admin/index.jsp");
            } else if (user.getRole().getName().equals("User")) {
                response.sendRedirect(request.getContextPath() + "/user/index.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }

    }
}
