<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Product Detail</title>
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

<%!
public double getDiscount(int discountId, double discountValue, String discountType, int usageLimit, int usageCount){
	double totalDiscount =discountValue;


			String updateStr = "UPDATE discount SET usageCount=? WHERE discountId=?";
			int count=0;
			
			 try {
		         String connURL = "jdbc:mysql://localhost:3306/jad?user=root&password=khyelerk12KL&serverTimezone=UTC";
		         Connection conn = DriverManager.getConnection(connURL); 
		         
			 	PreparedStatement pstmt = conn.prepareStatement(updateStr);
		         pstmt.setInt(1, (++usageCount));
		         pstmt.setInt(2, discountId);
		         count = pstmt.executeUpdate();
		         conn.close(); 

		    } catch (Exception e) {
		       
		    }
	return totalDiscount;
}
%>

<br><br>
<div class="container justify-content-center ">
<div class="row justify-content-center">

<%
String discountCode= request.getParameter("discountCode");
int discountValid =0;
double discountValue =0;
String discountType = "";
int usageLimit =0;
int usageCount =0;
int discountId =0;
if(discountCode != null){
   try {
	   
          String connURL = "jdbc:mysql://localhost:3306/jad?user=root&password=khyelerk12KL&serverTimezone=UTC";

          Connection conn = DriverManager.getConnection(connURL); 
          Statement stmt = conn.createStatement();

          String sqlStr = "SELECT discountId, discountValue, discountType, usageLimit, usageCount FROM discount WHERE discountCode = ?";
    
          ResultSet rs;
          
    		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
    		pstmt.setString(1,discountCode);
    		rs = pstmt.executeQuery();
    		if(rs.next()){
    			discountId = rs.getInt("discountId");
    			discountValue = rs.getDouble("discountValue");
    			discountType = rs.getString("discountType");
    			usageLimit = rs.getInt("usageLimit");
    			usageCount = rs.getInt("usageCount");
    			discountValid = 1;
    		}
    		else{
    			out.print("<p class='text-danger'>The discount code is not found! Please enter a valid discount code!</p>");
    			discountValid = 0;

    		}
    		
     } catch (Exception e) {
			response.sendRedirect("errorPage.jsp");
     }
}

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
    		
    		if(rs.next()){
				out.print(
						"<div class=\"col-md-8  text-center\">"+
						"<h2 class=\"text-warning\">"+rs.getString("productName")+"</h2>" +
					    "<img src='."+rs.getString("imageLocation")+"' class=\"productImg\" alt='productImage'>"+
						"</div>" +
					   	"<div class=\"col-md-4 text-left\">" +
						"<p class=\"text-warning\">Brief Description:</p>"+
						"<p class=\"text-white\">"+rs.getString("briefDescription")+"</p>"+
						"<p class=\"text-warning\">Detailed Description:</p>"+
						"<p class=\"text-white\">"+rs.getString("detailDescription")+"</p>"+
						"<p class=\"text-warning\">Cost Price:</p>"+
						"<p class=\"text-white\">$"+String.format("%.2f",rs.getDouble("costPrice"))+"</p>"
						);
				if(discountValid ==1){
					if("DIRECT".equals(discountType)){
						out.print("<p class=\"text-warning\">Retail Price:</p>"+
								"<strike class=\"text-danger\">$"+String.format("%.2f",rs.getDouble("retailPrice"))+"</strike>"+
								"<p class=\"text-success\">$"+String.format("%.2f",(rs.getDouble("retailPrice"))- getDiscount(discountId, discountValue, discountType, usageLimit, usageCount))+"</p>");
					}
					else{
						out.print("<p class=\"text-warning\">Retail Price:</p>"+
								"<strike class=\"text-danger\">$"+String.format("%.2f",rs.getDouble("retailPrice"))+"</strike>"+
								"<p class=\"text-success\">$"+String.format("%.2f",(rs.getDouble("retailPrice"))* ((100 - getDiscount(discountId, discountValue, discountType, usageLimit, usageCount)))/100)+"</p>");
					}
				}else{
					out.print("<p class=\"text-warning\">Retail Price:</p>"+
							"<p class=\"text-white\">$"+String.format("%.2f",rs.getDouble("retailPrice"))+"</p>");
				}
				out.print("<p class=\"text-warning\">Product Category:</p>"+
						"<p class=\"text-white\">"+rs.getString("productCategory")+"</p>" +
						"<p class=\"text-warning\">Discount Code:</p>"+
						"<form  action=\"ProductDetail.jsp\" method='GET' class=\"form-inline my-2 my-lg-0\" ><input type='hidden' name='productId' value='"+productId+"'/><input class=\"form-control mr-sm-2\" type=\"search\" name='discountCode' placeholder=\"DISCOUNT CODE\" aria-label=\"Search\">\n<button class=\"btn btn-warning my-2 my-sm-0\" type=\"submit\">APPLY</button></form>"+
						"<a>BUY</a>" +
						"</div>");
    		}
    		else{
    			out.print("<p class='text-danger'>There is an error retrieving the item!</p>");
    		}
     } catch (Exception e) {
			out.print("<p class='text-danger'>There is an error retrieving the item!</p>");
	 }
%>

</div>
</div>



 <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
 
</body>
</html>