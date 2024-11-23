package com.human.web.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.human.web.repository.TripScheduleDAO;
import com.human.web.vo.TripScheduleVO;

@Service
public class TripScheduleServiceImpl implements TripScheduleService {

    @Autowired
    private TripScheduleDAO tripSchedDAO;

    private static final String GOOGLE_MAPS_API_KEY = "AIzaSyAiIs-_C5RuOG0OQB9PNf2bTZPXgb4MMeo";

    @Override
    public void saveTripSchedule(TripScheduleVO tripSchedVO) {
        Integer maxPostId = tripSchedDAO.getMaxPostId();
        int newPostId = (maxPostId != null) ? maxPostId + 1 : 1;

        for (int i = 0; i < tripSchedVO.getDayNumbers().length; i++) {
            TripScheduleVO vo = new TripScheduleVO();
            vo.setM_idx(tripSchedVO.getM_idx());
            vo.setM_email(tripSchedVO.getM_email());
            vo.setM_nickname(tripSchedVO.getM_nickname());
            vo.setTitle(tripSchedVO.getTitle());
            vo.setPeriod_start(tripSchedVO.getPeriod_start());
            vo.setPeriod_end(tripSchedVO.getPeriod_end());
            vo.setPost_id(newPostId);

            vo.setDay_number(tripSchedVO.getDayNumbers()[i]);
            vo.setCity_name(tripSchedVO.getCityNames()[i]);
            vo.setLabel_number(tripSchedVO.getLabelNumbers()[i]);  // Label number 추가
            vo.setPlace_name(tripSchedVO.getPlaceNames()[i]);
            vo.setPlace_address(tripSchedVO.getPlaceAddresses()[i]);
            vo.setPlace_latitude(tripSchedVO.getPlaceLatitudes()[i]);
            vo.setPlace_longitude(tripSchedVO.getPlaceLongitudes()[i]);

            String thumbnail = generateThumbnailUrl(tripSchedVO.getPlaceAddresses()[i]);
            vo.setThumbnail(thumbnail);

            tripSchedDAO.insertTripSchedule(vo);
        }
    }

    private String getLatLongFromAddress(String address) {
        try {
            String url = "https://maps.googleapis.com/maps/api/geocode/json?address=" 
                        + URLEncoder.encode(address, "UTF-8") + "&key=" + GOOGLE_MAPS_API_KEY;

            HttpURLConnection con = (HttpURLConnection) new URL(url).openConnection();
            con.setRequestMethod("GET");

            try (BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()))) {
                StringBuilder response = new StringBuilder();
                String inputLine;
                while ((inputLine = in.readLine()) != null) {
                    response.append(inputLine);
                }

                JSONObject jsonObject = new JSONObject(response.toString());
                if ("OK".equalsIgnoreCase(jsonObject.getString("status"))) {
                    JSONObject location = jsonObject.getJSONArray("results")
                        .getJSONObject(0).getJSONObject("geometry").getJSONObject("location");
                    return location.getDouble("lat") + "," + location.getDouble("lng");
                }
            }
        } catch (Exception e) {
            System.err.println("Error in getLatLongFromAddress: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    private String generateThumbnailUrl(String placeAddress) {
        if (placeAddress == null || placeAddress.isEmpty()) return null;

        String latLong = getLatLongFromAddress(placeAddress);
        if (latLong == null) {
            return null;
        }

        return "https://maps.googleapis.com/maps/api/staticmap?center=" + latLong 
                + "&zoom=14&size=300x200&maptype=roadmap&markers=color:red|" 
                + latLong + "&key=" + GOOGLE_MAPS_API_KEY;
    }

    @Override
    public List<TripScheduleVO> getTripScheduleList() {
        return tripSchedDAO.getTripScheduleList();
    }

    @Override
    public List<TripScheduleVO> getTripScheduleById(int postId) {
        return tripSchedDAO.getTripSchedulesById(postId);
    }
}
