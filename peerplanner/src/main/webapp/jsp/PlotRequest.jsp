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
    <title>PeerPlanner</title>
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
                    <a class="link" href="Plots.jsp"><i class="fa-solid fa-calendar"></i>Plots</a>
                </li>
                <li>
                    <a class="link" href="PeerList.jsp"><i class="fa-solid fa-user-group"></i>Peers</a>
                </li>
                <li>
                    <a class="link" id="current__page" href="PlotRequest.jsp"><i class="fa-solid fa-plug"></i>Plot Requests</a>
                </li>
            </ul>
            <span id="profile-menu">
                <img src="../images/user.png" alt="" style="width: 2.5rem; height: 2.5rem;">
                <div id="hidden-menu">
                    <ul class="nav-links-hidden">
                        <li>
                            <a class="hidden-link" href="AccSettings.jsp">Account Settings</a>
                        </li>
                        <li>
                            <a class="hidden-link" href="Notification.jsp">Notifications</a>
                        </li>
                        <li>
                            <a class="hidden-link" href="PeerRequest.jsp">Peer Requests</a>
                        </li>
                        <li>
                            <a class="hidden-link" href="../login.jsp">Log Out</a>
                        </li>
                    </ul>
                </div>
            </span>
        </nav>
    </header>
	
	<div class="main-plot-request">
		<h1 class="card-title">Your Plot Request</h1>
        <div class="card">
            <table style="width: 100%;">
            	<thead>
	                <tr>
	                    <th style="width:20%;">Event Name</th>
	                    <th style="width: 40%;">Description</th>
	                    <th style="width: 20%;">Date</th>
	                    <th>Time</th>
	                    <th>Accept</th>
	                    <th>Decline</th>
	                </tr>
                </thead>
             <%
					int currentID = (int) session.getAttribute("user_id");
					try{
						Class.forName("com.mysql.jdbc.Driver");
						Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/peerplan","root","");
						Statement st = con.createStatement();
						
						String str = "select * from planrequest WHERE status='0' and for_userid='"+currentID+"'";
						ResultSet rs = st.executeQuery(str);
						
						while(rs.next()){
							String event_name = rs.getString("eventname");
							String event_desc = rs.getString("message");
							String event_date = rs.getString("event_date");
							String event_time = rs.getString("time");
							int event_id = rs.getInt("plan_id");

							request.setAttribute("eventname", event_name);
							request.setAttribute("eventdesc", event_desc);
							request.setAttribute("eventdate", event_date);
							request.setAttribute("eventtime", event_time);
							request.setAttribute("eventid", event_id);

						%>
					
						<tr data-row="<%=rs.getInt("plan_id")%>">
							<td id="eventname"><%=rs.getString("eventname")%></td>
							<td id="message"><%=rs.getString("message")%></td>
							<td id="date"><%=rs.getString("event_date")%></td>
							<td id="time"><%=rs.getString("time")%></td>
							<td>
								<form method="POST" action="../acceptplot">
									<input type="hidden" name="eventname" value="<%= request.getAttribute("eventname") %>">
									<input type="hidden" name="message" value="<%= request.getAttribute("eventdesc") %>">
									<input type="hidden" name="date" value="<%= request.getAttribute("eventdate") %>">
									<input type="hidden" name="time" value="<%= request.getAttribute("eventtime") %>">
									<input type="hidden" name="planid" value="<%= request.getAttribute("eventid") %>">
									
									
									<button id="accept-btn" data-button="<%=rs.getInt("plan_id") %>"><i class="fa-solid fa-check"></i></button>
								</form>          
							</td>
							<td>
								<form method="POST" action="../decline">
									<input type="hidden" name="planid" value="<%= request.getAttribute("eventid") %>">
								
									<button id="decline-btn" data-decline="<%=rs.getInt("plan_id") %>"><i class="fa-solid fa-xmark"></i></button>								
								</form>
							</td>
						</tr>

				<%		
						}
					}
					catch (Exception e){
						
					}
				
				%>
            </table>
        </div>
    </div>
	
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.11.0/sweetalert2.css" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.11.0/sweetalert2.all.min.js"></script>
	
    <script type="text/javascript">
    	const declineBtn = document.querySelectorAll('[data-decline]')

    	declineBtn.forEach((e)=> {
		e.addEventListener('click', async () => {
				const {value: text} = await swal({
					input: 'textarea',
					title: 'Message',
					inputPlaceholder: 'Tell them why...',
					inputAttributes: {
						'aria-label': 'type your message'
					},
					showCancelButton: true
				})
				if (text){
					swal('Sent', '', 'success');
				}
			})
		})
    </script>
    <script type="module" src="../scripts/script.js"></script>
    <script src="../scripts/plotresponse.js"></script>
</body>
</html>