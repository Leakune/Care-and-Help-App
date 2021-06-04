package com.esgi.pushellp.ticketList;

import com.esgi.pushellp.connection.ConnectionController;
import com.esgi.pushellp.models.Individual;
import javafx.application.Platform;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.stage.Stage;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

public class TicketListController implements Initializable {
    private Stage ticketlistStage;
    private ConnectionController connectionController;
    private Individual user;
    @FXML
    private Label labelUser;

    public TicketListController(ConnectionController connectionController, Individual individual) {
        this.connectionController = connectionController;
        this.user = individual;
        try {
            System.out.println(getClass());
            FXMLLoader loader = new FXMLLoader(getClass().getResource("TicketListApp.fxml"));

            //In the fxml file, set this class as the controller
            loader.setController(this);

            //Platform.runLater( () -> root.requestFocus() );

            this.ticketlistStage = new Stage();
            // Load the scene
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
    }

    public void showStage() {
        this.ticketlistStage.showAndWait();
    }
}
