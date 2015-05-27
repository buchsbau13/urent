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
<jsp:include page="includes/bootstrapMeta.jsp" />
<title>ShowRentable</title>
<style type="text/css">
div#map_container{
	width:100%;
	height:350px;
}
</style>
<script type="text/javascript" 
   src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>

<script>
var geocoder;
var map;
function initialize() {
  geocoder = new google.maps.Geocoder();
  var latlng = new google.maps.LatLng(-34.397, 150.644);
  var mapOptions = {
    zoom: 8,
    center: latlng
  }
  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
}

function codeAddress() {
  var address = document.getElementById('address').value;
  geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      map.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
      });
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}

google.maps.event.addDomListener(window, 'load', initialize);

</script>

<script type="text/javascript">
  function loadMap() {
    //var latlng = new google.maps.LatLng(4.3695030, 101.1224120);
    var myOptions = {
      zoom: 12,
      //center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    var map = new google.maps.Map(document.getElementById("map_container"),myOptions);
 	var geocoder = new google.maps.Geocoder();
 	var address= '${rentable.location.street}, ${rentable.location.city}, ${rentable.location.country}, ${rentable.location.zip}';
 	
 	geocoder.geocode( { 'address': address}, function(results, status) {
 	    if (status == google.maps.GeocoderStatus.OK) {
 	      map.setCenter(results[0].geometry.location);
 	      var marker = new google.maps.Marker({
 	          map: map,
 	          position: results[0].geometry.location
 	      });
 	    } else {
 	      alert('Geocode was not successful for the following reason: ' + status);
 	    }
 	  });
 	
   
 
  }
</script>

<jsp:include page="includes/bootstrapCss.jsp" />
</head>
<body  onload="loadMap()">

<nav class="navbar navbar-inverse">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="./">uRent</a>
		</div>
		<div>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="./login" class="nav-item"><span
						class="glyphicon glyphicon-log-in"></span> Log In</a></li>
				<li><a href="./signup" class="nav-item"><span
						class="glyphicon glyphicon-user"></span> Sign Up</a></li>
				<li><a href="./newRentable" class="nav-item"><span
						class="glyphicon glyphicon-plus"></span> New Rentable</a></li>
			</ul>
		</div>
	</div>
	</nav>
<div align="center"><img src="getImage/<c:out value="${rentable.id}" />.do" height="75px"
									width="75px" />
</div>

<h1 align="center">${rentable.title}</h1>

<div id="map_container"></div>


</body>
</html>