package com.esgi.pushellp.ticketList;

import com.esgi.pushellp.connection.ConnectionController;
import com.esgi.pushellp.createTicket.CreateTicketController;
import com.esgi.pushellp.models.Individual;
import javafx.application.Platform;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.geometry.Pos;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.ChoiceBox;
import javafx.scene.control.ContentDisplay;
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
    public static final String TO_DO = "A faire";
    public static final String IN_PROGRESS = "En cours";
    public static final String DONE = "Terminé";
    public static final String NONE = "No ticket available at the moment, please create one";
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
    private ChoiceBox choiceBox;
    @FXML
    private Label labelStateTicketList;


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
        createTicketController.updateLabel(user.getPseudo());
        Stage primaryStage = (Stage)((Node)event.getSource()).getScene().getWindow();
        primaryStage.setScene(createTicketScene);
    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        Label labelVbox = new Label(NONE);
        Label labelVbox2 = new Label(NONE);
        Label labelVbox3 = new Label(NONE);

        listTicketVBox.getChildren().setAll(labelVbox, labelVbox2, labelVbox3);

        labelVbox.setMaxWidth(Double.MAX_VALUE);
        labelVbox.setAlignment(Pos.CENTER);

        ObservableList<String> statusListTicket //
                = FXCollections.observableArrayList(TO_DO, IN_PROGRESS, DONE);

        choiceBox.setItems(statusListTicket);
        choiceBox.setValue(IN_PROGRESS);
        //
        ChangeListener<String> changeListener = (observable, oldValue, newValue) -> {
            if (newValue != null) {
                System.out.println(newValue);
                if(newValue.equals(TO_DO)){
                    listTicketVBox.getChildren().setAll(new Label("TO DO"));
                    labelStateTicketList.setText(TO_DO);
                }else if(newValue.equals(IN_PROGRESS)){
                    listTicketVBox.getChildren().setAll(new Label("IN PROGRESS"));
                    labelStateTicketList.setText(IN_PROGRESS);
                }else if(newValue.equals(DONE)){
                    listTicketVBox.getChildren().setAll(new Label("DONE"));
                    labelStateTicketList.setText(DONE);
                }
            }
        };
        // Selected Item Changed.
        choiceBox.getSelectionModel().selectedItemProperty().addListener(changeListener);
//        System.out.println(connectionController);
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
