<%@ page errorPage = "error.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>	
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql" %>   
<!DOCTYPE html>					  
<html>
<head>
<title>Create new user</title>
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
        SELECT * FROM users where id = ${param.id}; 
    </sql:query>

    <div>
        <fieldset><legend class = "legend">Edit Profile</legend>
           <form action = "saveProfile.jsp" method = "post">
              <table>
                 <tbody>
              <tr style = "background: white;}">
                     <td><label for = "id">Id</label></td><td>
           <input id = "id" name = "id"
            style = "font-size:16px;"
            type = "text" readonly value="${users.rows[0].id}" /></td>
                   </tr>     
                   <tr style = "background: white;}">
                     <td><label for = "first_name">First Name</label></td><td>
           <input id = "first_name" name = "first_name"
            style = "font-size:16px;"
            type = "text" value="${users.rows[0].first_name}" /></td>
                   </tr>
                   <tr style = "background: white;}">
                     <td><label for = "last_name">Last Name</label></td><td>
           <input id = "last_name" name = "last_name"
            style = "font-size:16px;"
            type = "text" value="${users.rows[0].last_name}" /></td>
                   </tr>

                   <tr style = "background: white;}">
                     <td><label for = "email">Email</label></td><td>
           <input id = "email" name = "email"
            style = "font-size:16px;"
            type = "text" value="${users.rows[0].email}" /></td>
                   </tr>
                   <tr style = "background: white;}">
                     <td><label for = "password">Password</label></td><td>
           <input id = "password" name = "password"
            style = "font-size:16px;"
            type = "text" value="${users.rows[0].password}" /></td>
                   </tr>


       <tr style = "background: white;}">
                     <td><label for = "day">day:</label></td><td>
           <input id = "day" name = "day"
            style = "font-size:16px;"
            type = "number"  value="${users.rows[0].birthDay}" /></td>
                                 <td><label for = "month">month:</label></td><td>
           <input id = "month" name = "month"
            style = "font-size:16px;"
            type = "number"  value="${users.rows[0].birthMonth}" /></td>
                                 <td><label for = "year">year:</label></td><td>
           <input id = "year" name = "year"
            style = "font-size:16px;"
            type = "number"  value="${users.rows[0].birthYear}" /></td>
                                             <td><label for = "gender">gender:</label></td><td>
           <input id = "gender" name = "gender"
            style = "font-size:16px;"
            type = "number"  value="${users.rows[0].Gender}" /></td>
                   </tr>
                 </tbody>
              </table>
              <p><input type = "submit" value = " Save edits "/></p>
              <p><a href="${pageContext.request.contextPath}/showUsers.jsp">Back</a></p>
           </form>
        </fieldset>
    </div>
</body>
</html>
