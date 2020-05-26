<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Adding Discount Code</title>
</head>
<body>
<%
String discountCode = request.getParameter("discountCode");
double discountValue = Double.parseDouble(request.getParameter("discountValue"));
String discountType = request.getParameter("discountType");
int usageLimit = Integer.parseInt(request.getParameter("usageLimit"));

String insertStr = "INSERT INTO discount (discountCode, discountValue, discountType, usageLimit) VALUES(?,?,?,?)";

int count = 0;

try{
	  Class.forName("com.mysql.jdbc.Driver");
	//String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
    String connURL = "jdbc:mysql://localhost:3306/jad?user=root&password=khyelerk12KL&serverTimezone=UTC";

    Connection conn = DriverManager.getConnection(connURL); 
    
	PreparedStatement pstmt = conn.prepareStatement(insertStr);
    pstmt.setString(1, discountCode);
    pstmt.setDouble(2, discountValue);
    pstmt.setString(3, discountType);
    pstmt.setInt(4, usageLimit);
    count = pstmt.executeUpdate();
    conn.close(); 

    out.print(count+" row inserted");
	  response.sendRedirect("successPage.jsp?type=DiscountAdded");

}catch(Exception e){
	out.print("An error has occured");
	  response.sendRedirect("errorPage.jsp");

}
%>
</body>
</html>