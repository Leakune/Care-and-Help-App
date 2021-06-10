package com.esgi.pushellp.connection;

import com.esgi.pushellp.MainApp;
import com.esgi.pushellp.OurHttpClient;
import com.esgi.pushellp.models.Individual;
import com.esgi.pushellp.ticketList.TicketListController;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import java.net.URL;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.KeySpec;
import java.sql.*;
import java.util.*;

public class ConnectionController implements Initializable {
    private static final String API_SERVER_URI = "http://0.0.0.0:3000/login";
    private HashMap<String, String> headers;
    private HashMap<Object, Object> bodyRequest;
    private Gson gson = new Gson();
    private Scene ticketListScene;
    private TicketListController ticketListController;



    @FXML
    private TextField loginTextField;

    @FXML
    private PasswordField pwdPasswordField;

    @FXML
    public void onClickSubmit(ActionEvent event){
        System.out.println("button clicked");
        System.out.println("Texfield: " + loginTextField.getText());
        System.out.println("PasswordField: " + pwdPasswordField.getText());

        OurHttpClient httpClient = new OurHttpClient();
        try {
            HttpResponse<String> response = httpClient.sendRequest(
                    "POST",
                    API_SERVER_URI,
                    headers = new HashMap<>(Map.ofEntries(
                            new AbstractMap.SimpleEntry<String, String>("Content-Type", "application/x-www-form-urlencoded")
                    )),
                    bodyRequest = new HashMap<>(Map.ofEntries(
                            new AbstractMap.SimpleEntry<Object, Object>("username", loginTextField.getText()),
                            new AbstractMap.SimpleEntry<Object, Object>("password", pwdPasswordField.getText())
                    ))
            );
            if(response.statusCode() != 200){
                showAlertDialogError("Error finding your profile", "You have given a wrong username and/or password");
                return;
            }
            JsonObject convertedObject = new GsonBuilder().setDateFormat("YYYY-MM-DD HH:mm:ss").create().fromJson(response.body(), JsonObject.class);
            //System.out.println(convertedObject.get("body").getAsJsonObject().get("data").getAsJsonArray().get(0).getClass().getName());

            Individual indvdl = gson.fromJson(convertedObject.get("body").getAsJsonObject().get("data").getAsJsonArray().get(0), Individual.class);
            System.out.println(indvdl);

            openTicketListScene(event, indvdl);

        } catch (Exception e) {
            e.printStackTrace();
            showAlertDialogError("Error Connection API Server", "An error occurred while we attempted connecting to the API Server.");
        }

    }
    public void showAlertDialogError(String title, String content){
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle(title);
        alert.setHeaderText(null);
        alert.setContentText(content);
        alert.showAndWait();
    }
    public void openTicketListScene(ActionEvent event, Individual individual){
        ticketListController.setIndividual(individual);
        ticketListController.updateLabel(individual.getPseudo());
        Stage primaryStage = (Stage)((Node)event.getSource()).getScene().getWindow();
        primaryStage.setScene(ticketListScene);
    }
    public void setTicketListScene(Scene scene){
        ticketListScene = scene;
    }
    public void setTicketListController(TicketListController controller){
        ticketListController = controller;
    }
    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        System.out.println("Hello World");
    }



}
