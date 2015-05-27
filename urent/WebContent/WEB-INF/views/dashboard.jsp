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
<title>Dashboard</title>
</head>
<body>

	<!-- 	<div class="masthead"> -->
	<!-- 		<div class="container"> -->

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
	</nav>
	</ul>
	</div>

	<!--  list all persons ----------------------------------------------------------- -->
	<center>
		<h1>My Rentables</h1>
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
							<th>Location</th>
							<th>Image</th>
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
								<td class="col-md-1">${rentable.location.street}
									${rentable.location.zip} ${rentable.location.city}</td>
								<td class="col-md-1"><img
									src="getImage/<c:out value="${rentable.id}"/>.do" height="75px"
									width="75px" /></td>
								<td class="col-md-1">
									<sec:authorize
										access="hasRole('ROLE_USER')">
										<a href="showRentable?id=${rentable.id}">
											<button type="button" class="btn btn-xs btn-success">
												<span class="glyphicon glyphicon-pencil"></span> Show
											</button>
										</a>
									</sec:authorize>
								
									<sec:authorize
										access="hasRole('ROLE_USER')">
										<a href="editRentable?id=${rentable.id}">
											<button type="button" class="btn btn-xs btn-success">
												<span class="glyphicon glyphicon-pencil"></span> Edit
											</button>
										</a>
									</sec:authorize>
									<sec:authorize access="hasRole('ROLE_USER')">
										<a href="deleteRentable?id=${rentable.id}">
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

	</center>

</body>
</html>