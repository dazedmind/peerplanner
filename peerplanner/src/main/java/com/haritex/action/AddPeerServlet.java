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
	    HttpSession session = request.getSession();
	    
	    int userId = (int) session.getAttribute("user_id");
	    String friendIdParam = request.getParameter("userid");
	    
	    if (friendIdParam != null && !friendIdParam.isEmpty()) {
	        int friendId = Integer.parseInt(friendIdParam);
			RequestDispatcher dispatcher = null;

	        try {
	            Class.forName("com.mysql.jdbc.Driver");
	            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/peerplan","root","");
	            PreparedStatement pstmt = con.prepareStatement("UPDATE userlist SET friends= ? WHERE id=?");
	            pstmt.setInt(1, friendId);
	            pstmt.setInt(2, userId);
	            pstmt.executeUpdate();
	            
	            int rowCount = pstmt.executeUpdate();
				dispatcher = request.getRequestDispatcher("PeerList.jsp");
				if (rowCount > 0) {
					request.setAttribute("status", "success");
				} else {
					request.setAttribute("status", "failed");
					
				}
				dispatcher.forward(request, response);
	            pstmt.close();
	            con.close();
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    }
	    response.sendRedirect("jsp/PeerList.jsp");
	}

}

