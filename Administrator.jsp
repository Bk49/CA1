<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import ="java.sql.*"%><!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Administrator</title>
</head>
<body>
<a href="productTable.jsp?page=1">Products</a>
<a href="customerTable.jsp">Customers</a>
<%
int id = 1;
if(request.getParameter("id") != null){
	id = Integer.parseInt(request.getParameter("id"));
}
String name="";
String pwd="";
String email="";
String pfp="";
String address="";
int phoneNo=0;
    try {
           Class.forName("com.mysql.jdbc.Driver");
          String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";

          Connection conn = DriverManager.getConnection(connURL); 

          Statement stmt = conn.createStatement();

          String simpleProc = "{ call getUser(?) }";

          CallableStatement cs = conn.prepareCall(simpleProc);
          cs.setInt(1,id);
          cs.execute();
          ResultSet rs = cs.getResultSet();
          
          if (rs.next()) {
              name = rs.getString("name");
              pwd = rs.getString("pwd");
              email = rs.getString("email");
              pfp = rs.getString("pfp");
              address = rs.getString("address");
              phoneNo = rs.getInt("phoneNo");
          }
        
          conn.close();
     } catch (Exception e) {
        System.err.println("Error :" + e);
     }
%>

<%=name %>
<%=pwd %>
<%=email %>
<%=pfp %>
<%=address %>
<%=phoneNo %>
</body>
</html>