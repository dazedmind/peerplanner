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
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/main.css">
    <link rel="shortcut icon" href="../images/peerplanner.png" type="image/x-icon">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css" integrity="sha512-SzlrxWUlpfuzQ+pcUCosxcglQRNAq/DZjVsC0lE40xsADsfeQoEypE+enwcOiGjk/bSuGGKHEyjSoQ1zVisanQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="../css/evo-calendar.midnight-blue.min.css">
    <link rel="stylesheet" href="../css/evo-calendar.min.css">
    <title>PeerPlanner - Plots</title>
</head>
<body>
    <header>
        <div class="header-box">
            <img class="header-img" src="../images/peerplanner.png" alt="">
            <a href="Main.jsp">          
                <h1>PeerPlanner</h1>
            </a>
        </div>
        <nav>
            <ul class="nav-links">
                <li>
                    <a class="link" href="Main.jsp"><i class="fa-solid fa-house"></i>Home</a>
                </li>
                <li>
                    <a class="link" id="current__page" href="Plots.jsp"><i class="fa-solid fa-calendar"></i>Plots</a>
                </li>
                <li>
                    <a class="link" href="PeerList.jsp"><i class="fa-solid fa-user-group"></i>Peers</a>
                </li>
                <li>
                    <a class="link" href="PlotRequest.jsp"><i class="fa-solid fa-plug"></i>Plot Requests</a>
                </li>
            </ul>
            <span id="profile-menu">
                <img src="../images/user.png" alt="" style="width: 2.5rem; height: 2.5rem;">
                <div id="hidden-menu">
                    <ul class="nav-links-hidden">
                        <li>
                            <a class="hidden-link" href="/">Account Settings</a>
                        </li>
                        <li>
                            <a class="hidden-link" href="../login.php">Log Out</a>
                        </li>
                    </ul>
                </div>
            </span>
        </nav>
    </header>

    <div class="calendar-container">
        <div id="calendar"></div>
    </div>
    
    		<div class="peer-list-container">
				<table border="1">	
					<tr>
						<th>Event Name</th>
						<th>Message</th>
						<th>Event Date</th>
						<th>Time</th>						
					</tr>
				<%
					int currentID = (int) session.getAttribute("user_id");
					try{
						Class.forName("com.mysql.jdbc.Driver");
						Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/peerplan","root","");
						Statement st = con.createStatement();
						
						String str = "select * from plans";
						ResultSet rs = st.executeQuery(str);
						
						while(rs.next()){
						%>
						<tr>
							<td><%=rs.getString("eventname")%></td>
							<td><%=rs.getString("message")%></td>
							<td><%=rs.getString("event_date")%></td>
							<td><%=rs.getString("time")%></td>
						</tr>
				<%
						}
					}
					catch (Exception e){
						
					}
				
				%>
				</table>
			</div>

    <script src="https://cdn.jsdelivr.net/npm/jquery@3.4.1/dist/jquery.min.js"></script>
    <script src="../scripts/script.js"></script>
    <script src="../scripts/evo-calendar.min.js"></script>
    <script src="../scripts/calendar-script.js"></script>
</body>
</html>