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
<script src="resources/js/jquery.min.js"></script>
<script src="resources/js/jquery.dropotron.min.js"></script>
<script src="resources/js/jquery.scrolly.min.js"></script>
<script src="resources/js/jquery.scrollgress.min.js"></script>
<script src="resources/js/skel.min.js"></script>
<script src="resources/js/util.js"></script>
<script src="resources/js/main.js"></script>
<jsp:include page="includes/bootstrapMeta.jsp" />
<title>Sign up</title>
<jsp:include page="includes/bootstrapCss.jsp" />
<link rel="stylesheet" type="text/css"
	href=<c:url value='/resources/css/font-awesome.min.css'/> />
</head>
<body>
	<div id="page wrapper">

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
		<span class="icon fa-user"></span>
		<h2>Sign up</h2>
		</header> <!-- One --> 
		<section class="wrapper style4 special container 50%">
		<div class="content">

			<div class="row">
				<div class="col-md-8 col-md-offset-2">
				<center>
					<form class="form-horizontal" action="${formAction}" method="post" style="text-align:center">
						<fieldset>
							<legend>${legend}</legend>

							<! ----------------  username ---------------- -->
							<div class="form-group">
								<label for="inputUsername" class="col-md-1"></label>
								<div class="col-md-10">
									<input class="form-control" id="inputUsername" type="text"
										name="username" placeholder="Username" required autofocus
										name="username" value="<c:out value="${user.username}"/>">
								</div>
							</div>
							<! ----------------  email ---------------- -->
							<div class="form-group">
								<label for="inputEmail" class="col-md-1 control-label"></label>
								<div class="col-md-10">
									<input class="form-control" id="inputEmail" type="text"
										name="email" placeholder="Email" required autofocus
										name="Email" value="<c:out value="${user.email}"/>">
								</div>
							</div>
							<! ---------------  firstname ---------------- -->
							<div class="form-group">
								<label for="inputFirstname" class="col-md-1 control-label"></label>
								<div class="col-md-10">
									<input class="form-control" id="inputFirstname" type="text"
										name="firstname" placeholder="Firstname" required autofocus
										name="Firstname" value="<c:out value="${user.firstname}"/>">
								</div>
							</div>
							<! ---------------  lastname ---------------- -->
							<div class="form-group">
								<label for="inputLastname" class="col-md-1 control-label"></label>
								<div class="col-md-10">
									<input class="form-control" id="inputLastname" type="text"
										name="lastname" placeholder="Lastname" required autofocus
										name="Lastname" value="<c:out value="${user.lastname}"/>">
								</div>
							</div>
							<! --------------  telephone ---------------- -->
							<div class="form-group">
								<label for="inputTelephone" class="col-md-1 control-label"></label>
								<div class="col-md-10">
									<input class="form-control" id="inputTelephone" type="text"
										name="telephone" placeholder="Telephone" required autofocus
										name="Telephone" value="<c:out value="${user.telephone}"/>">
								</div>
							</div>
							<! ----------------  password  ---------------- -->
							<div class="form-group">
								<label for="inputPassword" class="col-md-1 control-label"></label>
								<div class="col-md-10">
									<input class="form-control" id="inputPassword" type="password"
										name="password" placeholder="Password" required autofocus
										name="Password" value="<c:out value="${user.password}"/>">
								</div>
							</div>

							<! ----------------  buttons ---------------- -->
							<div class="form-group">
								<div class="col-md-8 col-md-offset-2">
									<button type="submit" class="btn btn-primary">Submit</button>
									<a href="list">
										<button type="button" class="btn btn-default">Cancel</button>
									
									</a>
								</div>
							</div>
							</center>
						</fieldset>
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />
						</form>
						
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
				
		
		
				</div>
			</div>
</fieldset>
</section>
		</div>
		 <!--  End of container --> <!-- Footer --> <footer id="footer">


		<ul class="icons">
			<li><a href="#" class="icon circle fa-twitter"><span
					class="label">Twitter</span></a></li>
			<li><a href="#" class="icon circle fa-facebook"><span
					class="label">Facebook</span></a></li>
			<li><a href="#" class="icon circle fa-google-plus"><span
					class="label">Google+</span></a></li>
			<li><a href="#" class="icon circle fa-github"><span
					class="label">Github</span></a></li>
			<li><a href="#" class="icon circle fa-dribbble"><span
					class="label">Dribbble</span></a></li>
		</ul>

		<ul class="copyright">
			<li>&copy; uRent Development</li>
		</ul>

		</footer>
</body>
</html>