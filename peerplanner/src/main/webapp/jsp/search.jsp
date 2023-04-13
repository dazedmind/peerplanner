<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
					<table style="border: 1px solid; color: black;">
					<tr>
						<th>ID</th>
						<th>Name</th>
						<th>Email</th>
					</tr>
					<tr> 
						<td class="id-container"></td>
						<td class="id-container"></td>
						<td class="id-container"></td>
					</tr>
					
					<%
							try {
								Class.forName("com.mysql.jdbc.Driver");
							   	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/peerplan", "root", "");
								Statement st = conn.createStatement();
								
								String userid = request.getParameter("search-peers");
								
								String str = "Select * from userlist where id = '"+userid+"'";
								ResultSet rs = st.executeQuery(str);
								
								while(rs.next()){
								%>
									<tr>
										<td><%=rs.getInt("id") %></td>
										<td><%=rs.getString("name") %></td>
										<td><%=rs.getString("email") %></td>
										
									</tr>
								<% }
	
							} catch(Exception e) {
									
							}
					
					%>
					</table>
</body>
</html>