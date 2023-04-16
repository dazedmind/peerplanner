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

/**
 * Servlet implementation class DeclinePlot
 */
@WebServlet("/decline")
public class DeclinePlot extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int planId = Integer.parseInt(request.getParameter("planid"));
		
		Connection con = null;
		
		try {
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/peerplan","root","");

			String q2 = "UPDATE planrequest SET status='2' WHERE plan_id=?;";
			PreparedStatement st2 = con.prepareStatement(q2);
			st2.setInt(1, planId);
			int rowCount2 = st2.executeUpdate();

			if (rowCount2 > 0) {
			    request.setAttribute("status", "success");
			    response.sendRedirect("jsp/PlotRequest.jsp");
			} else {
			    request.setAttribute("status", "failed");
			}
		} catch (Exception e) {
	        throw new ServletException("Accepting Plot Failed", e);
		} 
	}

}
