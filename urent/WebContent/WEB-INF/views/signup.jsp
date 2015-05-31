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
<title>Sign up</title>
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
							class="glyphicon glyphicon-log-out"></span><input
								type="submit" value="Log Out" /></label>
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
			<form class="form-horizontal" action="${formAction}" method="post">
				<fieldset>
					<legend>${legend}</legend>

					<! ----------------  username ---------------- -->
					<div class="form-group">
						<label for="inputUsername" class="col-md-2 control-label">Username</label>
						<div class="col-md-10">
							<input class="form-control" id="inputUsername" type="text"
								name="username" value="<c:out value="${user.username}"/>">
						</div>
					</div>
					<! ----------------  email ---------------- -->
					<div class="form-group">
						<label for="inputEmail" class="col-md-2 control-label">E-Mail</label>
						<div class="col-md-10">
							<input class="form-control" id="inputEmail" type="text"
								name="email" value="<c:out value="${user.email}"/>">
						</div>
					</div>
					<! ---------------  firstname ---------------- -->
					<div class="form-group">
						<label for="inputFirstname" class="col-md-2 control-label">Firstname</label>
						<div class="col-md-10">
							<input class="form-control" id="inputFirstname" type="text"
								name="firstname" value="<c:out value="${user.firstname}"/>">
						</div>
					</div>
					<! ---------------  lastname ---------------- -->
					<div class="form-group">
						<label for="inputLastname" class="col-md-2 control-label">Lastname</label>
						<div class="col-md-10">
							<input class="form-control" id="inputLastname" type="text"
								name="lastname" value="<c:out value="${user.lastname}"/>">
						</div>
					</div>
					<! --------------  telephone ---------------- -->
					<div class="form-group">
						<label for="inputTelephone" class="col-md-2 control-label">Telephone</label>
						<div class="col-md-10">
							<input class="form-control" id="inputTelephone" type="text"
								name="telephone" value="<c:out value="${user.telephone}"/>">
						</div>
					</div>
					<! ----------------  password  ---------------- -->
					<div class="form-group">
						<label for="inputPassword" class="col-md-2 control-label">Password</label>
						<div class="col-md-10">
							<input class="form-control" id="inputPassword" type="password"
								name="password" value="<c:out value="${user.password}"/>">
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
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
			</form>
		</div>
	</div>

	</div>
	<!--  End of container -->

</body>
</html>