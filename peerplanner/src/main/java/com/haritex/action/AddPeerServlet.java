package com.haritex.action;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

/**
 * Servlet implementation class AddPeerServlet
 */
@WebServlet("/addpeer")
public class AddPeerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    // get session attributes
		HttpSession session = request.getSession();
	    
	    int userId = (int) session.getAttribute("user_id");
	    int friendId = Integer.parseInt(request.getParameter("idvalue"));
	    
	        try {
	            Class.forName("com.mysql.jdbc.Driver");
	            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/peerplan","root","");
	            PreparedStatement pstmt = con.prepareStatement("INSERT INTO FRIENDS(from_id, to_id) VALUES(?,?)");
	            pstmt.setInt(1, userId);
	            pstmt.setInt(2, friendId);
				
				int rowCount = pstmt.executeUpdate();
				if (rowCount > 0) {
			        response.sendRedirect("jsp/PeerList.jsp");

					request.setAttribute("status", "success");
				} else {
					request.setAttribute("status", "failed");
					
				}
	            pstmt.close();
	            con.close();
	        } catch(ClassNotFoundException | SQLException e) {
		        throw new ServletException("Plot Request Failed", e);
	        }
	}

}

