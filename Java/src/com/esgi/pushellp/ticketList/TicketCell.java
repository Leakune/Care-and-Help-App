package com.esgi.pushellp.ticketList;

import com.esgi.pushellp.models.Ticket;
import javafx.scene.control.ListCell;

public class TicketCell extends ListCell<Ticket> {
    private Ticket ticketData;
    @Override
    public void updateItem(Ticket ticket, boolean empty) {
            super.updateItem(ticket,empty);
            if(ticket != null) {
                this.ticketData = ticket;
                TicketSampleController ticketSample = new TicketSampleController();
                ticketSample.setInfo(ticket);
                setGraphic(ticketSample.getBox());
            }
    }

    public Ticket getTicketData() {
        return ticketData;
    }
}