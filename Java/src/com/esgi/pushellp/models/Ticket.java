package com.esgi.pushellp.models;

import javafx.scene.text.Text;

import java.sql.Timestamp;

public class Ticket {
    private int idticket;
    private String title;
    private Timestamp creationdate;
    private Timestamp updatedate;
    private Timestamp deadline;
    private String status;
    private String description;
    private String priority;

    public Ticket(String title, String description){
        this.title = title;
        this.description = description;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
