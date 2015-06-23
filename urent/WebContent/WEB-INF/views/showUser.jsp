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
<title>User Detail</title>
</head>
<body>
<div id="page-wrapper">
		<!-- Header -->

		<header id="header">
		<h1>uRent</h1>
		<nav id="nav"> <sec:authorize access="isAuthenticated()">
			<sec:authentication property="principal.username" var="username" />
		</sec:authorize>

		<ul>
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

	
	
	
	
	
	
	
	
	<center>
		<!--  Error message ----------------------------------------------------------- -->
		<c:if test="${not empty errorMessage}">
			<div class="alert alert-danger" role="alert">${errorMessage}</div>
		</c:if>
		<!--  Error message ----------------------------------------------------------- -->

		<!--  Warning message ----------------------------------------------------------- -->
		<c:if test="${not empty warningMessage}">
			<div class="alert alert-warning" role="warning">${warningMessage}</div>
		</c:if>
		<!--  Warning message ----------------------------------------------------------- -->

		<!--   message ----------------------------------------------------------- -->
		<c:if test="${not empty message}">
			<div class="alert alert-success" role="warning">${message}</div>
		</c:if>
		<!--   message ----------------------------------------------------------- -->
	</center>

	<article id="main"> <header class=special container>
		<span class="icon fa-user"></span> <img
			src="getUserImage/<c:out value="${user.username}" />.do"
			height="200px" width="200px" />


		<h2 align="center">
			<font color="#83d3c9">${user.username}</font>
		</h2>
		<br>
		<h1 align="center">${user.description}</h1>
		<br>
		<h1 align="center">
			<font color="#83d3c9">E-Mail: </font>${user.email}</h1>
		<h1 align="center">
			<font color="#83d3c9">Tel.:</font>${user.telephone}</h1>

		</header>
	</center>
	<br>


	
<!--  list my rentables ----------------------------------------------------------- -->



		<!-- One --> <section class="wrapper style4 special container">

		<h2>My Rentables</h2>

		<table data-toggle="table" data-classes="table table-hover "
			data-striped="false" data-sort-name="stargazers_count"
			data-sort-order="desc" data-search="true">




			<thead>
				<tr>
					<th data-field="image" data-sortable="true">Image</th>
					<th data-field="category" data-sortable="true">Category</th>
					<th data-field="title" data-sortable="true">Title</th>
					<th data-field="location" data-sortable="true"">Location</th>
					<th data-field="price" data-sortable="true">Price/Day</th>
					<th class="col-md-2">Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${rentables}" var="rentable">
					<tr>
						<td><img src="getImage/<c:out value="${rentable.id}"/>.do"
							height="125px" width="125px" /></td>
						<td>${rentable.category.name}</td>
						<td>${rentable.title}</td>

						<td>${rentable.location.street}<br>${rentable.location.zip}
							${rentable.location.city}
						</td>

						<td><fmt:setLocale value="de_DE" scope="session" /> <fmt:formatNumber
								value="${rentable.price}" type="currency" currencySymbol="€" /></td>

						<td><a href="showRentable?id=${rentable.id}">
								<button type="button" class="btn btn-xs btn-default">
									<span class="glyphicon glyphicon-map-marker"></span> Show
								</button>
						</a> <sec:authorize access="hasRole('ROLE_USER')">
								<a href="editRentable?id=${rentable.id}">
									<button type="button" class="btn btn-xs btn-default">
										<span class="glyphicon glyphicon-pencil"></span> Edit
									</button>
								</a>
							</sec:authorize> <sec:authorize access="hasRole('ROLE_USER')">
								<a href="delete?id=${rentable.id}">
									<button type="button" class="btn btn-xs btn-danger">
										<span class="glyphicon glyphicon-trash"></span> Delete
									</button>
								</a>
							</sec:authorize> <sec:authorize access="hasRole('ROLE_ADMIN')">
								<a href="deleteAdmin?id=${rentable.id}">
									<button type="button" class="btn btn-xs btn-danger">
										<span class="glyphicon glyphicon-trash"></span> Delete Admin
									</button>
								</a>
							</sec:authorize></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	

</body>
</html>