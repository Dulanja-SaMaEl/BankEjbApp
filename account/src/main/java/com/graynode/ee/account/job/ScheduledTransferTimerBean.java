package com.graynode.ee.account.job;

import com.graynode.ee.core.entity.Account;
import com.graynode.ee.core.entity.ScheduledTransfer;
import com.graynode.ee.core.interceptor.Loggable;
import com.graynode.ee.core.service.ScheduledTransferService;
import jakarta.ejb.Schedule;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import jakarta.transaction.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.logging.Logger;

@Stateless
@Loggable
public class ScheduledTransferTimerBean implements ScheduledTransferService {

    private static final Logger logger = Logger.getLogger(ScheduledTransferTimerBean.class.getName());

    @PersistenceContext
    private EntityManager em;

    // Run every minute
    @Schedule(second = "0", minute = "*", hour = "*", persistent = false)
    public void processScheduledTransfers() {
        logger.info("Processing scheduled transfers...");

        try {
            List<ScheduledTransfer> pendingTransfers = findPendingTransfers();

            int processed = 0;
            for (ScheduledTransfer transfer : pendingTransfers) {
                if (executeTransfer(transfer)) {
                    processed++;
                }
            }

            logger.info("Processed " + processed + " scheduled transfers");

        } catch (Exception e) {
            logger.severe("Error processing scheduled transfers: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Alternative: Run every 5 minutes
    // @Schedule(minute = "*/5", hour = "*", persistent = false)

    // Alternative: Run at specific times
    // @Schedule(hour = "9,17", minute = "0", second = "0", persistent = false)

    @Transactional
    public boolean executeTransfer(ScheduledTransfer scheduledTransfer) {
        try {
            // Get fresh account data
            Account sourceAccount = em.find(Account.class, scheduledTransfer.getSourceAccount().getId());
            Account destinationAccount = em.find(Account.class, scheduledTransfer.getDestinationAccount().getId());

            // Check if source account has sufficient balance
            if (sourceAccount.getBalance() < scheduledTransfer.getAmount()) {
                logger.warning("Insufficient balance for transfer ID: " + scheduledTransfer.getId());
                return false;
            }

            // Perform the transfer
            sourceAccount.setBalance(sourceAccount.getBalance() - scheduledTransfer.getAmount());
            destinationAccount.setBalance(destinationAccount.getBalance() + scheduledTransfer.getAmount());

            // Mark transfer as processed
            scheduledTransfer.setProcessed(true);

            // Save changes
            em.merge(sourceAccount);
            em.merge(destinationAccount);
            em.merge(scheduledTransfer);

            logger.info("Successfully processed transfer ID: " + scheduledTransfer.getId());
            return true;

        } catch (Exception e) {
            logger.severe("Failed to process transfer ID: " + scheduledTransfer.getId() + " - " + e.getMessage());
            return false;
        }
    }

    public List<ScheduledTransfer> findPendingTransfers() {
        TypedQuery<ScheduledTransfer> query = em.createQuery(
                "SELECT st FROM ScheduledTransfer st WHERE st.processed = false AND st.scheduledTime <= :currentTime",
                ScheduledTransfer.class
        );
        query.setParameter("currentTime", LocalDateTime.now());
        return query.getResultList();
    }

    @Transactional
    public void saveScheduledTransfer(ScheduledTransfer transfer) {
        em.persist(transfer);
    }

    public List<ScheduledTransfer> getAllScheduledTransfers() {
        return em.createQuery(
                "SELECT st FROM ScheduledTransfer st ORDER BY st.scheduledTime DESC",
                ScheduledTransfer.class
        ).getResultList();
    }
}
