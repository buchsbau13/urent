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
<title>Sport</title>
<script type="text/javascript"
	src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>

<script type="text/javascript">
	function loadMap() 
	{
		var myOptions = 
		{
			zoom : 12,
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};
		var map = new google.maps.Map(document.getElementById("map_container"),
				myOptions);
		/*var geocoder = new google.maps.Geocoder();
		var address = '${rentables[0].location.street}, ${rentables[0].location.city}, ${rentables[0].location.country}, ${rentables[0].location.zip}';
		geocoder.geocode
		(
			{
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
				} 
				else 
				{
					alert('Geocode was not successful for the following reason: '
							+ status);
				}
			}
		);*/
		
		var javaScriptRentables = [];
				
		<c:forEach items="${rentables}" var="rentable">
			javaScriptRentables.push('${rentable.location.street}, ${rentable.location.city}, ${rentable.location.country}, ${rentable.location.zip}');
		</c:forEach>
		
		for (i = 0; i < javaScriptRentables.length; i++) 
		{
		    var geocoder = new google.maps.Geocoder();
			var address = javaScriptRentables[i];
		    //var address = '${rentables[0].location.street}, ${rentables[0].location.city}, ${rentables[0].location.country}, ${rentables[0].location.zip}';
			geocoder.geocode
			(
				{
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
					} 
					else 
					{
						alert('Geocode was not successful for the following reason: '
								+ status);
					}
				}
			);
		}
		
		/*var geocoder2 = new google.maps.Geocoder();
		var address2 = '${rentables[1].location.street}, ${rentables[1].location.city}, ${rentables[1].location.country}, ${rentables[1].location.zip}';
		geocoder2.geocode
		(
			{
				'address' : address2
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
				} 
				else 
				{
					alert('Geocode was not successful for the following reason: '
							+ status);
				}
			}
		);*/
	}
</script>
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
			<li class="current"><a href="./categorySport">Sport</a></li>
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




		<!--  list rentablesSport-->



		<div class="row">
			<div class="sidebar">
				<div class="right">
					<header class=special> <span class="icon fa-futbol-o "></span>
				</div>
				</header>

				<h2>Your place for sporty Stuff</h2>

				<p>Snowboard, Soccerball or Tennisracket. This is the place to
					find it!</p>






				<table data-toggle="table" data-classes="table table-hover "
					data-striped="false" data-sort-name="stargazers_count"
					data-sort-order="desc" data-search="true" data-show-toggle="true">

					<thead>
						<tr>
							<th data-field="title" data-sortable="true" class="col-md-0.5">Title</th>
							<th data-field="from" data-sortable="true" class="col-md-0.5">From</th>
							<th data-field="category" data-sortable="true" class="col-md-0.5">Category</th>
							<th data-field="description" data-sortable="true"
								class="col-md-3.5">Description</th>
							<th data-field="location" data-sortable="true" class="col-md-3">Location</th>
							<th data-field="price" data-sortable="true" class="col-md-1">Price</th>
							<th data-field="image" data-sortable="true" class="col-md-1">Image</th>
							<th class="col-md-2">Action</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${rentables}" var="rentable">
							<tr>
								<td>${rentable.title}</td>
								<td><a href="showUser?id=${user.username}">${rentable.user.username}</a></td>

								<td>${rentable.category.name}</td>

								<td>${rentable.description}</td>
								<td>${rentable.location.street}<br>
									${rentable.location.zip} ${rentable.location.city}
								</td>
								<td>${rentable.price}Euro</td>

								<td><img src="getImage/<c:out value="${rentable.id}"/>.do"
									height="75px" width="75px" /></td>
								<td><sec:authorize access="hasRole('ROLE_ADMIN')">
										<a href="deleteRentable?id=${rentable.id}">
											<button type="button" class="btn btn-xs btn-danger">
												<span class="glyphicon glyphicon-trash"></span> Delete
											</button>
										</a>
									</sec:authorize> <sec:authorize access="hasRole('ROLE_USER')">
										<a href="rateRentable?id=${rentable.id}">
											<button type="button" class="btn btn-xs btn-success">
												<span class="glyphicon glyphicon-pencil"></span> Rate
											</button>
										</a>
									</sec:authorize> <a href="categorySport?id=${rentable.id}">
										<button type="button" class="btn btn-xs btn-success">
											<span class="glyphicon glyphicon-pencil"></span> Show
										</button>
								</a></td>
							</tr>
						</c:forEach>
					</tbody>


				</table>

			</div>





		</div>



	</div>


	<div id="map_container"></div>


</body>
</html>