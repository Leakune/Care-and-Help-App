package com.esgi.pushellp.detailTicket;

import com.esgi.pushellp.models.Commentary;
import com.esgi.pushellp.models.Individual;
import com.esgi.pushellp.models.Ticket;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.control.Label;
import javafx.scene.control.TextArea;
import javafx.scene.layout.VBox;

import java.io.IOException;

public class CommentaryController {
    @FXML
    public Label labelUser;
    @FXML
    public Label labelDateCreation;
    @FXML
    public TextArea commentarySample;
    @FXML
    public VBox VBoxCommentarySample;

    public CommentaryController(){
        FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("Commentary.fxml"));
        fxmlLoader.setController(this);
        try
        {
            fxmlLoader.load();
        }
        catch (IOException e)
        {
            throw new RuntimeException(e);
        }
    }
    public void setInfo(Commentary commentary, Individual user)
    {
        labelUser.setText(user.getPseudo());
        labelDateCreation.setText(commentary.getDatecreation().toString());
        commentarySample.setText(commentary.getText());
    }

    public VBox getBox()
    {
        return VBoxCommentarySample;
    }
}
