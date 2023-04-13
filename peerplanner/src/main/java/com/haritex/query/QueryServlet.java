package com.haritex.query;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/query")
public class QueryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final String DB_URL = "jdbc:mysql://localhost:3306/peerplan";
  private static final String DB_USER = "root";
  private static final String DB_PASSWORD = "";

  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String userId = request.getParameter("search-peers");
    User user = retrieveUser(userId);
    request.setAttribute("user", user);
    request.getRequestDispatcher("PeerList.jsp").forward(request, response);    
  }


  private User retrieveUser(String userId) {
    User user = null;
    try {
      Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
      PreparedStatement ps = conn.prepareStatement("SELECT * FROM userlist WHERE id = ?");
      ps.setString(1, userId);
      ResultSet rs = ps.executeQuery();
      if (rs.next()) {
        user = new User(rs.getInt("id"), rs.getString("name"), rs.getString("email"));
      }
      rs.close();
      ps.close();
      conn.close();
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return user;
  }
  
  public class User {
    private int id;
    private String name;
    private String email;
    
    public User(int id, String name, String email) {
      this.id = id;
      this.name = name;
      this.email = email;
    }
    
    public int getId() {
      return id;
    }
    
    public String getName() {
      return name;
    }
    
    public String getEmail() {
      return email;
    }
  }
}
