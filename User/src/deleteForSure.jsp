<%@ page errorPage = "error.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>	
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql" %>   
<!DOCTYPE html>					  
<html>
<head>
<title>Delete the user</title>
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
    <sql:update dataSource = "${myDS}" var = "count">
       DELETE FROM users WHERE id = '${param.id}';
    </sql:update>
    <c:if test = "${count >= 1}">
      <div class = "goodSave">
       <center>User deleted</center>
       <center><a href="${pageContext.request.contextPath}/showUsers.jsp">Back</a></center>                
    </c:if>
</body>
</html>