<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>All Products</title>
</head>
<body>
<%
if(session.getAttribute("userId") == null){
	out.print("<a href='Login.jsp'><img src='/images/u101.png' alt='defaultImage'></a>");
}
else{
	int userId = (int)session.getAttribute("userId");
	String pfp;
	Class.forName("com.mysql.jdbc.Driver");
	 try {
        String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
        
        Connection conn = DriverManager.getConnection(connURL); 
        Statement stmt = conn.createStatement();
        
        String sqlStr = "SELECT pfp FROM user WHERE userId=?";
        
        ResultSet rs;
        
  		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
  		pstmt.setInt(1,userId);
  		rs = pstmt.executeQuery();
  		if(rs.next()){
  			out.print("<a href='profilePage.jsp'><img src='"+rs.getString("pfp")+"' alt='defaultImage'></a>");
  		}else{
  			out.print("<a href='Login.jsp'><img src='/images/u101.png' alt='defaultImage'></a>");
		}
   } catch (Exception e) {
      System.err.println("Error :" + e);
   }
}
String category = request.getParameter("category");
if(category == null) category = "%";
    try {
          Class.forName("com.mysql.jdbc.Driver");
          String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";

          Connection conn = DriverManager.getConnection(connURL); 
          Statement stmt = conn.createStatement();

          String sqlStr = "SELECT productId, productName, briefDescription, costPrice, retailPrice, imageLocation FROM product WHERE productCategory LIKE ?";         
          ResultSet rs;
          
          PreparedStatement pstmt = conn.prepareStatement(sqlStr);
          pstmt.setString(1,category);
  		  rs = pstmt.executeQuery();

          while (rs.next()) {
				out.print(
						"<a href='ProductDetail.jsp?productId="+rs.getInt("productId")+"'><div>"+
						"<img src='"+rs.getString("imageLocation")+"'>"+
						"<div>"+rs.getString("productName")+"</div>"+
						"<div>"+rs.getString("briefDescription")+"</div>"+
						"<div>$"+String.format("%.2f",rs.getDouble("costPrice"))+"</div>"+
						"<div>$"+String.format("%.2f",rs.getDouble("retailPrice"))+"</div>"+
						"</div></a>"
						);
          }
        
          conn.close();
     } catch (Exception e) {
        System.err.println("Error :" + e);
     }
%>
</body>
</html>