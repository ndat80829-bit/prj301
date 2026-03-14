<%-- 
    Document   : admin
    Created on : Jan 22, 2026, 10:46:08 AM
    Author     : ADMIN
--%>

<%@page import="fa26.t3s2.users.UserDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrator Page</title>
    </head>
    <body>
       
        <c:set var="user" value="${sessionScope.LOGIN_USER}" />
        <c:if test="${empty user || user.roleID ne 'AD'}">
            <c:redirect url="login.jsp" />
        </c:if>

        <h1>Welcome: <c:out value="${user.fullName}" /></h1>

        
        <c:url var="logoutLink" value="MainController">
            <c:param name="action" value="Logout" />
        </c:url>
        <a href="${logoutLink}">Logout JSTL</a><br/>

        <hr/>


        <form action="MainController" method="GET">
            Search: <input type="text" name="search" value="<c:out value="${param.search}"/>" />
            <input type="submit" name="action" value="Search" />
        </form>


        <c:if test="${not empty requestScope.LIST_USER}">
            <table border="1">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>User ID</th>
                        <th>Full Name</th>
                        <th>Role ID</th>
                        <th>Password</th>
                        <th>Update</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="u" items="${requestScope.LIST_USER}" varStatus="counter">
                    <form action="MainController" method="POST">
                        <tr>
                            <td>${counter.count}</td>
                            <td>
                                <input type="text" name="userID" value="${u.userID}" readonly />
                            </td>
                            <td>
                                <input type="text" name="fullName" value="<c:out value="${u.fullName}"/>" required />
                            </td>
                            <td>
                                <input type="text" name="roleID" value="${u.roleID}" required />
                            </td>
                            <td>${u.password}</td>
                            <td>
                                <input type="hidden" name="search" value="<c:out value="${param.search}"/>" />
                                <input type="submit" name="action" value="Update" />
                            </td>
                            <td>
                                <c:url var="deleteLink" value="MainController">
                                    <c:param name="action" value="Delete" />
                                    <c:param name="userID" value="${u.userID}" />
                                    <c:param name="search" value="${param.search}" />
                                </c:url>
                                <a href="${deleteLink}" onclick="return confirm('Are you sure?')">Delete</a>
                            </td>
                        </tr>
                    </form>
                </c:forEach>
            </tbody>
        </table>
    </c:if>


    <h3 style="color: red;">${requestScope.ERROR}</h3>

</body>
</html>
