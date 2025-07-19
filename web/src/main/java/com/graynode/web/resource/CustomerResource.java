package com.graynode.web.resource;



import com.graynode.ee.core.entity.Account;
import com.graynode.ee.core.entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.util.List;

@Path("/customer")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class CustomerResource {

    @PersistenceContext
    private EntityManager em;

    @POST
    public Response createCustomer(User user) {
        em.persist(user);
        return Response.status(Response.Status.CREATED).entity(user).build();
    }

    @GET
    @Path("/{id}/accounts")
    public Response getCustomerAccounts(@PathParam("id") int id) {
        List<Account> accounts = em.createQuery(
                        "SELECT a FROM Account a WHERE a.customer.id = :id", Account.class)
                .setParameter("id", id)
                .getResultList();

        return Response.ok(accounts).build();
    }
}
