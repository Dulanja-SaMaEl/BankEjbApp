package com.graynode.web.resource;

import com.graynode.ee.core.exception.InsufficientFundsException;
import com.graynode.ee.core.service.AccountService;
import com.graynode.ee.core.entity.Account;

import jakarta.ejb.EJB;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.math.BigDecimal;
import java.util.Map;

@Path("/account")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class AccountResource {

    @PersistenceContext
    private EntityManager em;

    @EJB
    private AccountService accountService;

    @POST
    public Response createAccount(Account acc) {
        em.persist(acc);
        return Response.status(Response.Status.CREATED).entity(acc).build();
    }

    @GET
    @Path("/{id}")
    public Response getAccount(@PathParam("id") int id) {
        Account acc = em.find(Account.class, id);
        if (acc == null) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
        return Response.ok(acc).build();
    }
}
