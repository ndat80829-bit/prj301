<%-- 
    Document   : login
    Created on : Jan 19, 2026, 11:14:23 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login page</title>
    </head>
    <body>
        <h1>LOGIN PAGE</h1>
        
        <form action="MainController" method="POST">
            User ID: <input type="text" name="userID" required=""/> </br>
            Password: <input type="password" name="password" required=""/> </br>
            <input type="submit" name="action" value="Login"/> 
            <input type="reset" value="Reset"/>
        </form>
        
        <%
            String errorMsg = (String) request.getAttribute("ERROR_MESSAGE");
            if(errorMsg == null) errorMsg="";
        %>
        <%= errorMsg%>
        
    </body>
</html>
