package com.esgi.pushellp.ticketList;

import com.esgi.pushellp.connection.ConnectionController;
import com.esgi.pushellp.createTicket.CreateTicketController;
import com.esgi.pushellp.models.Individual;
import javafx.application.Platform;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.layout.Background;
import javafx.scene.layout.BackgroundFill;
import javafx.scene.layout.Pane;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.stage.Stage;

import java.awt.*;
import java.awt.event.ActionEvent;
import java.io.IOException;
import java.net.URL;
import java.util.Arrays;
import java.util.List;
import java.util.ResourceBundle;

public class TicketListController implements Initializable {
    private Stage ticketlistStage;
    private ConnectionController connectionController;
    private Individual user;
    private List<String> colors = Arrays.asList("red", "green", "blue");

    @FXML
    private Label labelUser;
    @FXML
    private VBox listTicketVBox;
    @FXML
    private Button addButton;

    public TicketListController(ConnectionController connectionController, Individual individual) {
        this.connectionController = connectionController;
        this.user = individual;
        try {
            System.out.println(getClass());
            FXMLLoader loader = new FXMLLoader(getClass().getResource("TicketListApp.fxml"));

            //In the fxml file, set this class as the controller
            loader.setController(this);

            //Scene scene = new Scene(loader.load());
            this.ticketlistStage = new Stage();
            this.ticketlistStage.setScene(new Scene(loader.load()));
            this.ticketlistStage.setResizable(false);
            labelUser.setText(user.getPseudo());
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {

        System.out.println(connectionController);
        this.addButton.setOnAction((e)->{
            System.out.println("clicked");
////            Pane pane = new Pane();
////            String enteredByUser = this.colors.get(0);
////            pane.setBackground(new Background(new BackgroundFill(Color.web("#7A0503"), null, null)));
//            Label labeltest = new Label("Test");
//            labeltest.getStyleClass().add("label");
//
//            //this.colors.remove(0);
//            this.listTicketVBox.getChildren().add(labeltest);
            CreateTicketController createTicketController = new CreateTicketController(this, this.user);
            createTicketController.showStage();
            this.hideStage();

        }); // set onAction property

    }

    public void showStage() {
        this.ticketlistStage.showAndWait();
    }
    public void hideStage() {
        this.ticketlistStage.hide();
    }

}
