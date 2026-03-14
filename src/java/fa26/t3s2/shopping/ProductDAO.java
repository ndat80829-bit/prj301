/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fa26.t3s2.shopping;

/**
 *
 * @author jayke
 */
import fa26.t2s2.utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    private static final String GET_INFO = "SELECT pid, name, price, quantity FROM Product";

    public List<Product> getAllProduct() throws SQLException {
    List<Product> list = new ArrayList<>();
    Connection conn = null;
    PreparedStatement ptm = null;
    ResultSet rs = null;
    try {
        conn = DBUtils.getConnectionV1();
        if (conn != null) {
            
            ptm = conn.prepareStatement(GET_INFO);
            rs = ptm.executeQuery();
            while (rs.next()) {
                String id = rs.getString("pid");
                String name = rs.getString("name");
                double price = rs.getDouble("price");
                int quantity = rs.getInt("quantity");
                list.add(new Product(id, name, price, quantity));
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (ptm != null) ptm.close();
        if (conn != null) conn.close();
    }
    return list;
}
}
