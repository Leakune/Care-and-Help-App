package com.esgi.pushellp.createTicket;

import com.esgi.pushellp.connection.ConnectionController;
import com.esgi.pushellp.models.Individual;
import com.esgi.pushellp.ticketList.TicketListController;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
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
    private Individual user;
    @FXML
    AnchorPane createTicketRoot;
    @FXML
    Label labelUser2;

    public CreateTicketController(TicketListController ticketListController, Individual individual) {
        this.ticketListController = ticketListController;
        this.user = individual;

        try {
            //Parent root = FXMLLoader.load(getClass().getResource("CreateTicketApp.fxml"));
            FXMLLoader loader = new FXMLLoader(getClass().getResource("CreateTicketApp.fxml"));

            //In the fxml file, set this class as the controller
            loader.setController(this);
            //this.createListScene = new Scene(root);
            Parent root = loader.load();
            this.createListScene = new Scene(root);

            this.createListStage = new Stage();
            this.createListStage.setScene(this.createListScene);
            this.createListStage.setResizable(false);
            // cleanup controller resources when window closes:
            //Controller controller = loader.getController();
            this.createListStage.setOnHidden(e -> this.shutdown());
            labelUser2.setText(user.getPseudo());

        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    private void shutdown() {
        this.ticketListController.showStage();
    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {

    }
    public void showStage() {
        this.createListStage.showAndWait();
    }

}
