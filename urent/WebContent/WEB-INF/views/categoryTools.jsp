<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>Tools</title>
<script type="text/javascript"
	src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>

<script type="text/javascript">
	function loadMap() {
		var myOptions = {
			zoom : 12,
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};
		var map = new google.maps.Map(document.getElementById("map_container"),
				myOptions);

		var jsRentablesLocation = [];
		var jsRentablesTitle = [];

		<c:forEach items="${rentables}" var="rentable">
		jsRentablesLocation
				.push('${rentable.location.street}, ${rentable.location.city}, ${rentable.location.country}, ${rentable.location.zip}');
		jsRentablesTitle.push('${rentable.title}');
		</c:forEach>

		for (i = 0; i < jsRentablesLocation.length; i++) {
			var geocoder = new google.maps.Geocoder();
			var address = jsRentablesLocation[i];
			var title = jsRentablesTitle[i];
			geocoder
					.geocode(
							{
								'address' : address
							},
							function(results, status) {
								if (status == google.maps.GeocoderStatus.OK) {
									map.setCenter(results[0].geometry.location);
									var marker = new google.maps.Marker({
										map : map,
										position : results[0].geometry.location
									});
									var infowindow = new google.maps.InfoWindow(
											{});
									google.maps.event
											.addListener(
													marker,
													'click',
													function() {
														if (marker
																.getAnimation() != null) {
															marker
																	.setAnimation(null);
															infowindow.close();
														} else {
															marker
																	.setAnimation(google.maps.Animation.BOUNCE);
															infowindow
																	.setContent(title
																			+ "\r\n"
																			+ address);
															infowindow.open(
																	map, this);
														}
													});
									google.maps.event.addListener(map, "click",
											function(event) {
												infowindow.close();
												marker.setAnimation(null);

											});
									google.maps.eventListener(infowwindow,
											"click", function(event) {
												infowindow.close();
												marker.setAnimation(null);
											});
								} else {
									alert('Geocode was not successful for the following reason: '
											+ status);
								}
							});
		}
	}
</script>
</head>
<body onload="loadMap()">


	<!-- Header -->

	<header id="header">
	<h1>uRent</h1>
	<nav id="nav"> <sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.username" var="username" />
	</sec:authorize>

	<ul>
		<li class="current"><a href="./categoryTools">Tools</a></li>
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
		<li><sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_USER')">
				<a href="./newRentable" class="nav-item"></span>New Rentable</a>
			</sec:authorize></li>
		<li><sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_USER')">
				<a href="./dashboard" class="button special">${username}</a>
			</sec:authorize></li>
	</ul>
	</nav> </header>






	<div class="row">
		<div class="sidebar">
			<div class="right">
				<header class=special> <span class="icon fa-cogs "></span>
			</div>
			</header>

			<h2>Your place for all your tools</h2>

			<p>Repair everything. Find the right tools right here</p>


			<table data-toggle="table" data-classes="table table-hover "
				data-striped="false" data-sort-name="stargazers_count"
				data-sort-order="desc" data-search="true" data-show-toggle="true">

				<thead>
					<tr>
						<th data-field="image" data-sortable="true" class="col-md-1">Image</th>
						<th data-field="title" data-sortable="true" class="col-md-0.5">Title</th>
						<th data-field="from" data-sortable="true" class="col-md-0.5">From</th>
						<th data-field="location" data-sortable="true" class="col-md-3">Location</th>
						<th data-field="price" data-sortable="true" class="col-md-1">Price/Day</th>

						<th class="col-md-2">Action</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${rentables}" var="rentable">
						<tr>
							<td><img src="getImage/<c:out value="${rentable.id}"/>.do"
								height="125px" width="125px" /></td>
							<td>${rentable.title}</td>
							<td><a href="showUser?id=${rentable.id}">${rentable.user.username}</a></td>
							<td>${rentable.location.street}<br>
								${rentable.location.zip} ${rentable.location.city}
							</td>
							<td><fmt:setLocale value="de_DE" scope="session" /> <fmt:formatNumber
									value="${rentable.price}" type="currency" currencySymbol="€" /></td>
							<td><sec:authorize
									access="hasAnyRole('ROLE_ADMIN', 'ROLE_USER')">
									<a href="addToWishlist?id=${rentable.id}">
										<button type="button" class="btn btn-xs btn-default">
											<span class="glyphicon glyphicon-plus"></span> Add to
											Wishlist
										</button>
									</a>
								</sec:authorize> <a href="showRentable?id=${rentable.id}">
									<button type="button" class="btn btn-xs btn-default">
										<span class="glyphicon glyphicon-map-marker"></span> Show
									</button>
							</a> <sec:authorize access="hasRole('ROLE_USER')">
									<a href="rateRentable?id=${rentable.id}">
										<button type="button" class="btn btn-xs btn-default">
											<span class="glyphicon glyphicon-star"></span> Rate
										</button>
									</a>
								</sec:authorize> <sec:authorize access="hasRole('ROLE_ADMIN')">
									<a href="deleteAdmin?id=${rentable.id}">
										<button type="button" class="btn btn-xs btn-danger">
											<span class="glyphicon glyphicon-trash"></span> Delete
										</button>
									</a>
								</sec:authorize></td>
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