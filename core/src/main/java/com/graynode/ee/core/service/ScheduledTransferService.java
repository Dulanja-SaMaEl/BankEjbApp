package com.graynode.ee.core.service;

import com.graynode.ee.core.entity.ScheduledTransfer;
import jakarta.ejb.Remote;

import java.util.List;

@Remote
public interface ScheduledTransferService {

    boolean executeTransfer(ScheduledTransfer scheduledTransfer);

    void saveScheduledTransfer(ScheduledTransfer transfer);

    List<ScheduledTransfer> getAllScheduledTransfers();

    List<ScheduledTransfer> findPendingTransfers();
}
