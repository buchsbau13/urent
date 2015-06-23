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
<title>Delete Users</title>
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



		<br> <br>
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
		<span class="icon fa-trash-o"></span>
		<h2>Delete Users</h2>
		</header>


		<!-- One --> <section class="wrapper style4 special container">

		<h2>Users</h2>

		<table data-toggle="table" data-classes="table table-hover "
			data-striped="false" data-sort-name="stargazers_count"
			data-sort-order="desc" data-search="true">




			<thead>
				<tr>
					<th data-field="image" data-sortable="true">Image</th>
					<th data-field="username" data-sortable="true">Username</th>
					<th data-field="firstname" data-sortable="true">Firstname</th>
					<th data-field="lastname" data-sortable="true"">Lastname</th>
					<th data-field="email" data-sortable="true">E-Mail</th>
					<th data-field="telephone" data-sortable="true">Telephone</th>
					<th class="col-md-2">Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${users}" var="user">
					<tr>
						<td><img src="getImage/<c:out value="${user.username}"/>.do"
							height="125px" width="125px" /></td>
						<td>${user.username}</td>
						<td>${user.firstname}</td>

						<td>${user.lastname}</td>
						<td>${user.email}</td>
						<td>${user.telephone}</td>


						<td><sec:authorize access="hasRole('ROLE_ADMIN')">
								<a href="deleteUser?username=${user.username}">
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