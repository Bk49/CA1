<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Products</title>
</head>
<body>
<h1>Products in the database</h1><br>

<!-- This button will allow the user to add new products into the database -->
<button onClick="window.location.href='addProduct.jsp'">Add new item</button>

<table> <!-- All products will be pushed into this table -->
<tr>
<th>No.</th>
<th>Product Name</th>
<th>Cost Price</th>
<th>Retail Price</th>
<th>Stock Quantity</th>
<th>Category</th>
</tr>
<%
int pg = 1 ;// Integer.parseInt(request.getParameter("page"));
if(request.getParameter("page") != null){
	pg= Integer.parseInt(request.getParameter("page"));
}
int startRow = pg*10-10;

int productId;
String productName;
int count = startRow+1;

double costPrice;
double retailPrice;
int stockQuantity;
String productCategory;
    try {
           Class.forName("com.mysql.jdbc.Driver");
          String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";

          Connection conn = DriverManager.getConnection(connURL); 
          Statement stmt = conn.createStatement();

          String sqlStr = "SELECT productId, productName, costPrice, retailPrice, stockQuantity, productCategory FROM product LIMIT "+startRow+",10";         
          ResultSet rs = stmt.executeQuery(sqlStr);

          while (rs.next()) {
              productId = rs.getInt("productId");
              productName = rs.getString("productName");
              costPrice = rs.getDouble("costPrice");
              retailPrice = rs.getDouble("retailPrice");
              stockQuantity = rs.getInt("stockQuantity");
              productCategory = rs.getString("productCategory");
              
              // Printing all the items in the rs
              out.print("<tr>"+
              "<td>"+count+"<td>"+
              "<td>"+productName+"<td>"+
              "<td>"+costPrice+"<td>"+
              "<td>"+retailPrice+"<td>"+
              "<td>"+stockQuantity+"<td>"+
              "<td>"+productCategory+"<td>"+
              "<td><button onClick=\"window.location.href='editProduct.jsp?productId="+productId+"'\">Edit</button><td>"+
              "<td><button onClick=\"window.location.href='deleteProduct.jsp?productId="+productId+"'\">Delete</button><td>"+
              "</tr>");
              
              count++;
          }
        
          conn.close();
     } catch (Exception e) {
        System.err.println("Error :" + e);
     }
%>
</table>

<!-- Use this button to access to the next 10 rows in the second page -->
<button onClick="window.location.href='productTable.jsp?page=2'">Page 2</button>

</body>
</html>