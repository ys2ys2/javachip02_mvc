package com.human.web.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class CustomFunctions {

    public static String formatDate(LocalDateTime date) {
        if (date == null) {
            return "유효하지 않은 날짜";
        }
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return date.format(formatter);
    }
}
