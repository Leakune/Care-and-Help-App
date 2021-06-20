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

    public Ticket(int idticket, String title, Timestamp creationdate, Timestamp updatedate, Timestamp deadline, String status, String description, String priority) {
        this.idticket = idticket;
        this.title = title;
        this.creationdate = creationdate;
        this.updatedate = updatedate;
        this.deadline = deadline;
        this.status = status;
        this.description = description;
        this.priority = priority;
    }

    @Override
    public String toString() {
        return "Ticket{" +
                "idticket=" + idticket +
                ", title='" + title + '\'' +
                ", creationdate=" + creationdate +
                ", updatedate=" + updatedate +
                ", deadline=" + deadline +
                ", status='" + status + '\'' +
                ", description='" + description + '\'' +
                ", priority='" + priority + '\'' +
                '}';
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
