<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Category</title>
</head>
<body>
<!-- Testing for this page's query has not been done yet -->
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
String category;
    try {

           
          String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
          
          Connection conn = DriverManager.getConnection(connURL); 
          Statement stmt = conn.createStatement();

          String sqlStr = "SELECT DISTINCT productCategory FROM product";         
          ResultSet rs = stmt.executeQuery(sqlStr);

          while (rs.next()) {
              category = rs.getString("productCategory");
              
              // Style this line of code!
              out.print("<a href='ProductListing.jsp?category="+category+"'>"+category.toUpperCase()+"</a><br>");
          }
        
          conn.close();
     } catch (Exception e) {
        out.print("Error :" + e);
     }
%>
</body>
</html>