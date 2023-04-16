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
 * Servlet implementation class AcceptPlot
 */
@WebServlet("/acceptplot")
public class AcceptPlot extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();

		String ename = request.getParameter("eventname");
		String emessage = request.getParameter("message");
		String edate = request.getParameter("date");
		String etime = request.getParameter("time");
		int planId = Integer.parseInt(request.getParameter("planid"));
		int currentID = (int) session.getAttribute("user_id");

		
		Connection con = null;
		
		try {
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/peerplan","root","");

			String q1 = "INSERT INTO plans(eventname,message,event_date,time,for_userid) VALUES(?,?,?,?,?);";
			PreparedStatement st1 = con.prepareStatement(q1);
			st1.setString(1, ename);
			st1.setString(2, emessage);
			st1.setString(3, edate);
			st1.setString(4, etime);
			st1.setInt(5, currentID);

			int rowCount1 = st1.executeUpdate();

			String q2 = "UPDATE planrequest SET status='1' WHERE plan_id=?;";
			PreparedStatement st2 = con.prepareStatement(q2);
			st2.setInt(1, planId);
			int rowCount2 = st2.executeUpdate();

			if (rowCount1 > 0 && rowCount2 > 0) {
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
