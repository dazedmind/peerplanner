<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <title>Create Account</title>
</head>
<body>

<input type="hidden" id="status" value="<%= request.getAttribute("status") %>">


    <header>
        <div class="header-box">
            <img class="header-img" src="images/peerplanner.png" alt="">
            <a href="index.jsp">          
                <h1>PeerPlanner</h1>
            </a>        
        </div>
    </header>

    <div class="create-container">
        <h1>Create Account</h1>
        <div class="container">
            <form action="register" method="POST" class="registration-form">
                <label for="name">Name</label>
                <input name="name" id="name-input" type="text">
                
                <label for="email">Email (optional)</label>
                <input name="email" id="email-input" type="text">
                
                <label for="contact">Phone Number</label>
                <input name="contact" id="contact-input" type="tel">
                
                <label for="username">Username</label>
                <input name="username" id="username-input" type="text">
                
                <label for="password">Password</label>
                <input name="password" id="password-input" type="password">
                <span class="btn-container">
                    <input id="register-btn" type="submit" value="Sign Up">
                </span>
            </form>
        </div>
    </div>
    
   	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.11.0/sweetalert2.css" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.11.0/sweetalert2.all.min.js"></script>
	
    <script type="text/javascript">
    	var status = document.getElementById("status").value;
    	if (status == "success") {
    		swal("Congratulations", "Account successfully created!", "success");
    	}
    </script>
</body>
</html>
