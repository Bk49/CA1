<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Profile Details</title>
</head>
<body>
<%
int userId = Integer.parseInt(request.getParameter("id"));
   try {
          String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";

          Connection conn = DriverManager.getConnection(connURL); 
          Statement stmt = conn.createStatement();

          String sqlStr = "SELECT name, email, pfp, address, phoneNo FROM member WHERE userId=?";
    
          ResultSet rs;
          
    		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
    		pstmt.setInt(1,userId);
    		rs = pstmt.executeQuery();
    		if(rs.next()){
				out.print("<form action='updateDetails.jsp>"+
    					"<input type='hidden' value='"+userId+"'/>"+
    					"<div><label>Name</label><input type='text' name='name' value='"+rs.getString("name")+"' required></div>"+
    					"<div><label>Email</label><input type='text' name='email' value='"+rs.getString("email")+"' required></div>"+
    					"<div><label>Profile Picture Link or Directory</label><input type='text' name='pfp' value='"+rs.getString("pfp")+"'></div>"+
    					"<div><label>Phone Number</label><input type='number name='phoneNo' value='"+rs.getString("phoneNo")+"'></div>"+
						"<input type='submit' value='Update Profile Details'>"+
    					"</form>");
    		}
    		else{
    			out.print("There is an error retrieving the data from the database!");
    		}
    		
     } catch (Exception e) {
    	 out.print("There is an error connecting to the database!");
     }
%>
</body>
</html>