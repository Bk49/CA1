<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Profile Details</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./CSS/profilePage.css">
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-custom navbar-dark ">
 		 <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
   			 <span class="navbar-toggler-icon"></span>
 		 </button>
		  <div class="collapse navbar-collapse" id="navbarSupportedContent">
  		  <ul class="navbar-nav mr-auto">
    		  <li class="nav-item active">
    		    <a class="nav-link" href="Home.jsp">Home</a>
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

<div class="d-flex justify-content-center text-center">

<%
int userId = (int)session.getAttribute("userId");
   try {
          //String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
          String connURL = "jdbc:mysql://localhost:3306/jad?user=root&password=khyelerk12KL&serverTimezone=UTC";

          Connection conn = DriverManager.getConnection(connURL); 
          Statement stmt = conn.createStatement();

          String sqlStr = "SELECT name, email, pfp, address, phoneNo FROM user WHERE userId=?";
    
          ResultSet rs;
          
    		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
    		pstmt.setInt(1,userId);
    		rs = pstmt.executeQuery();
    		
    		if(rs.next()){
				out.print(
	   		    		"<div class='container padding-0'>"+
	   		    			"<div class='row padding-0 text-center justify-content-center'>" +
	   		   		  		    "<div class='col-md-5 padding-0 text-right '>" +
    		    					"<img src='."+rs.getString("pfp")+"' alt='userPfp' class='profilePic'>"+
    							"</div>" +
	   		   		  		    "<div class='col-md-6 text-center padding-0'>" +	
	   	    		  			 "<form action='updateDetails.jsp' class='formProfile'>"+
     								"<input type='hidden' value='"+userId+"'/>"+
    								"<div><label class='text-warning'>Name</label><br><input type='text' name='name' value='"+rs.getString("name")+"' required></div>"+
    								"<div><label class='text-warning'>Email</label><br><input type='text' name='email' value='"+rs.getString("email")+"' required></div>"+
    								"<div><label class='text-warning'>Profile Picture Link or Directory</label><br><input type='text' name='pfp' value='"+rs.getString("pfp")+"'></div>"+
    								"<div><label class='text-warning'>Phone Number</label><br>s<input type='number' name='phoneNo' value='"+rs.getString("phoneNo")+"'></div>"+
									"<input type='submit' class='submit bg-warning col-12' value='Update Profile Details'><br>"+
								 "</form>"+
    						    "</div>" +
    						"</div>" +
    					"</div>"
    					);
				
    		}
    		else{
    			out.print("There is an error retrieving the data from the database!");
    		}
    		
     } catch (Exception e) {
    	 out.print("There is an error connecting to the database!");
    	 out.print(e);
     }
%>
</div>
 <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
 
</body>
</html>