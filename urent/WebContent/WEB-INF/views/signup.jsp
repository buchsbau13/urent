<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<jsp:include page="includes/bootstrapMeta.jsp" />
<title>Sign up</title>
<jsp:include page="includes/bootstrapCss.jsp" />
<body>

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

	<div class="row">
		<div class="col-md-8 col-md-offset-2">
			<form:form class="form-horizontal" method="post"
				action="${formAction}">
				<fieldset>
					<legend>${legend}</legend>

					<! ---------------  username ---------------- -->
					<div class="form-group">
						<label for="inputUsername" class="col-md-2 control-label">Username</label>
						<div class="col-md-10">
							<input class="form-control" id="inputUsername" type="text"
								name="username" value="<c:out value="${user.username}"/>">
						</div>
					</div>

					<! ----------------  password  ---------------- -->
					<div class="form-group">
						<label for="inputPassword" class="col-md-2 control-label">Password</label>
						<div class="col-md-10">
							<input class="form-control" id="inputPassword" type="text"
								name="password" value="<c:out value="${user.password}"/>">
						</div>
					</div>

					<! ----------------  password  ---------------- -->
					<div class="form-group">
						<label for="inputPassword" class="col-md-2 control-label">Password
							again</label>
						<div class="col-md-10">
							<input class="form-control" id="inputPassword" type="text"
								name="password_again"
								value="<c:out value="${user.password_again}"/>">
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
			</form:form>
		</div>
	</div>


	<!--  End of container -->

</body>
</html>