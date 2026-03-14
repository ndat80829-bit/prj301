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

public class OrderDAO {

    public boolean insertOrder(String userID, Cart cart) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptmOrder = null;
        PreparedStatement ptmDetail = null;
        PreparedStatement ptmUpdateQty = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnectionV1();
            if (conn != null) {
                conn.setAutoCommit(false); 

                // 5.1 Thêm vào bảng Orders
                String sqlOrder = "INSERT INTO Orders(date, total, userID) VALUES(GETDATE(), ?, ?)";
                ptmOrder = conn.prepareStatement(sqlOrder, PreparedStatement.RETURN_GENERATED_KEYS);
                double total = 0;
                for (Product p : cart.getCart().values()) {
                    total += p.getPrice() * p.getQuantity();
                }
                ptmOrder.setDouble(1, total);
                ptmOrder.setString(2, userID);
                ptmOrder.executeUpdate();

                // Lấy oid vừa tạo
                rs = ptmOrder.getGeneratedKeys();
                int oid = -1;
                if (rs.next()) {
                    oid = rs.getInt(1);
                }

                // 5.2 Thêm vào OrderDetail & 5.3 Cập nhật kho
                
                String sqlDetail = "INSERT INTO OrderDetail(oid, pid, price, quantity) VALUES(?, ?, ?, ?)";
                String sqlUpdateQty = "UPDATE Product SET quantity = quantity - ? WHERE pid = ?";
                ptmDetail = conn.prepareStatement(sqlDetail);
                ptmUpdateQty = conn.prepareStatement(sqlUpdateQty);

                for (Product p : cart.getCart().values()) {
                    // Thêm chi tiết
                    ptmDetail.setInt(1, oid);
                    ptmDetail.setInt(2, Integer.parseInt(p.getId()));
                    ptmDetail.setDouble(3, p.getPrice());
                    ptmDetail.setInt(4, p.getQuantity());
                    ptmDetail.executeUpdate();

                    // Trừ số lượng kho
                    ptmUpdateQty.setInt(1, p.getQuantity());
                    ptmUpdateQty.setInt(2, Integer.parseInt(p.getId()));
                    ptmUpdateQty.executeUpdate();
                }
                conn.commit(); 
                check = true;
            }
        } catch (Exception e) {
            if (conn != null) {
                conn.rollback();
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }
}
