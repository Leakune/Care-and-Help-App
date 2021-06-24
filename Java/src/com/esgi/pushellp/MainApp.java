package com.esgi.pushellp;

import com.esgi.pushellp.commun.Utils;
import com.esgi.pushellp.connection.ConnectionController;
import com.esgi.pushellp.createTicket.CreateTicketController;
import com.esgi.pushellp.detailTicket.DetailTicketController;
import com.esgi.pushellp.ticketList.TicketListController;
import javafx.application.Application;
import javafx.application.Platform;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;

import static javafx.application.Application.launch;

public class MainApp extends Application {
    private Stage mainStage;
    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void start(Stage MainStage){
        //set Connection scene configuration
        try {
            FXMLLoader connectionLoader = new FXMLLoader(getClass().getResource("connection/ConnectionApp.fxml"));
            Parent connectionScreen = connectionLoader.load();

            Platform.runLater( () -> connectionScreen.requestFocus() );
            Scene connectionScene = new Scene(connectionScreen);

            //set TicketList scene configuration
            FXMLLoader ticketListLoader = new FXMLLoader(getClass().getResource("ticketList/TicketListApp.fxml"));
            Parent ticketListScreen = ticketListLoader.load();
            Scene ticketListScene = new Scene(ticketListScreen);

            //set createTicket scene configuration
            FXMLLoader createTicketLoader = new FXMLLoader(getClass().getResource("createTicket/CreateTicketApp.fxml"));
            Parent createListScreen = createTicketLoader.load();
            Scene createListScene = new Scene(createListScreen);

            //set detailTicket scene configuration
            FXMLLoader detailTicketLoader = new FXMLLoader(getClass().getResource("detailTicket/DetailTicketApp.fxml"));
            Parent detailTicketScreen = detailTicketLoader.load();
            Scene detailTicketScene = new Scene(detailTicketScreen);


            // injecting createListScene into the ticketListController
            CreateTicketController createTicketController = createTicketLoader.getController();

            TicketListController ticketListController = ticketListLoader.getController();
            ticketListController.setCreateTicketScene(createListScene);
            ticketListController.setCreateTicketController(createTicketController);

            // injecting detailTicketScene Scene into the ticketListController
            DetailTicketController detailTicketController = detailTicketLoader.getController();

            ticketListController.setDetailTicketScene(detailTicketScene);
            ticketListController.setDetailTicketController(detailTicketController);

            // injecting ticketListScene into the createListController
            createTicketController.setTicketListController(ticketListController);
            createTicketController.setTicketListScene(ticketListScene);

            // injecting ticketListScene into the detailTicketController
            detailTicketController.setTicketListController(ticketListController);
            detailTicketController.setTicketListScene(ticketListScene);

            // injecting ticketListScene into the connectionController
            ConnectionController connectionController = connectionLoader.getController();
            connectionController.setTicketListScene(ticketListScene);
            connectionController.setTicketListController(ticketListController);


            this.mainStage = MainStage;
            this.mainStage.setScene(connectionScene);
            this.mainStage.setResizable(false);
            this.mainStage.show();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
    @Override
    public void init() throws Exception { // méthode appelée avant la méthode start
        System.out.println("init called");
    }

    @Override
    public void stop() throws Exception { //méthode appelée quand l'application est stoppée
        System.out.println("stop called");
    }

}
