package com.graynode.ee.core.interceptor;

import jakarta.interceptor.AroundInvoke;
import jakarta.interceptor.Interceptor;
import jakarta.interceptor.InvocationContext;

import java.util.logging.Logger;

@Interceptor
@Loggable // This is the binding annotation (see step 2)
public class LoggingInterceptor {

    private static final Logger logger = Logger.getLogger(LoggingInterceptor.class.getName());

    @AroundInvoke
    public Object logMethodInvocation(InvocationContext context) throws Exception {
        String className = context.getTarget().getClass().getSimpleName();
        String methodName = context.getMethod().getName();

        logger.info("➡ Entering: " + className + "." + methodName);
        try {
            Object result = context.proceed();
            logger.info("✅ Successfully exited: " + className + "." + methodName);
            return result;
        } catch (Exception e) {
            logger.severe("❌ Exception in: " + className + "." + methodName + " - " + e.getMessage());
            throw e;
        }
    }
}
