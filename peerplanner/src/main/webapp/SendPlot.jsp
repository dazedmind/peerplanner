<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>

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
                            <a class="hidden-link" href="index.jsp">Log Out</a>
                        </li>
                    </ul>
                </div>
            </span>
        </nav>
    </header>
	
	<% 
		int currentUserID = (int) session.getAttribute("user_id");
		List<Integer> friendIDs = new ArrayList<>();
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/peerplan", "root", "");
			Statement st = con.createStatement();
			String q = "SELECT * FROM friends where from_id='"+currentUserID+"' OR to_id='"+currentUserID+"'";
	
			ResultSet rs = st.executeQuery(q);
			while(rs.next()){
				friendIDs.add(rs.getInt("from_id"));
			}
			request.setAttribute("friendIDs", friendIDs);
		} catch (Exception e) {
			
		}
	%>
	
	<input type="hidden" name="name" value="<%= request.getAttribute("name") %>">
	
	
    <div class="main-send-plot">
        <h1>Send Plot Request</h1>
        <div class="form-container">
            <form action="saveplot" method="POST" class="plot-request">

                <label for="user">Select Peer</label>
                <select name="users" id="userlist">
                    <%                    
                    try {
                        int currentID = 0;
                        Object userID = session.getAttribute("user_id");
                        if (userID instanceof Integer) {
                            currentID = (int) userID;
                        } else {
                            // Handle the case when user_id is not set or not an integer
                        }

                        int fromID = 0;
                        Object fromIDAttr = request.getAttribute("fromID");
                        if (fromIDAttr instanceof Integer) {
                            fromID = (int) fromIDAttr;
                        } else {
                            // Handle the case when from_id is not set or not an integer
                        }

                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/peerplan", "root", "");
                        
                        String query = "SELECT f.from_id, u.name FROM friends f INNER JOIN userlist u ON f.from_id = u.id WHERE f.from_id=? AND f.to_id=? AND f.status='1'";
                        PreparedStatement st = con.prepareStatement(query);
                        
                        for (int i = 0; i < friendIDs.size(); i++) {
                            int friendID = friendIDs.get(i);
                            
                            if (friendID == currentID) {
                                continue;
                            }
                            
                            st.setInt(1, friendID);
                            st.setInt(2, currentID);
                            
                            ResultSet rs = st.executeQuery();
                            while (rs.next()) {
                            	String friendName = rs.getString("name");
                                int friendId = rs.getInt("from_id");
                    
                                %>
                                <option value="<%= friendId %>"> <%= friendName %> </option>
                                <%
                            }
                        }
                    } catch (Exception e) {
                        // Handle any exceptions that occur during the database connection or query execution
                    }
                    %>
                </select>
                
                <label for="eventname">Event Name</label>
                <input name="eventname" type="text">

                <label for="description">Description</label>
                <textarea name="description" id="description" cols="30" rows="5"></textarea>
				
				<label for="time">Select Time</label>
                <input type="time" name="time" id="time">
                
                <label for="dates">Select Date</label>
                <input type="date" name="date" id="date">
               

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
    <script src="scripts/script.js"></script>
</body>
</html>