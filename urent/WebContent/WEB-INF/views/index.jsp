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
<!-- Scripts -->
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
<meta charset="utf-8" />
<script type="text/javascript">
	var button = document.getElementById('buttonToggle');

	button.onclick = function() {
		var div = document.getElementById('newpost');
		if (div.style.display !== 'none') {
			div.style.display = 'none';
		} else {
			div.style.display = 'block';
		}
	};
</script>


<title>uRent</title>
</head>
<body>
<body class="index">

	<div id="page-wrapper">


		<!-- Header -->

		<header id="header" class="alt">
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

		<!-- Banner -->


		<section id="banner">
		<div class="inner">
			<header>
			<h2>uRent</h2>
			</header>
			<p>
				This is <strong>uRent</strong>, a <br /> place to share your Stuff
				with the World <br />
				<footer> </footer>
			<fieldset>
				<div class="form-group">
					<div class="col-md-8 col-md-offset-2">
						<form action="search" method="post">
							<div class="space">

								<form action="find" method="post">
									<input type="hidden" name="${_csrf.parameterName}"
										value="${_csrf.token}" /> <input type="text"
										name="searchString"><br> <br> <input
										type="submit" value="Search">
								</form>
							</div>
					</div>
			</fieldset>
		</section>


		<!-- Main -->

		<article id="main"> <header class="special container">
		<span class="icon fa-user"></span>
		<h2>uRent is a place for your stuff</h2>
		<p>Whether you need a bike for your weekend trip, a guitar for a jam
			session or tools to finish your work. Find everything you need. In
			one place. Share your belongings with the world and earn some money.</p>
		</header> <!-- Three --> <section class="wrapper style4 container special">

		<header class="major">
		<h2>Things to Rent</h2>
		</header>

		<div class="row">
			<div class="6u 12u(narrower)">

				<section> <a href="./categorySport" class="image featured"><img
					src="resources/pictures/pic01.jpg" alt="" /></a> </section>

			</div>
			<div class="6u 12u(narrower)">

				<section> <a href="./categoryMusic" class="image featured"><img
					src="resources/pictures/music.jpg" alt="" /></a> </section>

			</div>
		</div>
		<div class="row">
			<div class="6u 12u(narrower)">

				<section> <a href="./categoryTools" class="image featured"><img
					src="resources/pictures/tools.jpg" alt="" /></a> </section>

			</div>
			<div class="6u 12u(narrower)">

				<section> <a href="./categoryKitchen"
					class="image featured"><img
					src="resources/pictures/kitchen.jpg" alt="" /></a> </section>

			</div>
		</div>
		<div class="row">
			<div class="6u 12u">

				<section> <a href="./categoryGarden"
					class="image featured"><img src="resources/pictures/garden.jpg"
					alt="" /></a> </section>

			</div>
			<div class="6u 12u(narrower)">

				<section> <a href="./categoryEntertainment"
					class="image featured"><img
					src="resources/pictures/entertainment.jpg" alt="" /></a> </section>

			</div>
		</div>
		
		<div class="row">
	<div class="6u 12u(narrower)">
			<section> <a href="./categoryHobby"
				class="image featured"><img
				src="resources/pictures/hobby.jpg" alt="" /></a> </section>
</div>
</div>
		</section> </article>


		<!-- CTA -->
		<section id="cta"> <header>
		<h2>
			Ready to <strong>explore uRent</strong>?
		</h2>

		</header> <footer>

		</footer> </section>


		<!-- Footer -->
		<footer id="footer">

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

	</div>



</body>


</html>
