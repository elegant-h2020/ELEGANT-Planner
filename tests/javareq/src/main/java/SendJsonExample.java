import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;

public class SendJsonExample {
    public static void main(String[] args) throws IOException {
        CloseableHttpClient httpClient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost("http://147.102.4.22:5000/planner/schedule");

        // Read the JSON file to a String
        String jsonContent = new String(Files.readAllBytes(Paths.get("input_nes.json")));

        // Set the JSON string as the entity in the POST request
        HttpEntity stringEntity = new StringEntity(jsonContent, ContentType.APPLICATION_JSON);
        httpPost.setEntity(stringEntity);

        CloseableHttpResponse response = httpClient.execute(httpPost);
        System.out.println("Response status: " + response.getStatusLine().getStatusCode());

        // save response content to a file
        HttpEntity responseEntity = response.getEntity();
        if (responseEntity != null) {
            try (InputStream is = responseEntity.getContent();
                 FileOutputStream fos = new FileOutputStream("well_received.json")) {
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = is.read(buffer)) != -1) {
                    fos.write(buffer, 0, bytesRead);
                }
            }
        }
        EntityUtils.consume(responseEntity);
    }
}

