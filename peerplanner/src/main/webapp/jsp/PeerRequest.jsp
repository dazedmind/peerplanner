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
                    <a class="link" href="PlotRequest.jsp"><i class="fa-solid fa-plug"></i>Plot Requests</a>
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

    <div class="peer-req-main">
        <h1 class="page-heading">Peer Requests</h1>

        <div class="peer-req-card">
            <table class="pr-table">
                <tr>
                    <th width="60%">From</td>
                    <th width="20%">Time</td>
                    <th>Accept</td>
                    <th>Decline</td>
                </tr>
                <%
					int currentID = (int) session.getAttribute("user_id");
					try{
						Class.forName("com.mysql.jdbc.Driver");
						Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/peerplan","root","");
						Statement st = con.createStatement();
						String str = "select * from friends WHERE status='0' and to_id='"+currentID+"'";
				        String join = "SELECT friends.*, userlist.name FROM friends JOIN userlist ON friends.from_id = userlist.id WHERE friends.status='0' AND friends.to_id='" + currentID + "'";

						ResultSet rs = st.executeQuery(join);						
						
						while(rs.next()){
							int fromID = rs.getInt("from_id");

							request.setAttribute("fromID", fromID);

						%>
                <tr>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("created") %></td>
                    <td>
                        <form method="POST" action="../acceptpeer">
                            <input type="hidden" name="fromid" value="<%= request.getAttribute("fromID") %>">
                        
                            <button id="accept-btn"><i class="fa-solid fa-check"></i></button>								
                        </form>
                    </td>
                    <td>
                        <form method="POST" action="">
                            <input type="hidden" name="planid">
                        
                            <button id="decline-btn"><i class="fa-solid fa-xmark"></i></button>								
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

    <script src="../scripts/script.js"></script>
</body>
</html>