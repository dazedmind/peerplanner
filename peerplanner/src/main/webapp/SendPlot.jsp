<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/main.css">
    <link rel="shortcut icon" href="images/peerplanner.png" type="image/x-icon">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css" integrity="sha512-SzlrxWUlpfuzQ+pcUCosxcglQRNAq/DZjVsC0lE40xsADsfeQoEypE+enwcOiGjk/bSuGGKHEyjSoQ1zVisanQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <title>Send Plot Request</title>
</head>
<body>

<input type="hidden" id="status" value="<%= request.getAttribute("status") %>">

    <header>
        <div class="header-box">
            <img class="header-img" src="images/peerplanner.png" alt="">
            <a href="jsp/Main.jsp">          
                <h1>PeerPlanner</h1>
            </a>        
        </div>
        <nav>
            <ul class="nav-links">
                <li>
                    <a class="link" href="jsp/Main.jsp"><i class="fa-solid fa-house"></i>Home</a>
                </li>
                <li>
                    <a class="link" href="jsp/Plots.jsp"><i class="fa-solid fa-calendar"></i>Plots</a>
                </li>
                <li>
                    <a class="link" href="jsp/PeerList.jsp"><i class="fa-solid fa-user-group"></i>Peers</a>
                </li>
                <li>
                    <a class="link" href="jsp/PlotRequest.jsp"><i class="fa-solid fa-plug"></i>Plot Requests</a>
                </li>
            </ul>
            <span id="profile-menu">
                <img src="images/user.png" alt="" style="width: 2.5rem; height: 2.5rem;">
                <div id="hidden-menu">
                    <ul class="nav-links-hidden">
                        <li>
                            <a class="hidden-link" href="jsp/AccSettings.jsp">Account Settings</a>
                        </li>
                        <li>
                            <a class="hidden-link" href="jsp/Notifications.jsp">Notifications</a>
                        </li>
                        <li>
                            <a class="hidden-link" href="jsp/PeerRequest.jsp">Peer Requests</a>
                        </li>
                        <li>
                            <a class="hidden-link" href="	index.jsp">Log Out</a>
                        </li>
                    </ul>
                </div>
            </span>
        </nav>
    </header>

    <div class="main-send-plot">
        <h1>Send Plot Request</h1>
        <div class="form-container">
            <form action="saveplot" method="POST" class="plot-request">

                <label for="user">Select Peer</label>
                <select name="users" id="userlist">
                    <%
                    	try {
                    		Class.forName("com.mysql.jdbc.Driver");
                    		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/peerplan", "root", "");
                    		Statement st = con.createStatement();
                    		String q = "SELECT * FROM userlist";
                    		
                    		ResultSet rs = st.executeQuery(q);
                    		while(rs.next()){
                    			request.setAttribute("request_id", rs.getInt("id"));
                    			%>
                    			<option><%= rs.getString("name") %></option>
                    			<% 
                    		}
                    	} catch (Exception e) {
                    		
                    	}
                    %>
                </select>
				
				<label for="req_id">Enter user ID</label>
                <input name="req_id" type="text">
				
                <label for="eventname">Event Name</label>
                <input name="eventname" type="text">

                <label for="description">Description</label>
                <textarea name="description" id="description" cols="30" rows="5"></textarea>
				
				<label for="time">Select Time</label>
                <input type="time" name="time" id="time">
                
                <label for="date">Select Date</label>
                <input type="date" name="date" id="date">
                
                <div class="checkbox-container">
                    <label for="everyYear">Every Year</label>
                    <input type="checkbox" name="everyYear" id="everyYear">
                </div>

                <span class="send-btn-container">
                    <button id="send-btn" type="submit">Send Plot Request</button>  
                </span>
            </form>
        </div>
    </div>
	    	
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.11.0/sweetalert2.css" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.11.0/sweetalert2.all.min.js"></script>
	
    <script type="text/javascript">
    	var status = document.getElementById("status").value;
    	if (status == "success") {
    		swal("Yay", "Plot Request Sent!", "success");
    	}
    </script>
    <script src="../scripts/script.js"></script>
</body>
</html>