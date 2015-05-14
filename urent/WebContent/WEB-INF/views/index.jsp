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
<meta name="viewport" content="width_device-width, initial-scale=1">
<jsp:include page="includes/bootstrapMeta.jsp" />
<jsp:include page="includes/bootstrapCss.jsp" />
<jsp:include page="includes/bootstrapJs.jsp" />
<title>u.rent</title>
</head>
<body>
	<!-- 	<div class="masthead"> -->
	<!-- 		<div class="container"> -->

	<nav class="navbar navbar-inverse">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="#">uRent</a>
		</div>
		<div>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="./login" class="nav-item"><span
						class="glyphicon glyphicon-log-in"></span> Log In</a></li>
				<li><a href="./signup" class="nav-item"><span
						class="glyphicon glyphicon-user"></span> Sign Up</a></li>
				<li><sec:authorize
						access="hasAnyRole('ROLE_ADMIN', 'ROLE_USER')">
						<a href="./newRentable" class="nav-item"><span
							class="glyphicon glyphicon-plus"></span> New Rentable</a>
					</sec:authorize></li>
			</ul>
		</div>
	</div>
	</nav>

	<div class="jumbotron">
		<div class="container">
			<div class="page-header">

				<div class="row">


					<h1 align="center">
						<abbr title="you Rent">uRent</abbr><small> A place for <mark>
							all</mark> your stuff
						</small>

					</h1>
					<blockquote align="center">
						<p align="center">Urent is a great way to convert your
							belongings in some Money</p>
						<footer>By Christoph Fuchsjäger</footer>
					</blockquote>
					<pre>
				"Money is not everything. Money is the only thing" - by Christoph Fuchsjäger</pre>


				</div>




			</div>

		</div>
	</div>
	<center>

		<!--  list all persons ----------------------------------------------------------- -->
		<h1>Rentables</h1>
		<div class="row">

			<div class="table-index">
				<table class="table table-hover">




					<thead>
						<tr>
							<th>ID</th>
							<th>Category</th>
							<th>Title</th>
							<th>Description</th>
							<th>Price</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${rentables}" var="rentable">
							<tr>
								<td class="col-md-1">${rentable.id}</td>
								<td class="col-md-1">${rentable.category.name}</td>
								<td class="col-md-1">${rentable.title}</td>
								<td class="col-md-1">${rentable.description}</td>
								<td class="col-md-1">${rentable.price}</td>
								<td class="col-md-1"><a href="delete?id=${rentable.id}">Delete</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				</table>

			</div>
		</div>

	</center>

	<div class="container">
		<center>
			<h2>Things to rent</h2>
		</center>

		<div class="row">
			<div class="col-lg-4 col-sm-6 col-xs-12">
				<a href="./categorySport"> <img
					src="http://placehold.it/800x600" class="thumbnail img-responsive">
				</a>
			</div>
			<div class="col-lg-4 col-sm-6 col-xs-12">
				<a href="#"> <img src="http://placehold.it/800x600"
					class="thumbnail img-responsive">
				</a>
			</div>
			<div class="col-lg-4 col-sm-6 col-xs-12">
				<a href="#"> <img src="http://placehold.it/800x600"
					class="thumbnail img-responsive">
				</a>
			</div>
			<div class="col-lg-4 col-sm-6 col-xs-12">
				<a href="#"> <img src="http://placehold.it/800x600"
					class="thumbnail img-responsive">
				</a>
			</div>
			<div class="col-lg-4 col-sm-6 col-xs-12">
				<a href="#"> <img src="http://placehold.it/800x600"
					class="thumbnail img-responsive">
				</a>
			</div>
			<div class="col-lg-4 col-sm-6 col-xs-12">
				<a href="#"> <img src="http://placehold.it/800x600"
					class="thumbnail img-responsive">
				</a>
			</div>
			<div class="col-lg-4 col-sm-6 col-xs-12">
				<a href="#"> <img src="http://placehold.it/800x600"
					class="thumbnail img-responsive">
				</a>
			</div>
			<div class="col-lg-4 col-sm-6 col-xs-12">
				<a href="#"> <img src="http://placehold.it/800x600"
					class="thumbnail img-responsive">
				</a>
			</div>
			<div class="col-lg-4 col-sm-6 col-xs-12">
				<a href="#"> <img src="http://placehold.it/800x600"
					class="thumbnail img-responsive">
				</a>
			</div>
		</div>
	</div>
</body>
</html>