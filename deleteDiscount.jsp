<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Deleting discount code</title>
</head>
<body>
<%
int discountId = Integer.parseInt(request.getParameter("discountId"));
String name;
    try {
           Class.forName("com.mysql.jdbc.Driver");
          String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";

          Connection conn = DriverManager.getConnection(connURL); 
          Statement stmt = conn.createStatement();

          String sqlStr = "SELECT discountCode, discountValue, discountType, usageLimit, usageCount FROM discount WHERE discountId="+discountId;         
          ResultSet rs = stmt.executeQuery(sqlStr);

          if (rs.next()) {
			out.print("<div><h1>Are you sure you want to delete this discount code?</h1>"+
          			"<div>"+rs.getString("discountCode")+"</div>"+
          			"<div>"+String.format("%.2f",rs.getDouble("discountValue"))+"</div>"+
          			"<div>"+rs.getString("discountType")+"</div>"+
          			"<div>"+rs.getString("usageLimit")+"</div>"+
          			"<div>"+rs.getString("usageCount")+"</div>"+
					"</div>");
          }
        
          conn.close();
     } catch (Exception e) {
        System.err.println("Error :" + e);
     }
%>
<button onClick="window.location.href='verifyDeleteDiscount.jsp?discountId=<%=discountId %>'">Confirm Delete!</button>
</body>
</html>