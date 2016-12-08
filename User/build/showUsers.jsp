<%@ page errorPage = "error.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix="sql" %>   

<!DOCTYPE html>					  
<html>
<head>
<title>Bird Users</title>
<link rel = "stylesheet" href = "style.css" type = "text/css"></link>
</head>
<body>

    <sql:setDataSource                    
      var = "myDS"                                           
      driver = "org.postgresql.Driver"
      url = "jdbc:postgresql://localhost:5432/bird_users"
      user = "fred" 
      password = "secret"
    />

    <sql:query var = "users" dataSource = "${myDS}"> 
      SELECT * FROM users ORDER BY id;
    </sql:query>

    <center><h3>Bird Users</h3></center>
    <center>
      <p><a href="${pageContext.request.contextPath}/registerUser.jsp">Create a new User</a></p>
    </center>  
    <div align = "center">
      <table class = "products" border = "1" cellpadding = "5">
        <tr>
	         <th>Id</th>
          <th>First Name</th>
          <th>Last Name</th>
          <th>Email</th>
          <th>Password</th>
          <th>Birth day</th>
          <th>Birth Month</th>
          <th>Birth Year</th>
          <th>Gender</th>
        </tr>
        <c:forEach var = "item" items = "${users.rows}"> 
          <tr>
            <td class = "rght"><c:out value="${item.id}" /></td>
            <td class = "cent"><c:out value="${item.first_name}" /></td>
            <td class = "cent"><c:out value="${item.last_name}" /></td>
            <td class = "cent"><c:out value="${item.email}" /></td>
            <td class = "cent"><c:out value="${item.password}" /></td>
            <td class = "rght"><c:out value="${item.birthDay}" /></td>
            <td class = "rght"><c:out value="${item.birthMonth}" /></td>
            <td class = "rght"><c:out value="${item.birthYear}" /></td>
            <td class = "rght"><c:out value="${item.Gender}" /></td>
  	         <td><a href = "${pageContext.request.contextPath}/showUserProfile.jsp?id=${item.id}">Show User Profile</a></td>
	    <td><a href = "${pageContext.request.contextPath}/editProfile.jsp?id=${item.id}">Edit User Profile</a></td>	
            <td><a href = "${pageContext.request.contextPath}/deleteUser.jsp?id=${item.id}">Delete User</a></td>
          </tr>
        </c:forEach>
      </table>
      <p><a href="${pageContext.request.contextPath}/registerUser.jsp">Create a new User</a></p>	
    </div>
</body>
</html>