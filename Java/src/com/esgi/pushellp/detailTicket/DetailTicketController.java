package com.esgi.pushellp.detailTicket;

import com.esgi.pushellp.commun.Utils;
import com.esgi.pushellp.models.Individual;
import com.esgi.pushellp.models.Ticket;
import com.esgi.pushellp.ticketList.TicketListController;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.stage.Stage;

import java.net.URL;
import java.util.List;
import java.util.ResourceBundle;

public class DetailTicketController implements Initializable {
    public static final String IN_PROGRESS = "En cours";

    private ImageView imageArrowBack = new ImageView(getClass().getResource("../ressources/images/arrow-left.png").toString());

    private TicketListController ticketListController;
    private Scene ticketListScene;
    private Individual user;
    private Ticket ticket;

    @FXML
    public Label detailTicketTitle;

    @FXML
    public Button buttonBack;

    @FXML
    public Label labelUser2;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        imageArrowBack.setFitHeight(24);
        imageArrowBack.setFitWidth(24);
        buttonBack.setGraphic(imageArrowBack);
    }
    public void setIndividual(Individual individual) {
        user = individual;
        updateLabelUser();
    }
    public void setTicket(Ticket ticket) {
        this.ticket = ticket;
        System.out.println(ticket);
        updateLabelTicket();
    }
    public void updateLabelUser(){
        labelUser2.setText(this.user.getPseudo());
    }
    public void updateLabelTicket(){
        detailTicketTitle.setText(this.ticket.getTitle());
    }

    public void onClickSubmit(ActionEvent event) {
        System.out.println("submit");
    }

    public void onClickCancel(ActionEvent event) {
        System.out.println("cancel");
    }

    public void onClickButtonBack(ActionEvent event) {
        openTicketListScene(event);
    }
    public void openTicketListScene(ActionEvent event){
        ticketListController.updateLabelAndChoiceBoxTicket(IN_PROGRESS);
        ticketListController.setIndividual(user);

        List<Ticket> tickets = Utils.getTicketListByStatus("en_cours");
        ticketListController.initObservableListTicketList(tickets);
        Stage primaryStage = (Stage)((Node)event.getSource()).getScene().getWindow();
        primaryStage.setScene(ticketListScene);
    }

    public void setTicketListController(TicketListController ticketListController) {
        this.ticketListController = ticketListController;
    }

    public void setTicketListScene(Scene ticketListScene) {
        this.ticketListScene = ticketListScene;
    }

}
