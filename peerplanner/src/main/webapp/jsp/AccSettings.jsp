<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/main.css">
    <link rel="shortcut icon" href="../images/peerplanner.png" type="image/x-icon">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css" integrity="sha512-SzlrxWUlpfuzQ+pcUCosxcglQRNAq/DZjVsC0lE40xsADsfeQoEypE+enwcOiGjk/bSuGGKHEyjSoQ1zVisanQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <title>PeerPlanner - Plots</title>
</head>
<body>
    <header>
        <div class="header-box">
            <img class="header-img" src="../images/peerplanner.png" alt="">
            <a href="Main.jsp">          
                <h1>PeerPlanner</h1>
            </a>
        </div>
        <nav>
            <ul class="nav-links">
                <li>
                    <a class="link" href="Main.jsp"><i class="fa-solid fa-house"></i>Home</a>
                </li>
                <li>
                    <a class="link" href="Plots.jsp"><i class="fa-solid fa-calendar"></i>Plots</a>
                </li>
                <li>
                    <a class="link" href="PeerList.jsp"><i class="fa-solid fa-user-group"></i>Peers</a>
                </li>
                <li>
                    <a class="link" href="PlotRequest.jsp"><i class="fa-solid fa-plug"></i>Plot Requests</a>
                </li>
            </ul>
            <span id="profile-menu">
                <img src="../images/user.png" alt="" style="width: 2.5rem; height: 2.5rem;">
                <div id="hidden-menu">
                    <ul class="nav-links-hidden">
                        <li>
                            <a class="hidden-link" href="/">Account Settings</a>
                        </li>
       					<li>
                            <a class="hidden-link" href="Notification.jsp">Notifications</a>
                        </li>
                        <li>
                            <a class="hidden-link" href="PeerRequest.jsp">Peer Requests</a>
                        </li>
                        <li>
                            <a class="hidden-link" href="../login.jsp">Log Out</a>
                        </li>
                    </ul>
                </div>
            </span>
        </nav>
    </header>

    
    <div class="main-acc-settings">
        <h1>Account Settings</h1>

        <div class="info">
        	<div class="profile-pic-container">
	        	<img src="../images/user.png" alt="" style="width: 5rem; height: 5rem;">
	            <form action="/upload" method="POST">
					<input type="file" id="actual-btn" hidden/>
					
					<!--our custom file upload button-->
					<label class="choose-btn" for="actual-btn">Choose File</label>
		            
		            <input id="img-submit-btn" type="submit" name="submit" value="Upload">
	            </form>
        	</div>

            
            <h2>Personal Information:</h2>
            <span class="info-span">
                <h4>Name: </h4>
                <p>${sessionScope.name}</p>
            </span>
            <span class="info-span">
                <h4>Email: </h4>
                <p>${sessionScope.email}</p>
            </span>
            <span class="info-span">
                <h4>Username: </h4>
                <p>${sessionScope.username}</p>
            </span>

            <div class="acc-options">
            	<form class="danger-btn-cont" method="post" action="">
            		<button id="change-pass">Change Password</button>
            		<button id="danger">Delete Account</button>
            	</form>
            </div>
        </div>
    </div>

    <script src="../scripts/script.js"></script>

</body>
</html>