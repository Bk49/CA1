<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Discount Codes</title>
</head>
<body>
<h1>Discount Codes in the database</h1>

<!-- This button will allow the user to add new discount codes into the database -->
<button onClick="window.location.href='addDiscount.jsp'">Add new discount code</button>

<table><!-- All discount code will be pushed into this table -->
<tr>
<th>No.</th>
<th>Discount Code</th>
<th>Discount Price</th>
<th>Discount Amount</th>
<th>Usage Limit</th>
<th>Number of uses</th>
</tr>
<%
int pg=1;
if(request.getParameter("page")!=null){
	pg=Integer.parseInt(request.getParameter("page"));
}
int startRow = pg*10-10;
int count = startRow+1;
String discountPrice;
double discountValue;
String discountType;
try {
    Class.forName("com.mysql.jdbc.Driver");
   String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";

   Connection conn = DriverManager.getConnection(connURL); 
   Statement stmt = conn.createStatement();

   String sqlStr = "SELECT * FROM discount LIMIT "+startRow+",10";         
   ResultSet rs = stmt.executeQuery(sqlStr);

   while (rs.next()) {       
	   discountValue = rs.getDouble("discountValue");
	   discountType = rs.getString("discountType");
	   if(discountType == "DIRECT"){
		   discountPrice = "$"+String.format("%.2f",discountValue);
	   }else{
		   discountPrice = String.format("%.2f",discountValue)+"%";
	   }
       // Printing all the items in the rs
       out.print("<tr>"+
       "<td>"+count+"<td>"+
       "<td>"+rs.getString("discountCode")+"<td>"+
       "<td>"+discountPrice+"<td>"+
       "<td>"+rs.getInt("usageLimit")+"<td>"+
       "<td>"+rs.getInt("usageCount")+"<td>"+
       "<td><button onClick=\"window.location.href='editDiscount.jsp?discountId="+rs.getInt("discountId")+"'\">Edit</button><td>"+
       "<td><button onClick=\"window.location.href='deleteDiscount.jsp?discountId="+rs.getInt("discountId")+"'\">Delete</button><td>"+
       "</tr>");
       
       count++;
   }
 
   conn.close();
} catch (Exception e) {
 System.err.println("Error :" + e);
}
%>
</table>
</body>
</html>