package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.model.MenuItem;
import com.util.DBConnection;

public class MenuDAOImpl implements MenuDAO {

    Connection con = DBConnection.getConnection();

    @Override
    public List<MenuItem> getAllItems() {

        List<MenuItem> list = new ArrayList<>();

        try {
            String sql = "SELECT * FROM menu_items";
            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                MenuItem item = new MenuItem();

                item.setItemId(rs.getInt("item_id"));
                item.setItemName(rs.getString("item_name"));
                item.setPrice(rs.getDouble("price"));
                item.setCategory(rs.getString("category"));
                item.setAvailable(rs.getString("available"));

                list.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
