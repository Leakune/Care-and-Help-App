package com.esgi.pushellp.detailTicket;

import com.esgi.pushellp.OurHttpClient;
import com.esgi.pushellp.commun.Utils;
import com.esgi.pushellp.models.Commentary;
import com.esgi.pushellp.models.Individual;
import com.esgi.pushellp.models.Ticket;
import com.esgi.pushellp.ticketList.TicketSampleController;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import javafx.scene.control.ListCell;

import java.net.http.HttpResponse;
import java.util.*;

public class CommentaryCell extends ListCell<Commentary> {
    @Override
    public void updateItem(Commentary commentary, boolean empty) {
            super.updateItem(commentary,empty);
            if(commentary != null) {
                CommentaryController commentaryController = new CommentaryController();
                commentaryController.setInfo(commentary, Utils.getIndividualById(commentary.getIndividual_idindividual()));
                setGraphic(commentaryController.getBox());
            }
    }

}