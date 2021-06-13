package com.esgi.pushellp.ticketList;

import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;

import java.net.URL;
import java.util.ResourceBundle;

public class ListViewController implements Initializable {
    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        System.out.println(this);
        FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("/listview.fxml"));

    }
}
