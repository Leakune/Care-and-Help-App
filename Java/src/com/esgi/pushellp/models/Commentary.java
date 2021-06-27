package com.esgi.pushellp.models;

import java.sql.Timestamp;

public class Commentary {
    private int idcommentary;
    private String text;
    private Timestamp datecreation;
    private int individual_idindividual;
    private int ticket_idticket;

    public Commentary(int idcommentary, String text, Timestamp datecreation, int individual_idindividual, int ticket_idticket) {
        this.idcommentary = idcommentary;
        this.text = text;
        this.datecreation = datecreation;
        this.individual_idindividual = individual_idindividual;
        this.ticket_idticket = ticket_idticket;
    }

    @Override
    public String toString() {
        return "Commentary{" +
                "idcommentary=" + idcommentary +
                ", text='" + text + '\'' +
                ", datecreation=" + datecreation +
                ", individual_idindividual=" + individual_idindividual +
                ", ticket_idticket=" + ticket_idticket +
                '}';
    }

    public int getIdcommentary() {
        return idcommentary;
    }

    public void setIdcommentary(int idcommentary) {
        this.idcommentary = idcommentary;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public Timestamp getDatecreation() {
        return datecreation;
    }

    public void setDatecreation(Timestamp datecreation) {
        this.datecreation = datecreation;
    }

    public int getIndividual_idindividual() {
        return individual_idindividual;
    }

    public void setIndividual_idindividual(int individual_idindividual) {
        this.individual_idindividual = individual_idindividual;
    }

    public int getTicket_idticket() {
        return ticket_idticket;
    }

    public void setTicket_idticket(int ticket_idticket) {
        this.ticket_idticket = ticket_idticket;
    }
}
