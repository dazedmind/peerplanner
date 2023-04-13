package com.haritex.registration;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RegistrationServlet
 */
@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String uname = request.getParameter("name");
		String uemail = request.getParameter("email");
		String username = request.getParameter("username");
		String upass = request.getParameter("password");
		String umobile = request.getParameter("contact");
		RequestDispatcher dispatcher = null;
		Connection con = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			 con = DriverManager.getConnection("jdbc:mysql://localhost:3306/peerplan","root", "");
			String q = "INSERT INTO userlist(username,password,name,email,phoneno) VALUES(?,?,?,?,?)";
			PreparedStatement st = con.prepareStatement(q);
			st.setString(1, username);
			st.setString(2, upass);
			st.setString(3, uname);
			st.setString(4, uemail);
			st.setString(5, umobile);
			
			int rowCount = st.executeUpdate();
			dispatcher = request.getRequestDispatcher("register.jsp");
			if (rowCount > 0) {
				request.setAttribute("status", "success");
			} else {
				request.setAttribute("status", "failed");
				
			}
			dispatcher.forward(request, response);
		} catch (Exception e) {
	        throw new ServletException("Login failed", e);
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
