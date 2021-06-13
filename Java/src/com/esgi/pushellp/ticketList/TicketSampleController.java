package com.esgi.pushellp.ticketList;

import com.esgi.pushellp.models.Ticket;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import javafx.scene.control.TextArea;
import javafx.scene.layout.VBox;

import java.io.IOException;

public class TicketSampleController {
    @FXML
    public Label titleTicketSample;
    @FXML
    public TextArea descriptionTicketSample;
    @FXML
    public VBox VBoxTicketSample;

    public TicketSampleController(){
        FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("TicketSample.fxml"));
        fxmlLoader.setController(this);
        try
        {
            fxmlLoader.load();
        }
        catch (IOException e)
        {
            throw new RuntimeException(e);
        }
    }
    public void setInfo(Ticket ticket)
    {
        titleTicketSample.setText(ticket.getTitle());
        descriptionTicketSample.setText(ticket.getDescription());
    }

    public VBox getBox()
    {
        return VBoxTicketSample;
    }
}
