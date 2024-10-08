package com.human.web.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.human.web.vo.TravelPostVO;



public class TravelPostDAO {
    private DataSource ds;

    public TravelPostDAO() {
        try {
            Context context = new InitialContext();
            ds = (DataSource) context.lookup("java:/comp/env/mysql_dbcp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int savePost(TravelPostVO post) {
        String sql = "INSERT INTO travelposts (topic, title, content, tags) VALUES (?, ?, ?, ?)";
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, post.getTopic());
            ps.setString(2, post.getTitle());
            ps.setString(3, post.getContent());
            ps.setString(4, post.getTags());
            ps.executeUpdate();
            
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // 생성된 postId 반환
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
}
