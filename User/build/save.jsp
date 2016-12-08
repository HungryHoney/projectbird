<%@ page errorPage = "error.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix="sql" %>   
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
     
    <c:if test="${empty param.first_name or empty param.last_name or empty param.email or empty param.password}">
       <c:redirect url = "registerUser.jsp" >
          <c:param name = "errMsg" value = "Please enter last name, first name, password, email." />
       </c:redirect>
    </c:if>
 
    <sql:update dataSource = "${myDS}" var = "result">
       INSERT INTO users(first_name, last_name, email, password, birthDay, birthMonth, birthYear, gender) VALUES 
       ('<%= request.getParameter("first_name") %>', 
       '<%= request.getParameter("last_name") %>', 
       '<%= request.getParameter("email") %>', 
       '<%= request.getParameter("password") %>', 
         <%= request.getParameter("day") %>,
         <%= request.getParameter("month") %>,
         <%= request.getParameter("year") %>,
         <%= request.getParameter("gender") %>);
    </sql:update>
           
    <c:if test = "${result >= 1}">
      <div class ="goodSave">
       <center>User registrated!</center>
       <center><a href = "${pageContext.request.contextPath}/showUsers.jsp">Back</a></center>                
      </div>
    </c:if>
</body>
</html>