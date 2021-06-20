package com.esgi.pushellp.connection;

import com.esgi.pushellp.OurHttpClient;
import com.esgi.pushellp.commun.Utils;
import com.esgi.pushellp.models.Individual;
import com.esgi.pushellp.models.Ticket;
import com.esgi.pushellp.ticketList.TicketListController;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.Scene;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import java.net.URL;
import java.net.http.HttpResponse;
import java.util.*;

public class ConnectionController implements Initializable {
    public static final String TO_DO = "A faire";
    public static final String IN_PROGRESS = "En cours";
    public static final String DONE = "Terminé";
    public static final String MY_TICKETS = "Mes tickets";
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
                Utils.showAlertDialog("error", "Error finding your profile", "You have given a wrong username and/or password");
                return;
            }
            JsonObject convertedObject = new GsonBuilder().setDateFormat("YYYY-MM-DD HH:mm:ss").create().fromJson(response.body(), JsonObject.class);
            //System.out.println(convertedObject.get("body").getAsJsonObject().get("data").getAsJsonArray().get(0).getClass().getName());

            Individual indvdl = gson.fromJson(convertedObject.get("body").getAsJsonObject().get("data").getAsJsonArray().get(0), Individual.class);
            System.out.println(indvdl);

            openTicketListScene(event, indvdl);

        } catch (Exception e) {
            e.printStackTrace();
            Utils.showAlertDialog("error", "Error Connection API Server", "An error occurred while we attempted connecting to the API Server.");
        }

    }

    public void openTicketListScene(ActionEvent event, Individual individual){
        ticketListController.setIndividual(individual);
        ticketListController.updateLabel(individual.getPseudo());
        ticketListController.updateLabelAndChoiceBoxTicket(IN_PROGRESS);

        List<Ticket> tickets = Utils.getTicketListByStatus("en_cours");
        ticketListController.initObservableListTicketList(tickets);
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
