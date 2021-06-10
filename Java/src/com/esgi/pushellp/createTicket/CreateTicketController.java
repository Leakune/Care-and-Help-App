package com.esgi.pushellp.createTicket;

import com.esgi.pushellp.connection.ConnectionController;
import com.esgi.pushellp.models.Individual;
import com.esgi.pushellp.ticketList.TicketListController;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

public class CreateTicketController implements Initializable {
    private Stage createListStage;
    private Scene createListScene;
    private TicketListController ticketListController;
    private Scene ticketListScene;
    private Individual user;
    @FXML
    AnchorPane createTicketRoot;
    @FXML
    Label labelUser2;


    public void setTicketListScene(Scene scene){
        ticketListScene = scene;
    }
    public void setTicketListController(TicketListController controller){
        ticketListController = controller;
    }
    public void setIndividual(Individual individual) {
        user = individual;
    }
    public void openTicketListScene(ActionEvent event){
        ticketListController.setIndividual(user);
        Stage primaryStage = (Stage)((Node)event.getSource()).getScene().getWindow();
        primaryStage.setScene(ticketListScene);
    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
    }

    @FXML
    public void onClickSubmit(ActionEvent event) {
        System.out.println("button submit clicked");
        openTicketListScene(event);
    }
    @FXML
    public void onClickCancel(ActionEvent event) {
        System.out.println("button cancel clicked");
        openTicketListScene(event);
    }
}
