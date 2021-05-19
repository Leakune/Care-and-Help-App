package com.esgi.pushellp.connection;

import com.esgi.pushellp.ConnectBdd;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.KeySpec;
import java.sql.*;
import java.util.Base64;
import java.util.Date;
import java.util.ResourceBundle;

public class ConnectionController implements Initializable {
    private static final int ITERATION_COUNT = 65536;
    private static final int KEY_LENGTH = 128;
    private static final String ALGORITHME = "PBKDF2WithHmacSHA1";
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

        try {
            if(isRegistered(pwdPasswordField.getText(), findUserDataByLogin(loginTextField.getText()))){
                System.out.println("you are registered");
            }else{
                System.out.println("you are not registered");
            }
        } catch (NoSuchAlgorithmException | InvalidKeySpecException | SQLException e) {
            e.printStackTrace();
        }
    }

    private ResultSet findUserDataByLogin(String login) throws SQLException {
        prepStmt = connection.prepareStatement("SELECT * FROM individual WHERE pseudo = ?;");
        prepStmt.setString(1, login);
        rs = prepStmt.executeQuery();
        System.out.println(rs);
        rs.next();
        //System.out.println(rs);
        return rs;
    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        System.out.println("Hello World");
        try {
            connection = (Connection) new ConnectBdd().getConnection();
            stmt = connection.createStatement();
            System.out.println("Successfully connecting to database:");

        } catch (SQLException | ClassNotFoundException throwables) {
            System.out.println("Error connecting to database:");
            throwables.printStackTrace();
        }
    }

    public Boolean isRegistered(String password, ResultSet userData) throws NoSuchAlgorithmException, InvalidKeySpecException, SQLException {
        //generate random salt
        //String saltString = generateSaltString();
        //userData.next();
        String saltString = userData.getString("salt");
        System.out.println("saltString:" + saltString);

        String hashString = userData.getString("password");
        System.out.println("hashString:" + hashString);

        String hash = generateHash(saltString, password);
        System.out.println("hash: " + hash);
        if(hash.equals(hashString)){
            return true;
        }else{
            return false;
        }


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
