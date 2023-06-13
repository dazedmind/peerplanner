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
		    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/peerplan", "root", "");

		    String selectQuery = "SELECT * FROM friends WHERE from_id=? AND to_id=?";
		    PreparedStatement selectStmt = con.prepareStatement(selectQuery);
		    selectStmt.setInt(1, userId);
		    selectStmt.setInt(2, friendId);
		    ResultSet rs = selectStmt.executeQuery();

		    if (rs.next()) {
		        // Duplicate request already exists
		        response.sendRedirect("jsp/PeerList.jsp");
		        request.setAttribute("status", "duplicate");
		    } else {
		        String insertQuery = "INSERT INTO friends(from_id, to_id) VALUES(?,?)";
		        PreparedStatement insertStmt = con.prepareStatement(insertQuery);
		        insertStmt.setInt(1, userId);
		        insertStmt.setInt(2, friendId);
		        int rowCount = insertStmt.executeUpdate();

		        if (rowCount > 0) {
		            // Request successfully inserted
		            response.sendRedirect("jsp/PeerList.jsp");
		            request.setAttribute("status", "success");
		        } else {
		            // Failed to insert request
		            request.setAttribute("status", "failed");
		        }
		    }

		    rs.close();
		    selectStmt.close();
		    con.close();
		} catch (ClassNotFoundException | SQLException e) {
		    throw new ServletException("Plot Request Failed", e);
		}
	}

}

