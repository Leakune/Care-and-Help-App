package com.esgi.pushellp.models;

import java.sql.Date;
import java.sql.Timestamp;

public class Individual {
    private int idindividual;
    private String pseudo;
    private String password;
    private String email;
    private Timestamp birthday;
    private String status;
    private String salt;
    private Timestamp registerdate;

    public Individual(int idindividual, String pseudo, String password, String email, Timestamp birthday, String status, String salt, Timestamp registerdate) {
        this.idindividual = idindividual;
        this.pseudo = pseudo;
        this.password = password;
        this.email = email;
        this.birthday = birthday;
        this.status = status;
        this.salt = salt;
        this.registerdate = registerdate;
    }

    public int getIdindividual() {
        return idindividual;
    }

    public void setIdindividual(int idindividual) {
        this.idindividual = idindividual;
    }

    public String getPseudo() {
        return pseudo;
    }

    public void setPseudo(String pseudo) {
        this.pseudo = pseudo;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Timestamp getBirthday() {
        return birthday;
    }

    public void setBirthday(Timestamp birthday) {
        this.birthday = birthday;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public Timestamp getRegisterdate() {
        return registerdate;
    }

    public void setRegisterdate(Timestamp registerdate) {
        this.registerdate = registerdate;
    }

    @Override
    public String toString() {
        return "Individual{" +
                "idIndividual=" + idindividual +
                ", pseudo='" + pseudo + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                ", birthday=" + birthday +
                ", status='" + status + '\'' +
                ", salt='" + salt + '\'' +
                ", registerDate=" + registerdate +
                '}';
    }
}
