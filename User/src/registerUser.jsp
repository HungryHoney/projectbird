<%@ page errorPage = "error.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix="sql" %>   
<!DOCTYPE html>					  
<html>
<head>
<title>Register new User</title>
<link rel = "stylesheet" href = "style.css" type = "text/css"></link>
</head>
<body>
    <div>
        <fieldset><legend class="legend">Registration</legend>
           <form action = "${pageContext.request.contextPath}/save.jsp" method = "post">
              <table>
                 <tbody>
                   <tr style = "background: white;}">
                     <td><label for = "first_name">First Name</label></td><td>
		       <input id = "first_name" name = "first_name"
			      style = "font-size:16px;"
			      type = "text"/></td>
                   </tr>
                   <tr style = "background: white;}">
                     <td><label for = "last_name">Last Name</label></td><td>
           <input id = "last_name" name = "last_name"
            style = "font-size:16px;"
            type = "text"/></td>
                   </tr>

                   <tr style = "background: white;}">
                     <td><label for = "email">Email</label></td><td>
           <input id = "email" name = "email"
            style = "font-size:16px;"
            type = "text"/></td>
                   </tr>
                   <tr style = "background: white;}">
                     <td><label for = "password">Password</label></td><td>
           <input id = "password" name = "password"
            style = "font-size:16px;"
            type = "text"/></td>
                   </tr>


		   <tr style = "background: white;}">
                     <td><label for = "day">day:</label></td><td>
		       <input id = "day" name = "day"
			      style = "font-size:16px;"
			      type = "number" /></td>
                                 <td><label for = "month">month:</label></td><td>
           <input id = "month" name = "month"
            style = "font-size:16px;"
            type = "number" /></td>
                                 <td><label for = "year">year:</label></td><td>
           <input id = "year" name = "year"
            style = "font-size:16px;"
            type = "number" /></td>
                                             <td><label for = "gender">gender:</label></td><td>
           <input id = "gender" name = "gender"
            style = "font-size:16px;"
            type = "number" /></td>
                   </tr>
                 </tbody>
              </table>
              <p><input type="submit" value=" Create user "/></p>
           </form>
           <p><a href = "${pageContext.request.contextPath}/showUsers.jsp">Back</a></p>        
        </fieldset>
    </div>
</body>
</html>
