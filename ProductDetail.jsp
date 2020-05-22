<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./CSS/productDetail.css">
</head>
<body>


<nav class="navbar navbar-expand-lg navbar-custom navbar-dark ">
 		 <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
   			 <span class="navbar-toggler-icon"></span>
 		 </button>
		  <div class="collapse navbar-collapse" id="navbarSupportedContent">
  		  <ul class="navbar-nav mr-auto">
    		  <li class="nav-item active">
    		    <a class="nav-link" href="Home.jsp">Home <span class="sr-only">(current)</span></a>
    		  </li>
    		  <li class="nav-item dropdown">
    		    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
   		       Categories
    		    </a>
   		     <div class="dropdown-menu" aria-labelledby="navbarDropdown">
   		     <%
String category;
    try {

           
          //String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
          String connURL = "jdbc:mysql://localhost:3306/jad?user=root&password=khyelerk12KL&serverTimezone=UTC";

          Connection conn = DriverManager.getConnection(connURL); 
          Statement stmt = conn.createStatement();

          String sqlStr = "SELECT DISTINCT productCategory FROM product";         
          ResultSet rs = stmt.executeQuery(sqlStr);

          while (rs.next()) {
              category = rs.getString("productCategory");
              
              // Style this line of code!
              out.print("<a href='ProductListing.jsp?category="+category+"' class='dropdown-item'>"+category.toUpperCase()+"</a><br>");
          }
        
          conn.close();
     } catch (Exception e) {
        out.print("Error :" + e);
     }
%>
    		 </div>
  		    </li>
 		   </ul>
   		 <form class="form-inline my-2 my-lg-0">
   		   <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
    		  <button class="btn btn-warning my-2 my-sm-0" type="submit">Search</button>
         </form>
   		 <ul  class="navbar-nav mr-right dropleft" style="margin-left:20px" >
         		 <li class="nav-item dropdown ">
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
		         // String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
		          String connURL = "jdbc:mysql://localhost:3306/jad?user=root&password=khyelerk12KL&serverTimezone=UTC";

		          Connection conn = DriverManager.getConnection(connURL); 
		          Statement stmt = conn.createStatement();
		          
		          String sqlStr = "SELECT pfp FROM user WHERE userId="+id;         
		          ResultSet rs = stmt.executeQuery(sqlStr);
		          if (rs.next()) {
		              pfp = rs.getString("pfp");
		              out.print("<a href='nav-link dropdown-toggle ' style='margin:0px' href='#' id='navbarDropdown' role='button' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'><img src='."+pfp+"' alt='userPfp' width=\"auto\" height=\"60px\"></a>");
		              out.print("<div class='dropdown-menu' aria-labelledby='navbarDropdown'>" +
		   		       "<a class='dropdown-item' href='profilePage.jsp'>Profile</a>" +
					   "<div class='dropdown-divider'></div>" +
				   	   "<a class='dropdown-item' href='logout.jsp'>Log Out</a>" +
		    		 "</div>");
		          }
		        
		          conn.close();
		     } catch (Exception e) {
		        System.err.println("Error :" + e);
		     }
	}else{
		out.print("<a class=\"nav-link\" href='Login.jsp'>LOGIN</a>");
	}
%>

     		 </li>
      	</ul>   
  </div>
</nav>
<%
String productId = request.getParameter("productId");

   try {
       Class.forName("com.mysql.jdbc.Driver");
       //String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
       String connURL = "jdbc:mysql://localhost:3306/jad?user=root&password=khyelerk12KL&serverTimezone=UTC";
       
          Connection conn = DriverManager.getConnection(connURL); 
          Statement stmt = conn.createStatement();

          String sqlStr = "SELECT * FROM product WHERE productId=?";
    	  ResultSet rs;
          
    		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
    		pstmt.setString(1,productId);
    		rs = pstmt.executeQuery();
    		
       		out.print("<div class=\"container \">");
       		out.print("<div class=\"row \">");
    		if(rs.next()){
				out.print(
						"<div class=\"col-4 \">"+
						"<h2 class=\"text-warning\">"+rs.getString("productName")+"</h2>" +
					    "<img src='."+rs.getString("imageLocation")+"' class=\"productImg\" alt='productImage'>"+
						"</div>" +
					   	"<div class=\"col-8 \">" +
						"<div class=\"text-white\">"+rs.getString("briefDescription")+"</div>"+
						"<div class=\"text-white\">"+rs.getString("detailDescription")+"</div>"+
						"<div class=\"text-white\">"+String.format("%.2f",rs.getDouble("costPrice"))+"</div>"+
						"<div class=\"text-white\">"+String.format("%.2f",rs.getDouble("retailPrice"))+"</div>"+
						"<div class=\"text-white\">"+rs.getString("productCategory")+"</div>" +
						"</div>"
						);
    		}
    		else{
    			out.print("<p>There is an error retrieving the item!</p>");
    		}
       		out.print("</div>");
       		out.print("</div>");
     } catch (Exception e) {
			out.print("<p>There is an error retrieving the item!</p>");
	 }
%>
 <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
 
</body>
</html>