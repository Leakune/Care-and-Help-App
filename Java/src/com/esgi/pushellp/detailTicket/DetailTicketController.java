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
import javafx.beans.value.ChangeListener;
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
import java.sql.Timestamp;
import java.util.*;

public class DetailTicketController implements Initializable {
    public static final String IN_PROGRESS = "En cours";
    public static final String TO_DO = "Nouveau";
    public static final String DONE = "Terminé";
    public static final String ANDROID = "android";
    public static final String IOS = "ios";
    public static final String FLUTTER = "flutter";
    private static final String API_SERVER_URI_CREATE_COMMENTARY = "http://0.0.0.0:3000/createCommentary";
    private static final String API_SERVER_URI_SET_TICKET_STATUS = "http://0.0.0.0:3000/setTicketStatus";
    private static final String API_SERVER_URI_SET_TICKET_PLATFORM = "http://0.0.0.0:3000/setTicketPlatform";
    private static final String API_SERVER_URI_SET_TICKET_IDINDIVIDUAL = "http://0.0.0.0:3000/setTicketIdIndividual";

    private HashMap<String, String> headers;
    private HashMap<Object, Object> bodyRequest;
    private Gson gson = new Gson();
    private OurHttpClient httpClient = new OurHttpClient();
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
    public ComboBox comboboxPlatform;
    @FXML
    public Label labelPriority;
    @FXML
    public Label dateLastUpdate;
    @FXML
    public Label dateCreate;
    @FXML
    public Label dateEnd;
    @FXML
    public Label labelResponsable;
    @FXML
    public Button buttonAffect;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        imageArrowBack.setFitHeight(24);
        imageArrowBack.setFitWidth(24);
        buttonBack.setGraphic(imageArrowBack);
    }
    public void setIndividual(Individual individual) {
        user = individual;
        if(this.ticket.getIndividual_idindividual() > 0){
            userResponsible =  Utils.getIndividualById(this.ticket.getIndividual_idindividual());
            updateLabelUserResponsable();
        }
        configureButtonAffect();
    }
    public void setTicket(Ticket ticket) {
        this.ticket = ticket;
        configureLabelTicket();
        configureDescriptionTextArea();
        configureLabelDateCreate();
        configureLabelDateEnd();
        configureLabelDateLastUpdate();
        configureLabelPriority();
        configureComboBoxStatus();
        configureComboboxPlatform();
        configureCommentaryTextArea();
        List<Commentary> listCommentaries = Utils.getCommentaryListByIdTicket(this.ticket.getIdticket());
        this.listCommentaries = new ArrayList<>(listCommentaries);
        updateCommentaryList(listCommentaries);
    }
    public void updateLabelUserResponsable(){
        labelResponsable.setText(this.userResponsible.getPseudo());
    }

    //hide button if current user is the responsible of the ticket
    public void configureButtonAffect(){
        if(this.userResponsible != null){
            buttonAffect.setVisible(!(this.user.getIdindividual() == this.userResponsible.getIdindividual()));
        }
    }
    public void configureLabelTicket(){
        detailTicketTitle.setText(this.ticket.getTitle());
    }
    public void configureLabelDateCreate(){
        dateCreate.setText(this.ticket.getCreationdate().toString());
    }
    public void configureLabelDateEnd(){
        dateEnd.setText(this.ticket.getDeadline().toString());
    }
    public void configureCommentaryTextArea(){commentaryTextArea.setWrapText(true);}
    public void configureLabelDateLastUpdate(){
        dateLastUpdate.setText(this.ticket.getUpdatedate() != null ? this.ticket.getUpdatedate().toString() : "null");
    }
    public void configureLabelPriority(){
        labelPriority.setText(this.ticket.getPriority());
    }

    public void configureComboBoxStatus(){
        ObservableList<String> statusListTicket = FXCollections.observableArrayList(TO_DO, IN_PROGRESS, DONE);
        comboboxStatus.setItems(statusListTicket);
        switch (this.ticket.getStatus()){
            case "en_cours":
                comboboxStatus.setValue(IN_PROGRESS);
                break;
            case "nouveau":
                comboboxStatus.setValue(TO_DO);
                break;
            case "terminé":
                comboboxStatus.setValue(DONE);
                break;
            default:
                comboboxStatus.setValue(this.ticket.getStatus());
        }

        ChangeListener<String> changeListener = (observable, oldValue, newValue) -> {
            if (newValue != null) {
                if(newValue.equals(TO_DO)){
                    updateStatusTicket("nouveau");
                }else if(newValue.equals(IN_PROGRESS)){
                    updateStatusTicket("en_cours");
                }else if(newValue.equals(DONE)){
                    updateStatusTicket("terminé");
                }
            }
        };
        // Selected Item Changed.
        comboboxStatus.getSelectionModel().selectedItemProperty().addListener(changeListener);
    }
    public void configureComboboxPlatform(){
        ObservableList<String> platformListTicket = FXCollections.observableArrayList(ANDROID, IOS, FLUTTER);
        comboboxPlatform.setItems(platformListTicket);
        comboboxPlatform.setValue(this.ticket.getApplication_platformapplication());

        ChangeListener<String> changeListener = (observable, oldValue, newValue) -> {
            if (newValue != null) {
                updatePlatformTicket(newValue);
            }
        };
        // Selected Item Changed.
        comboboxPlatform.getSelectionModel().selectedItemProperty().addListener(changeListener);
    }
    public void updateStatusTicket(String status){
        try {
            HttpResponse<String> response = httpClient.sendRequest(
                    "PUT",
                    API_SERVER_URI_SET_TICKET_STATUS,
                    headers = new HashMap<>(Map.ofEntries(
                            new AbstractMap.SimpleEntry<String, String>("Content-Type", "application/x-www-form-urlencoded")
                    )),
                    bodyRequest = new HashMap<>(Map.ofEntries(
                            new AbstractMap.SimpleEntry<Object, Object>("idTicket", this.ticket.getIdticket()),
                            new AbstractMap.SimpleEntry<Object, Object>("status", status)
                    ))
            );
            if(response.statusCode() != 200){
                Utils.showAlertDialog("error", "Error updating the ticket's status", "Please contact your administrator.");
                return;
            }
            JsonObject convertedObject = gson.fromJson(response.body(), JsonObject.class);
            Timestamp updateDate = new GsonBuilder().setDateFormat("YYYY-MM-DD HH:mm:ss").create().fromJson(convertedObject.get("body").getAsJsonObject().get("updateDate"), Timestamp.class);
            this.ticket.setStatus(status);
            this.ticket.setUpdatedate(updateDate);
            configureLabelDateLastUpdate();

        } catch (Exception e) {
            e.printStackTrace();
            Utils.showAlertDialog("error", "Error Connection API Server", "An error occurred while we attempted connecting to the API Server.");
        }
    }
    public void updatePlatformTicket(String platform){
        try {
            HttpResponse<String> response = httpClient.sendRequest(
                    "PUT",
                    API_SERVER_URI_SET_TICKET_PLATFORM,
                    headers = new HashMap<>(Map.ofEntries(
                            new AbstractMap.SimpleEntry<String, String>("Content-Type", "application/x-www-form-urlencoded")
                    )),
                    bodyRequest = new HashMap<>(Map.ofEntries(
                            new AbstractMap.SimpleEntry<Object, Object>("idTicket", this.ticket.getIdticket()),
                            new AbstractMap.SimpleEntry<Object, Object>("platform", platform)
                    ))
            );
            if(response.statusCode() != 200){
                Utils.showAlertDialog("error", "Error updating the ticket's platform", "Please contact your administrator.");
                return;
            }
            JsonObject convertedObject = gson.fromJson(response.body(), JsonObject.class);
            Timestamp updateDate = new GsonBuilder().setDateFormat("YYYY-MM-DD HH:mm:ss").create().fromJson(convertedObject.get("body").getAsJsonObject().get("updateDate"), Timestamp.class);
            this.ticket.setApplication_platformapplication(platform);
            this.ticket.setUpdatedate(updateDate);
            configureLabelDateLastUpdate();

        } catch (Exception e) {
            e.printStackTrace();
            Utils.showAlertDialog("error", "Error Connection API Server", "An error occurred while we attempted connecting to the API Server.");
        }
    }

    public void configureDescriptionTextArea(){
        descriptionTextArea.setText(this.ticket.getTitle());
    }

    public void updateCommentaryList(List<Commentary> listCommentaries){

        this.commentaries = FXCollections.observableArrayList(listCommentaries);
        listViewCommentaries.setItems(null);
        listViewCommentaries.setItems(this.commentaries);
        listViewCommentaries.setCellFactory((Callback<ListView<Ticket>, ListCell<Commentary>>) listView -> new CommentaryCell());
        listViewCommentaries.refresh();
    }
    public void onClickChangeResponsibleOfTicket(ActionEvent event) {
        try {
            HttpResponse<String> response = httpClient.sendRequest(
                    "PUT",
                    API_SERVER_URI_SET_TICKET_IDINDIVIDUAL,
                    headers = new HashMap<>(Map.ofEntries(
                            new AbstractMap.SimpleEntry<String, String>("Content-Type", "application/x-www-form-urlencoded")
                    )),
                    bodyRequest = new HashMap<>(Map.ofEntries(
                            new AbstractMap.SimpleEntry<Object, Object>("idTicket", this.ticket.getIdticket()),
                            new AbstractMap.SimpleEntry<Object, Object>("idUser", this.user.getIdindividual())
                    ))
            );
            if(response.statusCode() != 200){
                Utils.showAlertDialog("error", "Error updating the ticket's responsible", "Please contact your administrator.");
                return;
            }
            JsonObject convertedObject = gson.fromJson(response.body(), JsonObject.class);
            Timestamp updateDate = new GsonBuilder().setDateFormat("YYYY-MM-DD HH:mm:ss").create().fromJson(convertedObject.get("body").getAsJsonObject().get("updateDate"), Timestamp.class);
            this.ticket.setIndividual_idindividual(this.user.getIdindividual());
            this.ticket.setUpdatedate(updateDate);
            this.userResponsible = this.user;
            updateLabelUserResponsable();
            configureButtonAffect();
            configureLabelDateLastUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            Utils.showAlertDialog("error", "Error Connection API Server", "An error occurred while we attempted connecting to the API Server.");
        }
    }

    public void onClickSubmit(ActionEvent event) {
        if(commentaryTextArea.getText().trim().equals("")){
            Utils.showAlertDialog("info", "Create a commentary without content", "Please write at least a character.");
            return;
        }
        try {
            HttpResponse<String> response = httpClient.sendRequest(
                    "POST",
                    API_SERVER_URI_CREATE_COMMENTARY,
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
            commentaryTextArea.setText("");

        } catch (Exception e) {
            e.printStackTrace();
            Utils.showAlertDialog("error", "Error Connection API Server", "An error occurred while we attempted connecting to the API Server.");
        }
    }

    public void onClickCancel(ActionEvent event) {
        commentaryTextArea.setText("");
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
