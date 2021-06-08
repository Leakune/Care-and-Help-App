package com.esgi.pushellp;

import javafx.application.Application;
import javafx.application.Platform;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import static javafx.application.Application.launch;

public class MainApp extends Application {
    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void start(Stage MainStage) throws Exception {
        Parent root = FXMLLoader.load(getClass().getResource("connection/ConnectionApp.fxml"));
        Platform.runLater( () -> root.requestFocus() );

        Scene scene = new Scene(root);

        MainStage.setScene(scene);
        MainStage.setResizable(false);
        MainStage.show();
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
