package com.esgi.pushellp.createTicket;

import com.esgi.pushellp.connection.ConnectionController;
import com.esgi.pushellp.models.Individual;
import com.esgi.pushellp.ticketList.TicketListController;
import javafx.beans.Observable;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.geometry.Side;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;
import javafx.util.Callback;

import java.io.IOException;
import java.net.URL;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ResourceBundle;
import java.util.function.UnaryOperator;

public class CreateTicketController implements Initializable {
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
        ticketListController.setIndividual(user);
        Stage primaryStage = (Stage)((Node)event.getSource()).getScene().getWindow();
        primaryStage.setScene(ticketListScene);
    }
    public void updateLabel(String text){
        labelUser2.setText(text);
    }
    @FXML
    public void onClickSubmit(ActionEvent event) {
        System.out.println("button submit clicked");
        openTicketListScene(event);
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
//        tf.textProperty().addListener(new ChangeListener<String>() {
//            @Override
//            public void changed(final ObservableValue<? extends String> ov, final String oldValue, final String newValue) {
//                if (tf.getText().length() > maxLength) {
//                    String s = tf.getText().substring(0, maxLength);
//                    tf.setText(s);
//                }
//            }
//        });
//        UnaryOperator<TextFormatter.Change> rejectChange = c -> {
//            // check if the change might effect the validating predicate
//            if (c.isContentChange()) {
//                // check if change is valid
//                if (c.getControlNewText().length() > maxLength) {
//                    // invalid change
//                    // sugar: show a context menu with error message
//                    final ContextMenu menu = new ContextMenu();
//                    menu.getItems().add(new MenuItem("This field takes\n"+len+" characters only."));
//                    menu.show(c.getControl(), Side.BOTTOM, 0, 0);
//                    // return null to reject the change
//                    return null;
//                }
//            }
//            // valid change: accept the change by returning it
//            return c;
//        };
    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        //set dateToday configuration
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        LocalDateTime now = LocalDateTime.now();
        String dateTodayString = dtf.format(now);
        dateToday.setText(dateTodayString);

        //set title texfield configuration
//        addTextLimiter(titleTextField, 100);

        //set date deadline configuration
        deadlineDatePicker.setValue(LocalDate.now());
//        deadlineDatePicker.getEditor().setDisable(true);
//        deadlineDatePicker.getEditor().setOpacity(1);
        // Factory to create Cell of DatePicker
//        Callback<DatePicker, DateCell> dayCellFactory= this.getDayCellFactory();
//        deadlineDatePicker.setDayCellFactory(dayCellFactory);

        //set comboBox configuration
        ObservableList<String> priorityList = FXCollections.observableArrayList("basse", "moyen", "élevé");
        priorityComboBox.setValue("basse");
        priorityComboBox.setItems(priorityList);

        //set textArea configuration
        descriptionTextArea.setWrapText(true);
//        addTextLimiter(descriptionTextArea, 1500);

    }
}
