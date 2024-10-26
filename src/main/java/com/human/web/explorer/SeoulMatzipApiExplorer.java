package com.human.web.explorer;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Component
public class SeoulMatzipApiExplorer {
    public static <T extends Object> T getApiJsonData(String srcUrl, TypeReference<T> dto) 
    		throws IOException, URISyntaxException {
    	        
        URL url = new URI(srcUrl).toURL();
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        
        StringBuilder sb = new StringBuilder();
        while (true) {
        	String line = rd.readLine();
        	
        	if(line == null) break;	
        	
            sb.append(line);
        }
        
        rd.close();
        conn.disconnect();
        

        // ObjectMapper 생성
        ObjectMapper objectMapper = new ObjectMapper();
        T data = objectMapper.readValue(sb.toString(), dto);
        
        return data;
    }
}