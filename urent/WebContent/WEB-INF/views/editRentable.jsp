<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width_device-width, initial-scale=1">
<script src="resources/js/jquery.min.js"></script>
<script src="resources/js/jquery.dropotron.min.js"></script>
<script src="resources/js/jquery.scrolly.min.js"></script>
<script src="resources/js/jquery.scrollgress.min.js"></script>
<script src="resources/js/skel.min.js"></script>
<script src="resources/js/util.js"></script>
<script src="resources/js/main.js"></script>
<jsp:include page="includes/bootstrapMeta.jsp" />

<link rel="stylesheet" type="text/css"
	href=<c:url value='/resources/css/font-awesome.min.css'/> />
<jsp:include page="includes/bootstrapMeta.jsp" />
<title>Edit Rentable</title>
<jsp:include page="includes/bootstrapCss.jsp" />
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
	
	<!-- Main -->

		<article id="main"> <header class=special container>
		<span class="icon fa-pencil "></span>
		<h2>Edit Rentable</h2>
		</header> <!-- One --> <section class="wrapper style4 special container 50%">
	
	<center>
			<!--  Error message ------------------------------------------------------------->
			<c:if test="${not empty errorMessage}">
				<div class="alert alert-danger" role="alert">${errorMessage}</div>
			</c:if>
			<!--  Error message ------------------------------------------------------------->

			<!--  Warning message ------------------------------------------------------------->
			<c:if test="${not empty warningMessage}">
				<div class="alert alert-warning" role="warning">${warningMessage}</div>
			</c:if>
			<!--  Warning message ------------------------------------------------------------->

			<!--   message ------------------------------------------------------------->
			<c:if test="${not empty message}">
				<div class="alert alert-success" role="warning">${message}</div>
			</c:if>
			<!--   message ------------------------------------------------------------->
		</center>
		

	<form:form class="form" method="post"
			action="${formAction}?${_csrf.parameterName}=${_csrf.token}"
			enctype="multipart/form-data" role="form">


			<legend>${legend}</legend>

					<! ----------------  id ---------------- -->
					<div class="form-group">
						
							<input type="hidden" class="form-control" id="inputID"
								type="text" name="id" value="<c:out value="${rentable.id}"/>">
						
					</div>
					<! ----------------  title ---------------- -->
					<div class="form-group">
						<label for="inputTitel" class="control-label">Title</label>
					
							<input class="form-control" id="inputTitle" type="text"
								name="title" value="<c:out value="${rentable.title}"/>">
					
					</div>
					<! ----------------  description  ---------------- -->
					<div class="form-group">
						<label for="inputDescription" class="control-label">Description</label>
				
							<input class="form-control" id="inputDescription" type="text"
								name="description"
								value="<c:out value="${rentable.description}"/>">

					</div>

					<! ----------------  price  ---------------- -->
					<div class="form-group">
						<label for="inputPrice" class="control-label">Price</label>
					
							<input class="form-control" id="inputPrice" type="text"
								name="price" value="<c:out value="${rentable.price}"/>">
					
					</div>

					<! ----------------  location.street  ---------------- -->
					<div class="form-group">
						<label for="inputLocationStreet" class="control-label">Location
							Street</label>
					
							<input class="form-control" id="inputLocationStreet" type="text"
								name="street"
								value="<c:out value="${rentable.location.street}"/>">
						
					</div>

					<! ----------------  location.city ---------------- -->
					<div class="form-group">
						<label for="inputLocationCity" class="control-label">Location
							City</label>
					
							<input class="form-control" id="inputLocationCity" type="text"
								name="city" value="<c:out value="${rentable.location.city}"/>">
						
					</div>

					<! ----------------  location.country ---------------- -->
					<div class="form-group">
						<label for="inputLocationCountry" class="control-label">Location
							Country</label>
					
							<input class="form-control" id="inputLocationCountry" type="text"
								name="country"
								value="<c:out value="${rentable.location.country}"/>">
						
					</div>

					<! ----------------  location.zip ---------------- -->
					<div class="form-group">
						<label for="inputLocationZip" class="control-label">Location
							ZIP</label>
						
							<input class="form-control" id="inputLocationZip" type="text"
								name="zip" value="<c:out value="${rentable.location.zip}"/>">
					
					</div>

					<! ----------------  image  ---------------- -->
					<div class="form-group">
						<label for="inputImage">Image</label>
						<center>
							<input type="file" name="file">
							</center>
					

					</div>

					<! ----------------  buttons ---------------- -->
					<div class="form-group">
					
							<button type="submit" class="btn btn-default">Submit</button>
							<a href="list">
								<button type="button" class="btn btn-default">Cancel</button>
							</a>
						</div>
					
				
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
				</form:form>
	
	</div>
	<!--  End of container -->

</body>
</html>