package com.esgi.pushellp.connection;

import com.esgi.pushellp.OurHttpClient;
import com.esgi.pushellp.ticketList.TicketListController;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import java.net.URL;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.KeySpec;
import java.sql.*;
import java.util.*;

public class ConnectionController implements Initializable {
    private static final int ITERATION_COUNT = 65536;
    private static final int KEY_LENGTH = 128;
    private static final String ALGORITHME = "PBKDF2WithHmacSHA1";
    private static final String API_SERVER_URI = "http://0.0.0.0:3000/login";
    private HashMap<String, String> headers;
    private HashMap<Object, Object> bodyRequest;

    private Connection connection;
    private Statement stmt;
    private PreparedStatement prepStmt;
    private ResultSet rs;



    @FXML
    private TextField loginTextField;

    @FXML
    private PasswordField pwdPasswordField;

    @FXML
    public void onClickSubmit(ActionEvent event){
        System.out.println("button clicked");
        System.out.println("Texfield: " + loginTextField.getText());
        System.out.println("PasswordField: " + pwdPasswordField.getText());

        OurHttpClient httpClient = new OurHttpClient();
        try {
            HttpResponse<String> response = httpClient.sendRequest(
                    "POST",
                    API_SERVER_URI,
                    headers = new HashMap<>(Map.ofEntries(
                            //new AbstractMap.SimpleEntry<String, String>("User-Agent", "Java 11 HttpClient Bot"),
                            new AbstractMap.SimpleEntry<String, String>("Content-Type", "application/x-www-form-urlencoded")
                    )),
                    bodyRequest = new HashMap<>(Map.ofEntries(
                            new AbstractMap.SimpleEntry<Object, Object>("username", loginTextField.getText()),
                            new AbstractMap.SimpleEntry<Object, Object>("password", pwdPasswordField.getText())
                    ))
            );
            if(response.statusCode() != 200){
                showAlertDialogError("Error finding your profile", "You have given a wrong username and/or password");
                return;
            }
            System.out.println("Connected!");
            TicketListController ticketListController = new TicketListController(this);
            ticketListController.showStage();
        } catch (Exception e) {
            e.printStackTrace();
            showAlertDialogError("Error Connection API Server", "An error occurred while we attempted connecting to the API Server.");
        }

//        try {
//            if(isRegistered(pwdPasswordField.getText(), findUserDataByLogin(loginTextField.getText()))){
//                System.out.println("you are registered");
//            }else{
//                System.out.println("you are not registered");
//            }
//        } catch (NoSuchAlgorithmException | InvalidKeySpecException | SQLException e) {
//            e.printStackTrace();
//        }
    }
    public void showAlertDialogError(String title, String content){
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle(title);
        alert.setHeaderText(null);
        alert.setContentText(content);
        alert.showAndWait();
    }
    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        System.out.println("Hello World");
    }

    public String generateSaltString(){
        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[16];
        random.nextBytes(salt);
        return Base64.getEncoder().encodeToString(salt);
    }
//    public String findSaltStringFromDb(String login){
//
//    };

    public String generateHash(String saltString, String password) throws NoSuchAlgorithmException, InvalidKeySpecException {
        //convert String > byte[]
        byte[] salt = saltString.getBytes(StandardCharsets.ISO_8859_1);

        //implementing PBKDF2 algorithm hash
        KeySpec spec = new PBEKeySpec(password.toCharArray(), salt, ITERATION_COUNT, KEY_LENGTH);
        SecretKeyFactory factory = SecretKeyFactory.getInstance(ALGORITHME);

        //generate hash password
        byte[] hash = factory.generateSecret(spec).getEncoded();
        Base64.Encoder enc = Base64.getEncoder();

//        String saltString = enc.encodeToString(salt);
//        System.out.println("salt: " + saltString);

        String hashString = enc.encodeToString(hash);
//        System.out.println("hash: " + hashString);
//
//        System.out.println("hash-length: " + hashString.length());
//
//        System.out.println(new Date());

        return hashString;
    }

}
