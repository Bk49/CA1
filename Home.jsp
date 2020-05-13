<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home</title>
</head>
<body>
<%
	int id = 0;
	String parseId = request.getParameter("id");
	if(parseId != null){
		id = Integer.parseInt(parseId); 
	}
	
	if(id>0){
		String pfp="/images/u101.png";
		    try {

		           Class.forName("com.mysql.jdbc.Driver");
		          String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
		          
		          Connection conn = DriverManager.getConnection(connURL); 
		          Statement stmt = conn.createStatement();
		          
		          String sqlStr = "SELECT pfp FROM user WHERE id="+id;         
		          ResultSet rs = stmt.executeQuery(sqlStr);
		          if (rs.next()) {
		              pfp = rs.getString("pfp");
		              out.print("<a href='profilePage.jsp?id="+id+"'><img src='"+pfp+"' alt='userPfp'></a>");
		          }
		        
		          // Step 7: Close connection
		          conn.close();
		     } catch (Exception e) {
		        System.err.println("Error :" + e);
		     }
	}else{
		out.print("<a href='Login.jsp'><img src='/images/u101.png' alt='defaultImage'></a>");
	}
%>
<%
	
%>
</body>
</html>