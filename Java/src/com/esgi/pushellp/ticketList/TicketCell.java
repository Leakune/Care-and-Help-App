package com.esgi.pushellp.ticketList;

import com.esgi.pushellp.models.Ticket;
import javafx.scene.control.ListCell;

public class TicketCell extends ListCell<Ticket> {
    @Override
    public void updateItem(Ticket ticket, boolean empty) {
            super.updateItem(ticket,empty);
            if(ticket != null) {
                TicketSampleController ticketSample = new TicketSampleController();
                ticketSample.setInfo(ticket);
                setGraphic(ticketSample.getBox());
            }
    }
}