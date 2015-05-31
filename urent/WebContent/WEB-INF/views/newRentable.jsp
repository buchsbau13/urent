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
<jsp:include page="includes/bootstrapMeta.jsp" />
<title>New Rentable</title>
<jsp:include page="includes/bootstrapCss.jsp" />
</head>
<body>

	<nav class="navbar navbar-inverse">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="./">uRent</a>
		</div>
		<div>
			<ul class="nav navbar-nav navbar-right">
				<li><sec:authorize access="isAnonymous()">
						<a href="./login" class="nav-item"><span
							class="glyphicon glyphicon-log-in"></span> Log In</a>
					</sec:authorize></li>
				<li><sec:authorize access="isAuthenticated()">
						<c:url value="logout" var="logoutUrl" />
						<form action="${logoutUrl }" method="post">
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" /> <label class="nav-item"><span
								class="glyphicon glyphicon-log-out"></span><input type="submit"
								value="Log Out" /></label>
						</form>
					</sec:authorize></li>
				<li><a href="./signup" class="nav-item"><span
						class="glyphicon glyphicon-user"></span> Sign Up</a></li>
				<li><sec:authorize
						access="hasAnyRole('ROLE_ADMIN', 'ROLE_USER')">
						<a href="./newRentable" class="nav-item"><span
							class="glyphicon glyphicon-plus"></span> New Rentable</a>
					</sec:authorize></li>
				<li><sec:authorize
						access="hasAnyRole('ROLE_ADMIN', 'ROLE_USER')">
						<a href="./dashboard" class="nav-item"> Dashboard</a>
					</sec:authorize></li>
			</ul>
		</div>
	</div>
	</nav>

	<div class="row">
		<div class="col-md-8 col-md-offset-2">
			<form:form class="form-horizontal" method="post"
				action="${formAction}?${_csrf.parameterName}=${_csrf.token}"
				enctype="multipart/form-data">
				<fieldset>
					<legend>${legend}</legend>

					<! ----------------  category ---------------- -->
					<div class="form-group">
						<label for="inputCategory" class="col-md-2 control-label">Category</label>
						<div class="col-md-10">


							<form:select path="categoryId">
								<form:option value="0" label="--- Select ---" />
								<form:options items="${categories}" itemValue="id"
									itemLabel="name" />
							</form:select>
						</div>
					</div>
					<! ----------------  title ---------------- -->
					<div class="form-group">
						<label for="inputTitel" class="col-md-2 control-label">Title</label>
						<div class="col-md-10">
							<input class="form-control" id="inputTitle" type="text"
								name="title">
						</div>
					</div>
					<! ----------------  description  ---------------- -->
					<div class="form-group">
						<label for="inputDescription" class="col-md-2 control-label">Description</label>
						<div class="col-md-10">
							<input class="form-control" id="inputDescription" type="text"
								name="description">
						</div>
					</div>

					<! ----------------  price  ---------------- -->
					<div class="form-group">
						<label for="inputPrice" class="col-md-2 control-label">Price</label>
						<div class="col-md-10">
							<input class="form-control" id="inputPrice" type="text"
								name="price">
						</div>
					</div>

					<! ----------------  location.street  ---------------- -->
					<div class="form-group">
						<label for="inputLocationStreet" class="col-md-2 control-label">Location
							Street</label>
						<div class="col-md-10">
							<input class="form-control" id="inputLocationStreet" type="text"
								name="street">
						</div>
					</div>

					<! ----------------  location.city ---------------- -->
					<div class="form-group">
						<label for="inputLocationCity" class="col-md-2 control-label">Location
							City</label>
						<div class="col-md-10">
							<input class="form-control" id="inputLocationCity" type="text"
								name="city">
						</div>
					</div>

					<! ----------------  location.country ---------------- -->
					<div class="form-group">
						<label for="inputLocationCountry" class="col-md-2 control-label">Location
							Country</label>
						<div class="col-md-10">
							<input class="form-control" id="inputLocationCountry" type="text"
								name="country">
						</div>
					</div>

					<! ----------------  location.zip ---------------- -->
					<div class="form-group">
						<label for="inputLocationZip" class="col-md-2 control-label">Location
							ZIP</label>
						<div class="col-md-10">
							<input class="form-control" id="inputLocationZip" type="text"
								name="zip">
						</div>
					</div>

					<! ----------------  image  ---------------- -->
					<div class="form-group">
						<label for="inputImage" class="col-md-2 control-label">Image</label>
						<div class="col-md-10">
							<input type="file" name="file"> 
						</div>
					</div>


					<! ----------------  buttons ---------------- -->
					<div class="form-group">
						<div class="col-md-10 col-md-offset-2">
							<button type="submit" class="btn btn-primary">Submit</button>
							<a href="list">
								<button type="button" class="btn btn-default">Cancel</button>
							</a>
						</div>
					</div>
				</fieldset>
			</form:form>
		</div>
	</div>

	</div>
	<!--  End of container -->

</body>
</html>