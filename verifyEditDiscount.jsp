<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Editing Discount Code</title>
</head>
<body>
<%
int discountId = Integer.parseInt(request.getParameter("discountId"));
String discountCode = request.getParameter("discountCode");
double discountValue = Double.parseDouble(request.getParameter("discountValue"));
String discountType = request.getParameter("discountType");
int usageLimit = Integer.parseInt(request.getParameter("usageLimit"));
int usageCount = Integer.parseInt(request.getParameter("usageCount"));


int count=0;

    try {
           Class.forName("com.mysql.jdbc.Driver");
           String connURL = "jdbc:mysql://localhost:3306/jad?user=root&password=khyelerk12KL&serverTimezone=UTC";
         // String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";

          Connection conn = DriverManager.getConnection(connURL); 
          String updateStr = "UPDATE discount SET discountCode=?, discountValue=?, discountType=?, usageLimit=?, usageCount=? WHERE discountId=?";         
          
          PreparedStatement pstmt = conn.prepareStatement(updateStr);
          pstmt.setString(1, discountCode);
          pstmt.setDouble(2, discountValue);
          pstmt.setString(3, discountType);
          pstmt.setInt(4, usageLimit);
          pstmt.setInt(5, usageCount);
          pstmt.setInt(6, discountId);
          count = pstmt.executeUpdate();
          conn.close(); 
          out.print(count+" rows updated!");
			response.sendRedirect("successPage.jsp?type=DiscountEdit");

     } catch (Exception e) {
    	out.print("error"+e);
        out.print("An unknown error has occured");
  	  response.sendRedirect("errorPage.jsp");

     }
%>
</body>
</html>