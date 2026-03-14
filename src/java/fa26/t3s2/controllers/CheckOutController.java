/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package fa26.t3s2.controllers;

import fa26.t3s2.shopping.Cart;
import fa26.t3s2.shopping.OrderDAO;
import fa26.t3s2.users.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author jayke
 */
@WebServlet(name = "CheckOutController", urlPatterns = {"/CheckOutController"})
public class CheckOutController extends HttpServlet {

    private static final String VIEW_CART = "viewCart.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = VIEW_CART;
        try {
            // 2. Kiểm tra session
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("LOGIN_USER") == null) {
                request.setAttribute("ERROR", "Vui lòng đăng nhập trước khi thanh toán!");
            } else {
                // 3. Kiểm tra giỏ hàng
                Cart cart = (Cart) session.getAttribute("CART");
                if (cart == null || cart.getCart().isEmpty()) {
                    request.setAttribute("ERROR", "Giỏ hàng của bạn đang trống!");
                } else {
                    // 4. Kiểm tra kho (Giả sử bạn đã viết hàm checkInventory trong ProductDAO)
                    // gọi thẳng bước 5 nếu kho đủ
                    OrderDAO dao = new OrderDAO();
                    UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
                    boolean check = dao.insertOrder(user.getUserID(), cart);

                    if (check) {
                        // 6. Xoá giỏ hàng & thông báo
                        session.removeAttribute("CART");
                        request.setAttribute("MESSAGE", "Thanh toán thành công!");
                    } else {
                        request.setAttribute("ERROR", "Thanh toán thất bại, vui lòng thử lại!");
                    }
                }
            }
        } catch (Exception e) {
            log("Error at CheckOutController: " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
