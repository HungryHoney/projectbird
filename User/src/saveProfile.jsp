<%@ page errorPage = "error.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>	
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql"  prefix = "sql" %>   
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt"  prefix = "fmt" %>

<!DOCTYPE html>					  
<html>
  <head>
    <title>Users</title>
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
    
    <sql:update dataSource = "${myDS}" var = "result">
      UPDATE users SET first_name = ?, 
                         last_name = ?,
                         email = ?,
                         password = ?,
                         birthDay = ${param.day},
                         birthMonth = ${param.month},
                         birthYear = ${param.year},
                         gender = ${param.gender}
                         where id = ${param.id};
      <sql:param value = "${param.first_name}"/>
      <sql:param value = "${param.last_name}"/>
      <sql:param value = "${param.email}"/>
      <sql:param value = "${param.password}"/>
    </sql:update>
    
    <c:if test = "${result >= 1}">
      <div class = "goodSave">
	<center>Profile was successfully edited</center>
	<center><a href = "${pageContext.request.contextPath}/showUsers.jsp">Back</a></center>                
      </div>
    </c:if>
  </body>
</html>
