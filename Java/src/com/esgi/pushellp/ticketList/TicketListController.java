package com.esgi.pushellp.ticketList;

import com.esgi.pushellp.connection.ConnectionController;
import com.esgi.pushellp.createTicket.CreateTicketController;
import com.esgi.pushellp.models.Individual;
import javafx.application.Platform;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Node;
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
import java.io.IOException;
import java.net.URL;
import java.util.Arrays;
import java.util.List;
import java.util.ResourceBundle;

public class TicketListController implements Initializable {
    private Stage ticketlistStage;
    private ConnectionController connectionController;
    private Individual user;
    private Scene createTicketScene;
    private CreateTicketController createTicketController;
    private List<String> colors = Arrays.asList("red", "green", "blue");

    @FXML
    private Label labelUser;
    @FXML
    private VBox listTicketVBox;
    @FXML
    private Button addButton;

    @FXML
    protected void onClickAddButton(ActionEvent event){
        System.out.println("add button clicked");
        openCreateTicketScene(event);
    }


    public void updateLabel(String text){
        labelUser.setText(text);
    }

    public void setIndividual(Individual individual) {
        user = individual;
    }
    public void setCreateTicketScene(Scene scene) {
        createTicketScene = scene;
    }
    public void setCreateTicketController(CreateTicketController controller){
        createTicketController = controller;
    }

    public void openCreateTicketScene(ActionEvent event) {
        createTicketController.setIndividual(user);
        Stage primaryStage = (Stage)((Node)event.getSource()).getScene().getWindow();
        primaryStage.setScene(createTicketScene);
    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {

        System.out.println(connectionController);
//        this.addButton.setOnAction((e)->{
//            System.out.println("clicked");
//            Pane pane = new Pane();
//            String enteredByUser = this.colors.get(0);
//            pane.setBackground(new Background(new BackgroundFill(Color.web("#7A0503"), null, null)));
//            Label labeltest = new Label("Test");
//            labeltest.getStyleClass().add("label");
//
//            //this.colors.remove(0);
//            this.listTicketVBox.getChildren().add(labeltest);
//            CreateTicketController createTicketController = new CreateTicketController(this, this.user);
//            createTicketController.showStage();
//            this.hideStage();
//
//        }); // set onAction property

    }

}
