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
	//String parseId = request.getParameter("id");
	//if(parseId != null){
	//	id = Integer.parseInt(parseId); 
	//}
	if(session.getAttribute("userId")!=null){
	id = (int)session.getAttribute("userId");
	}
	
	if(id>0){
		String pfp="/images/u101.png";
		    try {

		           Class.forName("com.mysql.jdbc.Driver");
		          String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
		          
		          Connection conn = DriverManager.getConnection(connURL); 
		          Statement stmt = conn.createStatement();
		          
		          String sqlStr = "SELECT pfp FROM user WHERE userId="+id;         
		          ResultSet rs = stmt.executeQuery(sqlStr);
		          if (rs.next()) {
		              pfp = rs.getString("pfp");
		              out.print("<a href='profilePage.jsp'><img src='"+pfp+"' alt='userPfp'></a>");
		          }
		        
		          conn.close();
		     } catch (Exception e) {
		        System.err.println("Error :" + e);
		     }
	}else{
		out.print("<a href='Login.jsp'><img src='/images/u101.png' alt='defaultImage'></a>");
	}
%>
<br>
<%
	try {

    	Class.forName("com.mysql.jdbc.Driver");
   		String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
   
   		Connection conn = DriverManager.getConnection(connURL); 
   		Statement stmt = conn.createStatement();
   
   		String sqlStr = "SELECT productId,productName, costPrice, imageLocation FROM jad.product ORDER BY RAND() LIMIT 10";         
   		ResultSet rs = stmt.executeQuery(sqlStr);
   		while (rs.next()) {
   			out.print("<a href='ProductDetail.jsp?productId="+rs.getInt("productId")+"'>"+
   					"<img src='"+rs.getString("imageLocation")+"'>"+
   					"<div>"+rs.getString("productName")+"<div>"+
   					"<div>"+String.format("%.2f",rs.getDouble("costPrice"))+"<div>"+
   					"</a>");
   		}
 
   		conn.close();
	} catch (Exception e) {
 	System.err.println("Error :" + e);
	}
%>
</body>
</html>