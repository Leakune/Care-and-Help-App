package com.esgi.pushellp.ticketList;

import com.esgi.pushellp.connection.ConnectionController;
import javafx.application.Platform;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

public class TicketListController implements Initializable {
    private Stage ticketlistStage;
    private ConnectionController connectionController;

    public TicketListController(ConnectionController connectionController) {
        this.connectionController = connectionController;
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

        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {

    }

    public void showStage() {
        this.ticketlistStage.showAndWait();
    }
}
