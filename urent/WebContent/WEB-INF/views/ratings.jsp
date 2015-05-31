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
<title>Ratings</title>
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

	<!--  list all ratings ----------------------------------------------------------- -->
	<center>
		<h1>Ratings</h1>

		<div class="row">

			<div class="table-index">
				<table class="table table-hover">

					<thead>
						<tr>
							<th>Author</th>
							<th>Date</th>
							<th>Title</th>
							<th>Text</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${ratings}" var="rating">
							<tr>
								<td class="col-md-1">${rating.author.username}</td>
								<td class="col-md-1"><fmt:formatDate value="${rating.date}"
										pattern="dd.MM.yyyy" /></td>
								<td class="col-md-1">${rating.title}</td>
								<td class="col-md-1">${rating.text}</td>

							</tr>
						</c:forEach>
					</tbody>
				</table>

			</div>
		</div>




	</center>

</body>
</html>