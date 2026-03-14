<%-- 
    Document   : viewCart
    Created on : Mar 3, 2026, 8:09:14 AM
    Author     : hoadoan
--%>

<%@page import="fa26.t3s2.shopping.Product"%>
<%@page import="fa26.t3s2.shopping.Cart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Cart Page</title>
    </head>
    <body>
        <h1>My shopping cart !!</h1>
        
        <%
            Cart cart = (Cart) session.getAttribute("CART");
            if (cart != null && cart.getCart().size() > 0) {
        %>
        <table border="1">
            <thead>
                <tr>
                    <th>No</th>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                    <th>Edit</th>
                    <th>Remove</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int count = 1;
                    double total = 0;
                    for (Product product : cart.getCart().values()) {
                        total += product.getQuantity() * product.getPrice();
                %>
            <form action="MainController" method="POST">
                <tr>
                    <td><%= count++%></td>
                    <td>
                        <input type="text" name="id" value="<%= product.getId()%>" readonly=""/>
                    </td>
                    <td><%= product.getName()%></td>
                    <td><%= product.getPrice()%>$</td>
                    <td>
                        <input type="number" name="quantity" value="<%= product.getQuantity()%>" required="" min="1"/>
                    </td>
                    <td><%= product.getQuantity() * product.getPrice()%>$</td>
                    <td>
                        <input type="submit" name="action" value="Edit"/>
                    </td>
                    <td><input type="submit" name="action" value="Remove"/></td>
                </tr>
            </form>
            <%
                }
            %>

        </tbody>
    </table>
    <h1> Total: <%= total%>$</h1>
    <%
    } else {
    %>
    <%=" Your shopping cart is empty !!!"%>
    <%
        }
    %>



    <%
        String message = (String) request.getAttribute("MESSAGE");
        if (message == null) {
            message = "";
        }
        String error = (String) request.getAttribute("ERROR");
        if (error == null)
            error = "";
    %>

    <% if (!message.isEmpty()) {%>
    <h3><%= message%></h3>
    <% } %>

    <% if (!error.isEmpty()) {%>
    <h3><%= error%></h3>
    <% }%>

    <form action="MainController" method="POST">
            <input type="submit" name="action" value="CheckOut"/>
    </form>
    <a href="MainController?action=Shopping">Mua thêm di!!!</a>
</body>
</html>
