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
    private int individual_idindividual;
    private String application_platformapplication;

    public Ticket(int idticket,
                  String title,
                  Timestamp creationdate,
                  Timestamp updatedate,
                  Timestamp deadline,
                  String status,
                  String description,
                  String priority,
                  int individual_idindividual,
                  String application_platformapplication)
    {
        this.idticket = idticket;
        this.title = title;
        this.creationdate = creationdate;
        this.updatedate = updatedate;
        this.deadline = deadline;
        this.status = status;
        this.description = description;
        this.priority = priority;
        this.individual_idindividual = individual_idindividual;
        this.application_platformapplication = application_platformapplication;
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
                ", individual_idindividual='" + individual_idindividual + '\'' +
                ", application_idapplication='" + application_platformapplication + '\'' +
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

    public int getIdticket() {
        return idticket;
    }

    public void setIdticket(int idticket) {
        this.idticket = idticket;
    }

    public Timestamp getCreationdate() {
        return creationdate;
    }

    public void setCreationdate(Timestamp creationdate) {
        this.creationdate = creationdate;
    }

    public Timestamp getUpdatedate() {
        return updatedate;
    }

    public void setUpdatedate(Timestamp updatedate) {
        this.updatedate = updatedate;
    }

    public Timestamp getDeadline() {
        return deadline;
    }

    public void setDeadline(Timestamp deadline) {
        this.deadline = deadline;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public int getIndividual_idindividual() {
        return individual_idindividual;
    }

    public void setIndividual_idindividual(int individual_idindividual) {
        this.individual_idindividual = individual_idindividual;
    }

    public String getApplication_platformapplication() {
        return application_platformapplication;
    }

    public void setApplication_platformapplication(String application_platformapplication) {
        this.application_platformapplication = application_platformapplication;
    }
}
