<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="resources/js/jquery.min.js"></script>
<script src="resources/js/jquery.dropotron.min.js"></script>
<script src="resources/js/jquery.scrolly.min.js"></script>
<script src="resources/js/jquery.scrollgress.min.js"></script>
<script src="resources/js/skel.min.js"></script>
<script src="resources/js/util.js"></script>
<script src="resources/js/main.js"></script>
<meta name="viewport" content="width_device-width, initial-scale=1">
<jsp:include page="includes/bootstrapMeta.jsp" />
<jsp:include page="includes/bootstrapCss.jsp" />
<jsp:include page="includes/bootstrapJs.jsp" />
<link rel="stylesheet" type="text/css"
	href=<c:url value='/resources/css/font-awesome.min.css'/> />
<title>ShowRentable</title>

<script type="text/javascript"
	src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
<script type="text/javascript">
	function loadMap() {
		//var latlng = new google.maps.LatLng(4.3695030, 101.1224120);
		var myOptions = {
			zoom : 15,
			//center: latlng,
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};
		var map = new google.maps.Map(document.getElementById("map_container"),
				myOptions);
		var geocoder = new google.maps.Geocoder();
		var address = '${rentable.location.street}, ${rentable.location.city}, ${rentable.location.country}, ${rentable.location.zip}';
		// Creating an InfoWindow          
		var infowindow = new google.maps.InfoWindow({});
		
		geocoder.geocode({
			'address' : address
		}, 
		function(results, status) 
		{
			if (status == google.maps.GeocoderStatus.OK) 
			{
				map.setCenter(results[0].geometry.location);
				var marker = new google.maps.Marker
				({
					map : map,
					position : results[0].geometry.location
				});
				
				google.maps.event.addListener(marker, 'click', 
		        	function() 
		        	{
		        		if (marker.getAnimation() != null) 
		        		{
		        	    	marker.setAnimation(null);
		        	    	infowindow.close();
		        	  	} 
		        		else 
		        		{
		        	    	marker.setAnimation(google.maps.Animation.BOUNCE);
		        	    	infowindow.setContent(address);
				            infowindow.open(map, this);
		        	  	}
		        	});
		        google.maps.event.addListener(map, "click", 
	    			function(event) 
	    			{
	    			    infowindow.close();
	    			    marker.setAnimation(null);
	            	  	
	    			});
				
			} else {
				alert('Geocode was not successful for the following reason: '
						+ status);
			}
		});
		
		

	}
</script>

<jsp:include page="includes/bootstrapCss.jsp" />
</head>
<body onload="loadMap()">

	<div id="page-wrapper">
		<!-- Header -->

		<header id="header">
		<h1>uRent</h1>
		<nav id="nav"> <sec:authorize access="isAuthenticated()">
			<sec:authentication property="principal.username" var="username" />
		</sec:authorize>

		<ul>
			<li class="current"><a href="showRentable?id=${rentable.id}">${rentable.title}</a></li>
			<li class="current"><a href="./">Welcome</a></li>
			<li><sec:authorize access="isAnonymous()">
					<a href="./login" class="nav-item">Log In</a>
				</sec:authorize></li>
			<li><sec:authorize access="isAuthenticated()">
					<a href="./logout" class="nav-item">Log Out</a>
				</sec:authorize></li>
			<li><sec:authorize access="isAnonymous()">
					<a href="./signup" class="button special">Sign Up</a>
				</sec:authorize></li>
			<li><sec:authorize
					access="hasAnyRole('ROLE_ADMIN', 'ROLE_USER')">
					<a href="./newRentable" class="nav-item"></span>New Rentable</a>
				</sec:authorize></li>
			<li><sec:authorize
					access="hasAnyRole('ROLE_ADMIN', 'ROLE_USER')">
					<a href="./dashboard" class="button special">${username}</a>
				</sec:authorize></li>
		</ul>
		</nav> </header>


	
	
	
	
	
	
	<div class="row">
			<div class="sidebar">
	<div align="left">
		<img src="getImage/<c:out value="${rentable.id}" />.do" height="300px"
			width="300px" />
	</div>
	<br>
	<h1 align="left">${rentable.title}</h1>
	<h1 align="left">${rentable.description}</h1>
	<h1 align="left">From: ${rentable.user.username}</h1>
	<h1 align="left">Price/Day: ${rentable.price} Euro</h1>
	<h1 align="left">Contact: ${rentable.user.email}</h1>
	<h1 align="left">Tel: ${rentable.user.telephone}</h1>
	

	

</div>
</div>
<div id="map_container"></div>
</body>
</html>