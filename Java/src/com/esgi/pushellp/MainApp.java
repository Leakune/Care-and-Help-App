package com.esgi.pushellp;

import javafx.application.Application;
import javafx.application.Platform;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXMLLoader;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.layout.StackPane;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.stage.Stage;

import java.io.IOException;

public class MainApp extends Application {
    Label title = new Label("Connection");
    TextField login = new TextField();
    PasswordField password = new PasswordField();
    Button submit = new Button("Submit");

    @Override
    public void start(Stage stage) throws Exception {
        //VBox formConnection = new VBox(10);
        Parent root = FXMLLoader.load(getClass().getResource("sample.fxml"));
        Platform.runLater( () -> root.requestFocus() ); //permet de defocus l'input Login en focusant le container

        Scene scene = new Scene(root);

        stage.setScene(scene);
        stage.setResizable(false);
        stage.show();

    }

        @Override
    public void init() throws Exception { // méthode appelée avant la méthode start
        System.out.println("init called");
    }

    @Override
    public void stop() throws Exception { //méthode appelée quand l'application est stoppée
        System.out.println("stop called");
    }

    public static void main(String[] args) {
        System.out.println("main called");
        launch(args);
    }
}
