package com.haritex.action;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class AcceptPeer
 */
@WebServlet("/acceptpeer")
public class AcceptPeer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();

		int fromID = Integer.parseInt(request.getParameter("fromid"));
		int toID = (int) session.getAttribute("user_id");

		
		Connection con = null;
		
		try {
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/peerplan","root","");

			String q1 = "UPDATE friends SET status='1' WHERE from_id=? and to_id=?";
			PreparedStatement st1 = con.prepareStatement(q1);
			st1.setInt(1, fromID);
			st1.setInt(2, toID);
			
			int rowCount1 = st1.executeUpdate();

			String q2 = "INSERT INTO friends(from_id, to_id, status) VALUES(?,?,'1')";
			PreparedStatement st2 = con.prepareStatement(q2);
			st2.setInt(1, toID);
			st2.setInt(2, fromID);
			
			int rowCount2 = st2.executeUpdate();
			

			if (rowCount1 > 0 && rowCount2 > 0) {
			    request.setAttribute("status", "success");
			    response.sendRedirect("jsp/PeerRequest.jsp");
			} else {
			    request.setAttribute("status", "failed");
			}
		} catch (Exception e) {
	        throw new ServletException("Accepting Plot Failed", e);
		} 
	}

}
