<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="includes/bootstrapMeta.jsp" />
<title>u.rent</title>
<jsp:include page="includes/bootstrapCss.jsp" />
</head>
<body>
	<div class="masthead">
		<div class="container">
			<nav class="nav"> <a href="./login" class="nav-item">Log In</a>
			<a href="Sign Up" class="nav-item">Sign Up</a> 
			<a href="./newRentable" class="nav-item">New Rentable</a></nav>
		</div>

	</div>

	<div class="container">

		<div class="header">
			<h1 class="title">u.rent</h1>

		</div>
	</div>
	<center>

		<br> <a href="fill">Fill Sample Data</a>

		<!--  list all persons ----------------------------------------------------------- -->
		<h1>Rentables</h1>
		<table cellpadding="5" cellspacing="5" border="1">
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
						<td>${rentable.id}</td>
						<td>${rentable.category.name}</td>
						<td>${rentable.title}</td>
						<td>${rentable.description}</td>
						<td>${rentable.price}</td>
						<td><a href="delete?id=${rentable.id}">Delete</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</center>


</body>
</html>