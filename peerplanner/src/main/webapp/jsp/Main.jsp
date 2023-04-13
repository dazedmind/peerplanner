<%
	if (session.getAttribute("name")==null) {
		response.sendRedirect("../login.jsp");
	}
%>

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
    <title>PeerPlanner</title>
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
                    <a class="link" id="current__page" href="Main.jsp"><i class="fa-solid fa-house"></i>Home</a>
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
                            <a class="hidden-link" href="AccSettings.jsp">Account Settings</a>
                        </li>
                        <li>
                            <a class="hidden-link" href="../login.jsp">Log Out</a>
                        </li>
                    </ul>
                </div>
            </span>
        </nav>
    </header>

    <div class="main-app">
        <div class="wrapper">
        	<div class="hero-img">
        		<img src="../images/calendar.png" alt="" style="width: 18rem;">
        	</div>
            <div class="main-content">
	            <h1 class="main-text">Welcome, ${sessionScope.name}!</h1>
	            <p> What would you like to do?</p>
	            <span class="main-btn-container">
	                <button class="main-btn" onclick="window.location='../SendPlot.jsp'">Create a PeerPlan</button>
	                <button class="secondary-btn">View Plots</button>
	            </span>
            </div> 
        </div>
    </div>

    <script src="../scripts/script.js"></script>
</body>
</html>