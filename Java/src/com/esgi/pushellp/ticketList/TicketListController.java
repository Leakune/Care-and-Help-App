package com.esgi.pushellp.ticketList;

import com.esgi.pushellp.commun.Utils;
import com.esgi.pushellp.connection.ConnectionController;
import com.esgi.pushellp.createTicket.CreateTicketController;
import com.esgi.pushellp.detailTicket.DetailTicketController;
import com.esgi.pushellp.models.Individual;
import com.esgi.pushellp.models.Ticket;
import javafx.application.Platform;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.geometry.Pos;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.Background;
import javafx.scene.layout.BackgroundFill;
import javafx.scene.layout.Pane;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.text.Text;
import javafx.stage.Stage;
import javafx.util.Callback;

import java.awt.*;
import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.ResourceBundle;


public class TicketListController implements Initializable {
    public static final String TO_DO = "Nouveau";
    public static final String IN_PROGRESS = "En cours";
    public static final String DONE = "Terminé";
    private Individual user;
    private Scene createTicketScene;
    private Scene detailTicketScene;
    private CreateTicketController createTicketController;
    private DetailTicketController detailTicketController;
    private ObservableList<Ticket> tickets;
    private List<Ticket> listTickets;

    @FXML
    private Label labelUser;
    @FXML
    private VBox listTicketVBox;
    @FXML
    private Button addButton;
    @FXML
    private ChoiceBox choiceBox;
    @FXML
    private Label labelStateTicketList;
    @FXML
    private ListView listView;


    @FXML
    protected void onClickAddButton(ActionEvent event){
        System.out.println("add button clicked");
        openCreateTicketScene(event);
    }

    public void updateLabel(String text){
        labelUser.setText(text);
    }
    public void updateLabelAndChoiceBoxTicket(String text){
        labelStateTicketList.setText(text);
        choiceBox.setValue(text);
    }

    public void initObservableListTicketList(List<Ticket> listTickets){
        this.listTickets = new ArrayList<>(listTickets);
        this.tickets = FXCollections.observableArrayList(this.listTickets);
        //listTicketVBox.getChildren().setAll(listView);
        listView.setItems(this.tickets);
        listView.setCellFactory((Callback<ListView<Ticket>, ListCell<Ticket>>) listView -> {
            TicketCell cell = new TicketCell();
            cell.setOnMouseClicked(mouseEvent -> openDetailTicketScene(mouseEvent, cell.getTicketData()));
            return cell;
        });
    }
    public void updateTicketList(List<Ticket> listTickets){
        this.tickets = FXCollections.observableArrayList(listTickets);
        listView.setItems(null);
        listView.setItems(this.tickets);
        listView.setCellFactory((Callback<ListView<Ticket>, ListCell<Ticket>>) listView -> {
            TicketCell cell = new TicketCell();
            cell.setOnMouseClicked(mouseEvent -> openDetailTicketScene(mouseEvent, cell.getTicketData()));
            return cell;
        });
        listView.refresh();
    }

    public void setIndividual(Individual individual) {
        user = individual;
    }
    public void setCreateTicketScene(Scene createTicketScene) {
        this.createTicketScene = createTicketScene;
    }
    public void setCreateTicketController(CreateTicketController controller){
        createTicketController = controller;
    }
    public void setDetailTicketScene(Scene detailTicketScene) {
        this.detailTicketScene = detailTicketScene;
    }

    public void setDetailTicketController(DetailTicketController detailTicketController) {
        this.detailTicketController = detailTicketController;
    }

    public void openCreateTicketScene(ActionEvent event) {
        createTicketController.setIndividual(user);
        createTicketController.updateLabel(user.getPseudo());
        Stage primaryStage = (Stage)((Node)event.getSource()).getScene().getWindow();
        primaryStage.setScene(createTicketScene);
    }
    public void openDetailTicketScene(MouseEvent event, Ticket ticket) {
        detailTicketController.setTicket(ticket);
        detailTicketController.setIndividual(user);
        Stage primaryStage = (Stage)((Node)event.getSource()).getScene().getWindow();
        primaryStage.setScene(detailTicketScene);
    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        /* comboBox */
        ObservableList<String> statusListTicket //
                = FXCollections.observableArrayList(TO_DO, IN_PROGRESS, DONE);

        choiceBox.setItems(statusListTicket);
        choiceBox.setValue(IN_PROGRESS);
        //
        ChangeListener<String> changeListener = (observable, oldValue, newValue) -> {
            if (newValue != null) {
                if(newValue.equals(TO_DO)){
                    updateTicketList(Utils.getTicketListByStatus("nouveau"));
                    labelStateTicketList.setText(TO_DO);
                }else if(newValue.equals(IN_PROGRESS)){
                    updateTicketList(Utils.getTicketListByStatus("en_cours"));
                    labelStateTicketList.setText(IN_PROGRESS);
                }else if(newValue.equals(DONE)){
                    updateTicketList(Utils.getTicketListByStatus("terminé"));
                    labelStateTicketList.setText(DONE);
                }
            }
        };
        // Selected Item Changed.
        choiceBox.getSelectionModel().selectedItemProperty().addListener(changeListener);

    }
}
