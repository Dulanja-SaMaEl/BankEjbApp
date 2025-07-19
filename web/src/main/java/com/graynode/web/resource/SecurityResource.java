package com.graynode.web.resource;



import com.graynode.ee.core.service.SecureBankService;
import jakarta.ejb.EJB;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

@Path("/secure")
@Produces(MediaType.TEXT_PLAIN)
public class SecurityResource {

    @EJB
    private SecureBankService secureBankService;

    @GET
    @Path("/whoami")
    public Response whoAmI() {
        return Response.ok(secureBankService.whoAmI()).build();
    }

    @GET
    @Path("/admin")
    public Response adminOnly() {
        return Response.ok(secureBankService.adminOnlyAction()).build();
    }
}