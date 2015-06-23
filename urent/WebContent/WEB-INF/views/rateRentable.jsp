<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
<title>Rate Rentable</title>
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
		<span class="icon fa-star"></span>
		<h2>Rate Rentable</h2>
		</header> <!-- One --> <section class="wrapper style4 special container 50%">



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


		<form:form class="form" method="post"
			action="${formAction}?${_csrf.parameterName}=${_csrf.token}"
			enctype="multipart/form-data" role="form">


			<legend>${legend}</legend>

			<! ----------------  id ---------------- -->
			<div class="form-group">
				<div class="col-md-10">
					<input type="hidden" class="form-control" id="inputID" type="text"
						name="id" value="<c:out value="${rentable.id}"/>">
				</div>
			</div>

			<! ----------------  user ---------------- -->
			<div class="form-group">

				<input type="hidden" class="form-control" id="inputUser" type="text"
					name="user" value="<c:out value="${rentable.user}"/>">

			</div>

			<! ----------------  title ---------------- -->


			<div class="form-group">

				<label for="inputTitle" class="control-label">Title</label> <input
					class="form-control" id="inputTitle" type="text" name="title">

			</div>


			<! ----------------  text  ---------------- -->
			<div class="form-group">
				<label for="inputText" class="control-label">Text</label>

				<textarea class="form-control" rows="5" cols="35"
					id="inputDescription" type="text" name="description"></textarea>

			</div>

			<! ----------------  buttons ---------------- -->
			<div class="form-group">

				<button type="submit" class="btn btn-default">Submit</button>
				<a href="list">
					<button type="button" class="btn btn-default">Cancel</button>
				</a>
			</div>
	</div>
	</fieldset>
	<input type="hidden" name="${_csrf.parameterName}">
	</form:form>
	</div>
	</div>

	</div>
	<!--  End of container -->

</body>
</html>