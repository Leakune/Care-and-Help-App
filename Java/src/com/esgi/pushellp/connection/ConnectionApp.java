package com.esgi.pushellp.connection;

import javafx.application.Application;
import javafx.application.Platform;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import static javafx.application.Application.launch;

public class ConnectionApp extends Application {
    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void start(Stage stageConnection) throws Exception {
        Parent root = FXMLLoader.load(getClass().getResource("ConnectionApp.fxml"));
        Platform.runLater( () -> root.requestFocus() ); //permet de defocus l'input Login en focusant le container

        Scene scene = new Scene(root);

        stageConnection.setScene(scene);
        stageConnection.setResizable(false);
        stageConnection.show();
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
