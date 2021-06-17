package com.esgi.pushellp.commun;

import javafx.scene.control.Alert;

public class Utils {
    public static void showAlertDialog(String type, String title, String content){
        Alert alert = type.equals("error") ? new Alert(Alert.AlertType.ERROR) : new Alert(Alert.AlertType.INFORMATION);
        alert.setTitle(title);
        alert.setHeaderText(null);
        alert.setContentText(content);
        alert.showAndWait();
    }
}
