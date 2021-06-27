package com.esgi.pushellp.detailTicket;

import com.esgi.pushellp.OurHttpClient;
import com.esgi.pushellp.commun.Utils;
import com.esgi.pushellp.models.Commentary;
import com.esgi.pushellp.models.Individual;
import com.esgi.pushellp.models.Ticket;
import com.esgi.pushellp.ticketList.TicketCell;
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
import javafx.scene.control.*;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.stage.Stage;
import javafx.util.Callback;

import java.net.URL;
import java.net.http.HttpResponse;
import java.util.*;

public class DetailTicketController implements Initializable {
    public static final String IN_PROGRESS = "En cours";
    private static final String API_SERVER_URI = "http://0.0.0.0:3000/createCommentary";
    private HashMap<String, String> headers;
    private HashMap<Object, Object> bodyRequest;
    private Gson gson = new Gson();
    private ImageView imageArrowBack = new ImageView(getClass().getResource("../ressources/images/arrow-left.png").toString());
    private TicketListController ticketListController;
    private Scene ticketListScene;
    private Individual user;
    private Individual userResponsible;

    private Ticket ticket;
    private ObservableList<Commentary> commentaries;
    private List<Commentary> listCommentaries;

    @FXML
    public Label detailTicketTitle;
    @FXML
    public Button buttonBack;
    @FXML
    public TextArea commentaryTextArea;
    @FXML
    public ListView listViewCommentaries;
    @FXML
    public TextArea descriptionTextArea;
    @FXML
    public ComboBox comboboxStatus;
    @FXML
    public Label labelStatus;
    @FXML
    public Label dateLastUpdate;
    @FXML
    public Label dateCreate;
    @FXML
    public Label dateEnd;
    @FXML
    public Label labelResponsable;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        imageArrowBack.setFitHeight(24);
        imageArrowBack.setFitWidth(24);
        buttonBack.setGraphic(imageArrowBack);
    }
    public void setIndividual(Individual individual) {
        user = individual;
        userResponsible = Utils.getIndividualById(this.ticket.getIndividual_idindividual());
        updateLabelUser();
    }
    public void setTicket(Ticket ticket) {
        this.ticket = ticket;
        System.out.println(ticket);
        updateLabelTicket();
        updateDescriptionTextArea();
        List<Commentary> listCommentaries = Utils.getCommentaryListByIdTicket(this.ticket.getIdticket());
        this.listCommentaries = new ArrayList<>(listCommentaries);
        updateCommentaryList(listCommentaries);
    }
    public void updateLabelUser(){
        labelResponsable.setText(this.userResponsible.getPseudo());
    }
    public void updateLabelTicket(){
        detailTicketTitle.setText(this.ticket.getTitle());
    }
    public void updateDescriptionTextArea(){
        descriptionTextArea.setText(this.ticket.getTitle());
    }

    public void updateCommentaryList(List<Commentary> listCommentaries){
        for (Commentary commentary:
             listCommentaries) {
            System.out.println(commentary);
        }
        this.commentaries = FXCollections.observableArrayList(listCommentaries);
        listViewCommentaries.setItems(null);
        listViewCommentaries.setItems(this.commentaries);
        listViewCommentaries.setCellFactory((Callback<ListView<Ticket>, ListCell<Commentary>>) listView -> new CommentaryCell());
        listViewCommentaries.refresh();
    }

    public void onClickSubmit(ActionEvent event) {
        System.out.println("submit");
        System.out.println(commentaryTextArea.getText());
        OurHttpClient httpClient = new OurHttpClient();
        try {
            HttpResponse<String> response = httpClient.sendRequest(
                    "POST",
                    API_SERVER_URI,
                    headers = new HashMap<>(Map.ofEntries(
                            new AbstractMap.SimpleEntry<String, String>("Content-Type", "application/x-www-form-urlencoded")
                    )),
                    bodyRequest = new HashMap<>(Map.ofEntries(
                            new AbstractMap.SimpleEntry<Object, Object>("text", commentaryTextArea.getText()),
                            new AbstractMap.SimpleEntry<Object, Object>("idUser", user.getIdindividual()),
                            new AbstractMap.SimpleEntry<Object, Object>("idTicket", ticket.getIdticket())
                    ))
            );
            if(response.statusCode() != 200){
                Utils.showAlertDialog("error", "Error creating the commentary", "Please contact your administrator.");
                return;
            }
            Utils.showAlertDialog("success", "Successfully creating the commentary", "You have created a new commentary!");
            updateCommentaryList(Utils.getCommentaryListByIdTicket(this.ticket.getIdticket()));

        } catch (Exception e) {
            e.printStackTrace();
            Utils.showAlertDialog("error", "Error Connection API Server", "An error occurred while we attempted connecting to the API Server.");
        }
    }

    public void onClickCancel(ActionEvent event) {
        System.out.println("cancel");
    }

    public void onClickButtonBack(ActionEvent event) {
        openTicketListScene(event);
    }
    public void openTicketListScene(ActionEvent event){
        ticketListController.updateLabelAndChoiceBoxTicket(IN_PROGRESS);
        ticketListController.setIndividual(user);

        List<Ticket> tickets = Utils.getTicketListByStatus("en_cours");
        ticketListController.initObservableListTicketList(tickets);
        Stage primaryStage = (Stage)((Node)event.getSource()).getScene().getWindow();
        primaryStage.setScene(ticketListScene);
    }

    public void setTicketListController(TicketListController ticketListController) {
        this.ticketListController = ticketListController;
    }

    public void setTicketListScene(Scene ticketListScene) {
        this.ticketListScene = ticketListScene;
    }

}
