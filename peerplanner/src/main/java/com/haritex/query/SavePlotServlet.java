package com.haritex.query;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SavePlotServlet
 */
@WebServlet("/saveplot")
public class SavePlotServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String userlistParam = request.getParameter("users");
		int requestId = Integer.parseInt(userlistParam);
		String ename = request.getParameter("eventname");
		String emessage = request.getParameter("description");
		String edate = request.getParameter("date");
		String etime = request.getParameter("time");
		
		System.out.println(requestId);
		
		RequestDispatcher dispatcher = null;
		Connection con = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			 con = DriverManager.getConnection("jdbc:mysql://localhost:3306/peerplan","root", "");
			String q = "INSERT INTO planrequest(eventname,message,event_date,time,for_userid) VALUES(?,?,?,?,?)";
			PreparedStatement st = con.prepareStatement(q);
			st.setString(1, ename);
			st.setString(2, emessage);
			st.setString(3, edate);
			st.setString(4, etime);
			st.setInt(5, requestId);

			
			int rowCount = st.executeUpdate();
			
			dispatcher = request.getRequestDispatcher("SendPlot.jsp");
			if (rowCount > 0) {
				request.setAttribute("status", "success");
			} else {
				request.setAttribute("status", "failed");
				
			}
			dispatcher.forward(request, response);
		} catch (Exception e) {
	        throw new ServletException("Plot Request Failed", e);
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
