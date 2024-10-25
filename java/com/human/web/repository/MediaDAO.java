package com.human.web.repository;


import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.human.web.vo.MediaVO;

public class MediaDAO {
    private DataSource ds;

    public MediaDAO() {
        try {
            Context context = new InitialContext();
            ds = (DataSource) context.lookup("java:/comp/env/mysql_dbcp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void saveMedia(MediaVO media) {
        String sql = "INSERT INTO media (postId, fileName, filePath) VALUES (?, ?, ?)";
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, media.getPostId());
            ps.setString(2, media.getFileName());
            ps.setString(3, media.getFilePath());
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
