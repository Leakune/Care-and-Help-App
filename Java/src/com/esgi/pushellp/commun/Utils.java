package com.esgi.pushellp.commun;

import com.esgi.pushellp.OurHttpClient;
import com.esgi.pushellp.models.Commentary;
import com.esgi.pushellp.models.Individual;
import com.esgi.pushellp.models.Ticket;
import com.google.gson.*;
import javafx.scene.control.Alert;

import java.net.http.HttpResponse;
import java.util.*;

public class Utils {
    private static final String API_SERVER_URI_GET_TICKET = "http://0.0.0.0:3000/getTicketListByStatus";
    private static final String API_SERVER_URI_GET_COMMENTARY = "http://0.0.0.0:3000/getCommentaryListByIdTicket";
    private static final String API_SERVER_URI_GET_INDIVIDUAL = "http://0.0.0.0:3000/getIndividualById";

    public static void showAlertDialog(String type, String title, String content){
        Alert alert = type.equals("error") ? new Alert(Alert.AlertType.ERROR) : new Alert(Alert.AlertType.INFORMATION);
        alert.setTitle(title);
        alert.setHeaderText(null);
        alert.setContentText(content);
        alert.showAndWait();
    }

    public static List<Ticket> getTicketListByStatus(String status){
        HashMap<String, String> headers;
        HashMap<Object, Object> bodyRequest;
        Gson gson = new Gson();
        OurHttpClient httpClient = new OurHttpClient();
        List<Ticket> ticketList = new ArrayList<Ticket>();
        try {
            HttpResponse<String> response = httpClient.sendRequest(
                    "GET",
                    API_SERVER_URI_GET_TICKET,
                    headers = new HashMap<>(Map.ofEntries(
                            new AbstractMap.SimpleEntry<String, String>("Content-Type", "application/x-www-form-urlencoded")
                    )),
                    bodyRequest = new HashMap<>(Map.ofEntries(
                            new AbstractMap.SimpleEntry<Object, Object>("status", status)
                    ))
            );
            if(response.statusCode() != 200){
                return ticketList;
            }
            JsonObject convertedObject = new GsonBuilder().setDateFormat("YYYY-MM-DD HH:mm:ss").create().fromJson(response.body(), JsonObject.class);
            int sizeData = convertedObject.get("body").getAsJsonObject().get("data").getAsJsonArray().size();
            for (int i = 0; i < sizeData; i++) {
                JsonElement data = convertedObject.get("body").getAsJsonObject().get("data").getAsJsonArray().get(i);
                ticketList.add(gson.fromJson(data, Ticket.class));
            }
            return ticketList;

        } catch (Exception e) {
            Utils.showAlertDialog("error", "Error Connection API Server", "An error occurred while we attempted connecting to the API Server.");
        }
        return null;
    }
    public static List<Commentary> getCommentaryListByIdTicket(int idTicket){
        HashMap<String, String> headers;
        HashMap<Object, Object> bodyRequest;
        Gson gson = new Gson();
        OurHttpClient httpClient = new OurHttpClient();
        List<Commentary> commentaryList = new ArrayList<>();
        try {
            HttpResponse<String> response = httpClient.sendRequest(
                    "GET",
                    API_SERVER_URI_GET_COMMENTARY,
                    headers = new HashMap<>(Map.ofEntries(
                            new AbstractMap.SimpleEntry<String, String>("Content-Type", "application/x-www-form-urlencoded")
                    )),
                    bodyRequest = new HashMap<>(Map.ofEntries(
                            new AbstractMap.SimpleEntry<Object, Object>("idTicket", idTicket)
                    ))
            );
            JsonObject convertedObject = new GsonBuilder().setDateFormat("YYYY-MM-DD HH:mm:ss").create().fromJson(response.body(), JsonObject.class);
            int sizeData = convertedObject.get("body").getAsJsonObject().get("data").getAsJsonArray().size();
            for (int i = 0; i < sizeData; i++) {
                JsonElement data = convertedObject.get("body").getAsJsonObject().get("data").getAsJsonArray().get(i);
                commentaryList.add(gson.fromJson(data, Commentary.class));
            }
            return commentaryList;

        } catch (Exception e) {
            Utils.showAlertDialog("error", "Error Connection API Server", "An error occurred while we attempted connecting to the API Server.");
        }
        return null;
    }
    public static Individual getIndividualById(int idUser){
        HashMap<String, String> headers;
        HashMap<Object, Object> bodyRequest;
        Gson gson = new Gson();
        OurHttpClient httpClient = new OurHttpClient();
        try {
            HttpResponse<String> response = httpClient.sendRequest(
                    "GET",
                    API_SERVER_URI_GET_INDIVIDUAL,
                    headers = new HashMap<>(Map.ofEntries(
                            new AbstractMap.SimpleEntry<String, String>("Content-Type", "application/x-www-form-urlencoded")
                    )),
                    bodyRequest = new HashMap<>(Map.ofEntries(
                            new AbstractMap.SimpleEntry<Object, Object>("idUser", idUser)
                    ))
            );
            JsonObject convertedObject = new GsonBuilder().setDateFormat("YYYY-MM-DD HH:mm:ss").create().fromJson(response.body(), JsonObject.class);

            Individual indvdl = gson.fromJson(convertedObject.get("body").getAsJsonObject().get("data").getAsJsonArray().get(0), Individual.class);
            return indvdl;

        } catch (Exception e) {
            Utils.showAlertDialog("error", "Error Connection API Server", "An error occurred while we attempted connecting to the API Server.");
        }
        return null;
    }
}
