<%-- 
  - Author(s): LIEW KHYE LERK(P1937000), ERIC NG YONG WEI(P1940211);
  - Date: 29/5/20;
  --%>
  <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>All Products</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./CSS/ProductListing.css">
<link rel="stylesheet" type="text/css" href="./CSS/footer.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

</head>
<body>
<nav class="navbar navbar-expand-lg navbar-custom navbar-dark ">
 		 <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
   			 <span class="navbar-toggler-icon"></span>
 		 </button>
		  <div class="collapse navbar-collapse" id="navbarSupportedContent">
  		  <ul class="navbar-nav mr-auto">
    		  <li class="nav-item">
    		    <a class="nav-link" href="Home.jsp">Home <span class="sr-only">(current)</span></a>
    		  </li>
    		  <li class="nav-item">
    		    <a class="nav-link" href="ProductCategory.jsp">Categories <span class="sr-only">(current)</span></a>
    		  </li>
 		   </ul>

   		 <ul  class="navbar-nav mr-right dropleft" style="margin-left:20px" >
         		 <li class="nav-item dropdown ">
        <%
	int id = 0;
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
String category;
 category = request.getParameter("category");
if(category == null) category = "%";
    try {
          Class.forName("com.mysql.jdbc.Driver");
          //String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
          String connURL = "jdbc:mysql://localhost:3306/jad?user=root&password=khyelerk12KL&serverTimezone=UTC";

          Connection conn = DriverManager.getConnection(connURL); 
          Statement stmt = conn.createStatement();

          String sqlStr = "SELECT productId, productName, briefDescription, costPrice, retailPrice, imageLocation FROM product WHERE productCategory LIKE ?";         
          ResultSet rs;
          
          PreparedStatement pstmt = conn.prepareStatement(sqlStr);
          pstmt.setString(1,category);
  		  rs = pstmt.executeQuery();
     		out.print("<div class=\"container margin text-center\">");
     		if(category.equals("%")){
           		out.print("<h2 class=\"text-warning text-center\">All Products</h2>");
     		}else{
           		out.print("<h2 class=\"text-warning text-center\">"+category+"</h2>");
     		}
       		
       		if (rs.next() == false) { 
       			out.print("<h1 class='text-center text-white'>Products Coming Soon!<h1>"); 
       		} 
       		else { 
           		out.print("<div class=\"row row-cols-2 row-cols-md-3\">");
       			do {
       				out.print(
       			            "<div class=\"col mb-4\">" +
       			              "<div class=\"card cardProduct \">" +
       			    		      "<a href='ProductDetail.jsp?productId="+rs.getInt("productId")+"'>"+
       			                    "<img src='."+rs.getString("imageLocation")+"' class=\"card-img-top\" alt=\"...\">" +
       			                "<div class=\"card-body\">" +
       			                    "<h5 class=\"card-title\">"+rs.getString("productName")+"</h5>" +
       			                    "<p class=\"card-text\">$"+String.format("%.2f",rs.getDouble("retailPrice"))+"</p>" +
       			        		  "</a>" +
       			                "</div>"+
       			              "</div>"+
       			            "</div>");
       			       			
       			} while (rs.next()); 
       		}


            out.print("</div>");
            out.print("</div>");
          conn.close();
     } catch (Exception e) {
        System.err.println("Error :" + e);
     }
%>

<%@ include file = "footer.jsp" %>

 <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
 
</body>
</html>