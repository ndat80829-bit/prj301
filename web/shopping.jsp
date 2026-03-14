<%-- 
    Document   : shopping
    Created on : Mar 3, 2026, 7:27:00 AM
    Author     : hoadoan
--%>

<%@page import="fa26.t3s2.shopping.Product"%>
<%@page import="fa26.t3s2.users.UserDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shopping Page</title>
    </head>
    <body>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (loginUser == null) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>

        <h1>Welcome to our Store: <%= loginUser.getFullName() %></h1>
        <a href="MainController?action=Logout">Logout</a> | 
        <a href="viewCart.jsp">View Your Cart</a>
        <br/><br/>

        <%
            List<Product> listProduct = (List<Product>) request.getAttribute("LIST_PRODUCT");
            if (listProduct != null && !listProduct.isEmpty()) {
        %>
        <table border="1">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Product ID</th>
                    <th>Product Name</th>
                    <th>Price</th>
                    <th>Quantity in Stock</th>
                    <th>Buy Quantity</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int count = 1;
                    for (Product product : listProduct) {
                %>
                <form action="MainController" method="POST">
                    <tr>
                        <td><%= count++ %></td>
                        <td>
                            <%= product.getId() %>
                            <input type="hidden" name="id" value="<%= product.getId() %>"/>
                        </td>
                        <td>
                            <%= product.getName() %>
                            <input type="hidden" name="name" value="<%= product.getName() %>"/>
                        </td>
                        <td>
                            $<%= product.getPrice() %>
                            <input type="hidden" name="price" value="<%= product.getPrice() %>"/>
                        </td>
                        <td><%= product.getQuantity() %></td>
                        <td>
                            <input type="number" name="cmbQuantity" value="1" min="1" max="<%= product.getQuantity() %>" required="">
                        </td>
                        <td>
                            <input type="submit" name="action" value="Add">
                        </td>
                    </tr>
                </form>
                <%
                    }
                %>
            </tbody>
        </table>
        <%
            } else {
                String error = (String) request.getAttribute("ERROR_MESSAGE");
                if (error == null) error = "No products available at the moment.";
        %>
        <h3><%= error %></h3>
        <%
            }
        %>

        
        <p>
            <% 
                String msg = (String) request.getAttribute("MESSAGE"); 
                if(msg != null) out.print(msg);
            %>
        </p>
    </body>
</html>
