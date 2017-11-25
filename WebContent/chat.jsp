<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="database.object.User" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		
		<link rel="stylesheet" type="text/css" href="css/Design.css" />
		<link rel="stylesheet" type="text/css" href="css/materialize.css" />
		
		<!-- Compiled and minified JavaScript -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
		 
		<meta charset="UTF-8">
		
		<title>Web Socket Chat Client</title>
		
		<script>
		<%
			String courseName = request.getParameter("course");
			System.out.println("chat.jsp for course: " + courseName);
		%>
			var socket;
			function connectToServer(){
				console.log("ws://localhost:8080/" +
			            "${not empty pageContext.request.contextPath ? pageContext.request.contextPath: ""}" + "/chatroom" + "?class=" + "<%= courseName %>");
				socket = new WebSocket("ws://localhost:8080/" +
			            "${not empty pageContext.request.contextPath ? pageContext.request.contextPath: ""}" + "/chatroom" + "?class=" + "<%= courseName %>");

				socket.onopen = function(event){
					document.getElementById("mychat").innerHTML +=" User connected!<br />";
				};
				
				socket.onmessage = function(event){
					document.getElementById("mychat").innerHTML += event.data + "<br />";
				};
				
				socket.onclose = function(event){
					document.getElementById("mychat").innerHTML += "disconnected!<br />";
				};
				
				
			}	
			
			function sendMessage(name){
				var d = new Date();
				var n = d.toLocaleTimeString();
				n=n.substring(0,4);
				if(document.chatform.message.value !=""){
					socket.send(n + " - " + name + ": " + document.chatform.message.value); //need to change User to login user
					document.getElementById("myArea").value = "";
				}
				return false; 
		
			}
			
			function errMsg() {
				document.getElementById("mychat").innerHTML += "<span>You must be logged in to send messages!</span><br />" ;
				return false;
			}
			
		</script>
	</head>
	<body onload="connectToServer()" style="overflow:scroll;">
	<%
		User currUser = (User) request.getSession().getAttribute("user");
	%>
	
		<nav class="transparent z-depth-0">
	    		<div class="nav-wrapper">
	      		<font id = "titleChat">LiveClass</font>
	      		<ul class="right hide-on-med-and-down">
	      		<li><a href="index.jsp" id="navBtns">Home</a></li>
	      	<%
	      		if(currUser == null) {
	      	%>
	        	 	<li><a href="login.html" id="navBtns">Login</a></li>
	        	 <%
	      		}
	      		else {
	        	 %>
	        	 	<li><a href="logout.jsp" id="navBtns">Logout</a></li>
	        	 <%
	      		}
	        	 %>
	      			<!-- <li><a href="index.html" id="navBtns" class="waves-effect waves-light btn">Home</a></li>
	        			<li><a href="login.html" id="navBtns" class="waves-effect waves-light btn">Login</a></li> -->
	      		</ul>
	    		</div>
	  	</nav> 
	  	
	  	<div id="container">
	    		<img id="target" style="display: inline;"/>
		</div>
		<script type="text/javascript">
		    // to see live stream on another computer, change localhost:8080 to the ip address of that computer
		    "use strict";
		    let ws = new WebSocket("ws://localhost:8080/" +
		            "${not empty pageContext.request.contextPath ? pageContext.request.contextPath: ""}" + "/liveStream"); 
		    /* ws.send("course:" + courseName); */
		    let target = document.getElementById("target");
		
		    ws.onmessage = function (msg) {
		    		console.log("video received");
		        let url = URL.createObjectURL(msg.data);
		        target.onload = function () {
		            window.URL.revokeObjectURL(url);
		        };
		        target.src = url;
		    }
		</script>
	  
		<div id="chatbox"> 
			<div id="mychat"></div>
			
			<%
				if(currUser != null) {
					String name = currUser.getFirstName();
			%>
					<div id="chattextarea">
						<form name="chatform" onsubmit="return sendMessage('<%=name%>')"">
							<input id="myArea" type="text" name="message" placeholder="Type here..">
							<input class = "btn" id="button1" type="submit" name="submit" value="Send Message" />
						</form>
					</div>
			<%
				}
				else {
					
			%>
					<div id="chattextarea">
						<form name="chatform" onsubmit="return errMsg();">
							<input id="myArea" type="text" name="message" placeholder="Type here..">
			
							<input class = "btn" id="button1" type="submit" name="submit" value="Send Message" />
						</form>
					</div>
			<%
				}
			%>
		</div>
		<br />
		
	</body>
</html>