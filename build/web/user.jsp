<%-- 
    Document   : user
    Created on : Jan 22, 2026, 10:42:09 AM
    Author     : ADMIN
--%>

<%@page import="fa26.t3s2.users.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Page</title>
    </head>
    <body>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if(loginUser == null || !"US".equals(loginUser.getRoleID())){
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        UserID: <%=loginUser.getUserID()%> </br>
        Fullname: <%=loginUser.getFullName()%>  </br>
        RoleID: <%=loginUser.getRoleID()%> </br>
        Password: <%=loginUser.getPassword()%> </br>
        <form action="MainController" method="POST">
            <input type="submit" name="action" value="Logout"/>
        </form>
        <a href="MainController?action=Shopping">Đi tới trang mua sắm</a>
    </body>
</html>
