package com.human.web.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.human.web.vo.TravelMediaVO;

import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.name.Rename;

@Component
public class FileManager {

    // 파일 업로드 처리
    public TravelMediaVO handleFile(MultipartFile file, HttpServletRequest request) {
        // 1. 저장 디렉터리에 저장할 새로운 파일명 만들기
        String originFileName = file.getOriginalFilename(); // 원본 파일명 가져오기
        String ext = originFileName.substring(originFileName.lastIndexOf(".")); // 파일 확장자 추출
        String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date()); // 저장 파일명 만들기
        String saveFileName = now + ext; // 저장 파일명

        // 2. 지정된 경로에 파일 저장하기
        String saveDirectory = request.getServletContext().getRealPath("resources/uploads/");
        System.out.println("파일 저장 경로: " + saveDirectory);
        String fullPath = saveDirectory + saveFileName;

        try {
            file.transferTo(new File(fullPath)); // 지정된 경로에 파일 저장
        } catch (Exception e) {
            System.out.println("파일 저장 중 예외 발생: " + e.getMessage());
        }

        // 3. 파일 관련 값들을 TravelMediaVO에 저장
        TravelMediaVO mediaVO = new TravelMediaVO();
        mediaVO.setOrigin_filename(originFileName);
        mediaVO.setSave_filename(saveFileName);
        mediaVO.setFile_type(file.getContentType());
        mediaVO.setFile_size(file.getSize());

        // 이미지 파일인 경우 섬네일을 만들어 저장소에 함께 저장함
        if (ext.equalsIgnoreCase(".png") || ext.equalsIgnoreCase(".jpg") || ext.equalsIgnoreCase(".gif")) {
            String extFormat = ext.substring(1); // 확장자명에서 점(.) 제거
            saveThumbnail(fullPath, extFormat);
        }

        return mediaVO; // TravelMediaVO 반환
    }

    // 섬네일로 이미지 파일 저장하기
    private void saveThumbnail(String fullPath, String extFormat) {
        try {
            Thumbnails.of(new File(fullPath))
                    .size(120, 90) // 섬네일 크기
                    .outputFormat(extFormat) // 포맷 형식
                    .toFiles(Rename.PREFIX_HYPHEN_THUMBNAIL); // 새로운 이름: thumbnail-이 파일명 앞에 붙음
        } catch (Exception e) {
            System.out.println("섬네일 저장 중 예외 발생: " + e.getMessage());
        }
    }
    
    // 파일 다운로드 처리
    public void download(String originFilename, String saveFilename, HttpServletRequest request,
                         HttpServletResponse response) {
        try {
            // 파일이 저장된 경로 설정
            String saveDirectory = request.getServletContext().getRealPath("resources/uploads/");
            File file = new File(saveDirectory, saveFilename);

            // 파일이 존재하지 않으면 처리
            if (!file.exists()) {
                throw new RuntimeException("파일을 찾을 수 없습니다.");
            }

            // 한글 파일명 깨짐 방지 처리 (브라우저마다 다르게 처리)
            String client = request.getHeader("User-Agent");
            if (client.indexOf("WOW64") == -1) { // 인터넷 익스플로러
                originFilename = new String(originFilename.getBytes("UTF-8"), "ISO-8859-1");
            } else { // 그 외 브라우저
                originFilename = new String(originFilename.getBytes("KSC5601"), "ISO-8859-1");
            }

            // 파일 다운로드를 위한 응답 헤더 설정
            response.reset();
            response.setContentType("application/octet-stream"); // 파일 다운로드 MIME 타입 설정
            response.setHeader("Content-Disposition", "attachment; filename=\"" + originFilename + "\"");
            response.setHeader("Content-Length", "" + file.length());

            // 파일을 읽어서 클라이언트에게 전송
            try (InputStream in = new FileInputStream(file);
                 OutputStream out = response.getOutputStream()) {

                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = in.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
                out.flush();
            }

        } catch (Exception e) {
            System.out.println("파일 다운로드 중 오류 발생: " + e.getMessage());
        }
    }

}
