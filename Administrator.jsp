<%-- 
  - Author(s): LIEW KHYE LERK(P1937000), ERIC NG YONG WEI(P1940211);
  - Date: 29/5/20;
  --%>
  <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import ="java.sql.*"%><!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Administrator</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./CSS/Administrator.css">
</head>
<body>
<%
int id = 0;
if(session.getAttribute("userId") != null){
	id = (int)session.getAttribute("userId");
	}
else{
	response.sendRedirect("errorPage.jsp");
}
String role;
   try {
	   		
          // Step 2: Define Connection URL
 				// String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
		         String connURL = "jdbc:mysql://localhost:3306/jad?user=root&password=khyelerk12KL&serverTimezone=UTC";
          // Step 3: Establish connection to URL
          
          Connection conn = DriverManager.getConnection(connURL); 
         // Step 4: Create Statement object
          Statement stmt = conn.createStatement();

                    // Step 5: Execute SQL Command
          String sqlStr = "SELECT * FROM user WHERE userId = ?" ;
            ResultSet rs;
    		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
    		pstmt.setInt(1,id);
    		rs = pstmt.executeQuery();
    		
			if(rs.next()){
    			role = rs.getString("role");
    			if(role.equals("M")){
    				session.setAttribute("userId",id);
    				session.setMaxInactiveInterval(30 * 60);
    				response.sendRedirect("errorPage.jsp?type=AccessDenied");
    			}
			}
    		
     } catch (Exception e) {
			response.sendRedirect("errorPage.jsp");
     }
%>

<%	
String name="";
String pwd="";
String email="";
String pfp="";
String address="";
int phoneNo=0;
    try {
           Class.forName("com.mysql.jdbc.Driver");
       //   String connURL = "jdbc:mysql://localhost/jad?user=root&password=Devious1211&serverTimezone=UTC";
          String connURL = "jdbc:mysql://localhost:3306/jad?user=root&password=khyelerk12KL&serverTimezone=UTC";

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

<nav class="navbar navbar-expand-lg navbar-custom navbar-dark ">
 		 <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
   			 <span class="navbar-toggler-icon"></span>
 		 </button>
		  <div class="collapse navbar-collapse" id="navbarSupportedContent">
  		  <ul class="navbar-nav mr-auto">
    		  <li class="nav-item active">
    		    <a class="nav-link" href="Administrator.jsp">Administrator <span class="sr-only">(current)</span></a>
    		  </li>
    		  <li class="nav-item ">
    		    <a class="nav-link" href="discountTable.jsp">Edit Discounts<span class="sr-only">(current)</span></a>
    		  </li>
    		  <li class="nav-item ">
    		    <a class="nav-link" href="productTable.jsp">Edit Products<span class="sr-only">(current)</span></a>
    		  </li>
 		   </ul>
   		 
  </div>
</nav>

  
<div class="container text-center ">
	<div class="row">

	  <div class="card" style="width: 18rem;" >
	  	     		   <h3 class="text-white">Administrator:</h3>
      		<img src=".<%=pfp %>" class="card-img-top" alt="Card image cap">
     	 <div class="card-body">
        	   <p class="card-title text-white">Name: <%=name %></p>
       	       <p class="card-title text-white">Email: <%=email %></p>
       	       <p class="card-title text-white">Address: <%=address %></p>
      	       <p class="card-title text-white">Phone No: <%=phoneNo %></p>
      	       <a class='btn btn-warning' href='logout.jsp'>Log Out</a>
         </div>
	    </div>
	    

	</div>
	
</div>



<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
</body>
</html>