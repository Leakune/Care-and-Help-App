package com.esgi.pushellp;

import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;

public class OurHttpClient {
    private final HttpClient httpClient = HttpClient.newBuilder()
            .version(HttpClient.Version.HTTP_2)
            .build();

    /**
     * method to send http requests into our api server
     * @param http: our type of http request (e.g "GET", "POST",...)
     * @param uri: the url of our api server with an endpoint
     * @param headers: the headers passed in our request (e.g "Content-Type": "application/x-www-form-urlencoded")
     * @param bodyRequest: the content body passed in our request (e.g {"username": "value", "password" : "value"})
     * @throws Exception
     */
    public HttpResponse<String> sendRequest(String http, String uri, HashMap<String, String> headers, HashMap<Object, Object> bodyRequest) throws Exception {

        HttpRequest.Builder builder =  HttpRequest.newBuilder();
        if(http.equals("GET")){
            builder.GET();
        }else if(http.equals("POST")){
            builder.POST(buildFormDataFromMap(bodyRequest));
        }
        builder.uri(URI.create(uri));
        for (HashMap.Entry<String, String> mapEntry : headers.entrySet()) {
            builder.header(mapEntry.getKey(), mapEntry.getValue());
        }
        HttpRequest request = builder.build();

        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

        // print status code
        System.out.println(response.statusCode());

        // print response body
        System.out.println(response.body());
        return response;

    }

    /**
     * method to convert our bodyRequest into a HttpRequest.BodyPublisher, which will be sent in our request
     * @param data: our bodyRequest
     * @return HttpRequest.BodyPublisher: flow of byte buffers
     */
    public static HttpRequest.BodyPublisher buildFormDataFromMap(HashMap<Object, Object> data) {
        var builder = new StringBuilder();
        for (HashMap.Entry<Object, Object> entry : data.entrySet()) {
            if (builder.length() > 0) {
                builder.append("&");
            }
            builder.append(URLEncoder.encode(entry.getKey().toString(), StandardCharsets.UTF_8));
            builder.append("=");
            builder.append(URLEncoder.encode(entry.getValue().toString(), StandardCharsets.UTF_8));
        }
        return HttpRequest.BodyPublishers.ofString(builder.toString());
    }
}
