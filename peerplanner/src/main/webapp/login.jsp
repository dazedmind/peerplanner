<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <link rel="icon" href="images/peerplanner.png" type="image/x-icon">
    <title>PeerPlanner</title>
</head>
<body>

<input type="hidden" id="status" value="<%= request.getAttribute("status") %>">

    <header>
        <div class="header-box">
            <img src="images/peerplanner.png" alt="" style="width: 4rem;">
            <h1>PeerPlanner</h1>
        </div>
    </header>

    <main>
        <h1>Log In</h1>
        <div class="container">
            <form action="login" method="POST" class="login-form">
                <label for="username">Username</label>
                <input name="username" id="username-input" type="text">
                <label for="password">Password</label>
                <input name="password" id="password-input" type="password">
                <span class="btn-container">
                    <input id="login-btn" type="submit" value="Sign In">
                </span>
            </form>
        </div>
        <p>Don't have an account yet? <span class="ext-link"><a href="register.jsp">Create Account</a></span></p>
    </main>
    
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.11.0/sweetalert2.css" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.11.0/sweetalert2.all.min.js"></script>
	
    <script type="text/javascript">
    	var status = document.getElementById("status").value;
    	if (status == "failed") {
    		swal("Sorry", "Wrong Username/Password", "failed");
    	}
    </script>
</body>
</html>