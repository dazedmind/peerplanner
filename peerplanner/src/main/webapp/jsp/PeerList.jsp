<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.io.*" %>


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
    <title>PeerPlanner - Peers</title>
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
                    <a class="link" id="current__page" href="PeerList.jsp"><i class="fa-solid fa-user-group"></i>Peers</a>
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

    <!-- DISPLAY THIS IF THERE IS NONE -->
    <div class="peerlist-container">
        <div class="empty-container">
            <form method="GET" class="search-container">
                <input class="search-peers" name="id" type="text" placeholder="Enter user ID or name">
                <input id="search-btn" type="submit" value="Search">
            </form>
			
			<div class="peerlist-card-container" id="peer-card-container">
				<%
					String idParam = request.getParameter("id");
					if(idParam != null && !idParam.isEmpty()) {
						int id = Integer.parseInt(idParam);
						Class.forName("com.mysql.jdbc.Driver");
						Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/peerplan","root","");
						PreparedStatement pstmt = con.prepareStatement("SELECT * FROM userlist WHERE id=?");
						pstmt.setInt(1, id);
						ResultSet rs = pstmt.executeQuery();
							
						if(rs.next()) {
							String name = rs.getString("name");
							String email = rs.getString("email");
							int friend_id = rs.getInt("id");
							request.setAttribute("friendId", friend_id);
				%>
					<table id="peer-search-result" class="peer-result">
						<tr>
							<th>ID</th>
							<th>Name</th>
							<th>Email</th>
						</tr>
						<tr>
							<td id="userid"><%=id %></td>
							<td><%=name%></td>
							<td><%=email%></td>
						</tr>
					</table>
				<%	
						} else {
							out.println("User with ID " + id + " not found. ");
						}
						rs.close();
						pstmt.close();
						con.close();
					} else {
						out.print("<p>"+ "Please Enter User ID!" +"</p>");
					}
				%>
						<div>
							<form action="../addpeer" method="POST">
								<input type="hidden" name="idvalue" value="<%=request.getAttribute("friendId") %>">
								<span class="span-button">
									<input id="addpeer-btn" type="submit" value="Add User">
								</span>
							</form>
						</div>
			</div>
			
			<div class="peer-list-container">
				<h1>Peer List</h1>
				<table class="peer-result">	
					<tr>
						<th>ID</th>
						<th>Name</th>
						<th></th>
						<th></th>
					</tr>
				<%
					int currentID = (int) session.getAttribute("user_id");
					try{
						Class.forName("com.mysql.jdbc.Driver");
						Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/peerplan","root","");
						Statement st = con.createStatement();
						
						String str1 = "select * from friends where to_id='"+currentID+"' and status='1' ";
						ResultSet rs1 = st.executeQuery(str1);
						
						while(rs1.next()){
							int fromID = rs1.getInt("from_id");
		
							String str2 = "SELECT * FROM friends WHERE from_id=? AND to_id=? AND status='1'";
							PreparedStatement ps = con.prepareStatement(str2);
							ps.setInt(1, fromID);
							ps.setInt(2, currentID);
							ResultSet rs2 = ps.executeQuery();
							if(rs2.next()){
								int friendID = rs2.getInt("from_id");
				                String str3 = "SELECT name FROM userlist WHERE id=?";
				                PreparedStatement ps2 = con.prepareStatement(str3);
				                ps2.setInt(1, friendID);
				                ResultSet rs3 = ps2.executeQuery();
				                if(rs3.next()) {			
						%>
						<tr>
							<td><%=rs2.getInt("from_id")%></td>
							<td><%=rs3.getString("name")%></td>
							<td>
		                        <button id="plot-btn">Send Plot</button>								

							</td>
							<td>
								<form method="POST" action="">
		                            <input type="hidden" name="planid">
		                        
		                            <button id="default-btn">Unpeer</button>								
		                        </form>
							</td>
						</tr>
				<%
				                }
							}
						}
					}
					catch (Exception e){
						
					}
				
				
				%>
				</table>
			</div>
        </div>
    </div>
    <script src="../scripts/script.js"></script>
</body>
</html>