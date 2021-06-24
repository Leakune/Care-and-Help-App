package com.esgi.pushellp.createTicket;

import com.esgi.pushellp.OurHttpClient;
import com.esgi.pushellp.commun.Utils;
import com.esgi.pushellp.models.Individual;
import com.esgi.pushellp.models.Ticket;
import com.esgi.pushellp.ticketList.TicketListController;
import com.google.gson.Gson;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;

import java.net.URL;
import java.net.http.HttpResponse;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class CreateTicketController implements Initializable {
    public static final String IN_PROGRESS = "En cours";
    private static final String API_SERVER_URI = "http://0.0.0.0:3000/createTicket";

    private HashMap<String, String> headers;
    private HashMap<Object, Object> bodyRequest;
    private Gson gson = new Gson();

    private TicketListController ticketListController;
    private Scene ticketListScene;
    private Individual user;
    @FXML
    AnchorPane createTicketRoot;
    @FXML
    Label labelUser2;
    @FXML
    private Label dateToday;
    @FXML
    private TextArea descriptionTextArea;
    @FXML
    private ComboBox priorityComboBox;
    @FXML
    private TextField titleTextField;
    @FXML
    private DatePicker deadlineDatePicker;


    public void setTicketListScene(Scene scene){
        ticketListScene = scene;
    }
    public void setTicketListController(TicketListController controller){
        ticketListController = controller;
    }
    public void setIndividual(Individual individual) {
        user = individual;
    }

    public void openTicketListScene(ActionEvent event){
        ticketListController.updateLabelAndChoiceBoxTicket(IN_PROGRESS);
        ticketListController.setIndividual(user);

        List<Ticket> tickets = Utils.getTicketListByStatus("en_cours");
        ticketListController.initObservableListTicketList(tickets);
        Stage primaryStage = (Stage)((Node)event.getSource()).getScene().getWindow();
        primaryStage.setScene(ticketListScene);
    }
    public void updateLabel(String text){
        labelUser2.setText(text);
    }
    @FXML
    public void onClickSubmit(ActionEvent event) {
        System.out.println("button submit clicked");
        System.out.println("Date: " + dateToday.getText());
        System.out.println("Titre: " + titleTextField.getText());
        System.out.println("Deadline: " + deadlineDatePicker.getValue());
        System.out.println("Priorite: " + priorityComboBox.getValue());
        System.out.println("Description: " + descriptionTextArea.getText());

        OurHttpClient httpClient = new OurHttpClient();
        try {
            HttpResponse<String> response = httpClient.sendRequest(
                    "POST",
                    API_SERVER_URI,
                    headers = new HashMap<>(Map.ofEntries(
                            new AbstractMap.SimpleEntry<String, String>("Content-Type", "application/x-www-form-urlencoded")
                    )),
                    bodyRequest = new HashMap<>(Map.ofEntries(
                            new AbstractMap.SimpleEntry<Object, Object>("title", titleTextField.getText()),
                            new AbstractMap.SimpleEntry<Object, Object>("deadline", deadlineDatePicker.getValue()),
                            new AbstractMap.SimpleEntry<Object, Object>("priority", priorityComboBox.getValue()),
                            new AbstractMap.SimpleEntry<Object, Object>("description", titleTextField.getText()),
                            new AbstractMap.SimpleEntry<Object, Object>("idUser", user.getIdindividual())
                    ))
            );
            if(response.statusCode() != 200){
                Utils.showAlertDialog("error", "Error creating the ticket", "Please ask to the administrators of the api-server");
                return;
            }
            Utils.showAlertDialog("success", "Successfully creating the ticket", "You have created a new ticket!");
            openTicketListScene(event);
        } catch (Exception e) {
            e.printStackTrace();
            Utils.showAlertDialog("error","Error Connection API Server", "An error occurred while we attempted connecting to the API Server.");
        }
    }
    @FXML
    public void onClickCancel(ActionEvent event) {
        System.out.println("button cancel clicked");
        openTicketListScene(event);
    }
    // Factory to create Cell of DatePicker
//    private Callback<DatePicker, DateCell> getDayCellFactory() {
//
//        final Callback<DatePicker, DateCell> dayCellFactory = new Callback<DatePicker, DateCell>() {
//
//            @Override
//            public DateCell call(final DatePicker datePicker) {
//                return new DateCell() {
//                    @Override
//                    public void updateItem(LocalDate item, boolean empty) {
//                        super.updateItem(item, empty);
//
//                        // Disable all past dates
//                        LocalDate today = LocalDate.now();
//                        setDisable(empty || item.compareTo(today) < 0);
//                    }
//                };
//            }
//        };
//        return dayCellFactory;
//    }

    private void addTextLimiter(final TextInputControl tf, final int maxLength) {
        tf.textProperty().addListener((ov, oldValue, newValue) -> {
            if (tf.getText().length() > maxLength) {
                String s = tf.getText().substring(0, maxLength);
                tf.setText(s);
            }
        });
    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        //set dateToday configuration
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        LocalDateTime now = LocalDateTime.now();
        String dateTodayString = dtf.format(now);
        dateToday.setText(dateTodayString);

        //set title texfield configuration
        addTextLimiter(titleTextField, 100);

        //set date deadline configuration
        deadlineDatePicker.setValue(LocalDate.now());
//        deadlineDatePicker.getEditor().setDisable(true);
//        deadlineDatePicker.getEditor().setOpacity(1);
//        Callback<DatePicker, DateCell> dayCellFactory= this.getDayCellFactory();
//        deadlineDatePicker.setDayCellFactory(dayCellFactory);

        //set comboBox configuration
        ObservableList<String> priorityList = FXCollections.observableArrayList("basse", "moyen", "élevé");
        priorityComboBox.setValue("basse");
        priorityComboBox.setItems(priorityList);

        //set textArea configuration
        descriptionTextArea.setWrapText(true);
        addTextLimiter(descriptionTextArea, 1500);

    }
}
