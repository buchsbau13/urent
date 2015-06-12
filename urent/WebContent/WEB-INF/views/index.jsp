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
					<div class="space">
						<input type="text" class="form-control"
							placeholder="What are you lookig for?">
					</div>
					<button type="submit" class="button fit">Search</button>

				</div>
			</div>
			</fieldset>
		</section>


		<!-- Main -->

		<article id="main"> <header class="special container">
		<span class="icon fa-bar-chart-o"></span>
		<h2>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed
			diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam
			erat, sed diam voluptua. At vero eos et accusam et justo duo dolores
			et ea rebum.</h2>
		<p>Stet clita kasd gubergren, no sea takimata sanctus est Lorem
			ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur
			sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et
			dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam
			et justo duo dolores et ea rebum.</p>
		</header> <section class="wrapper style1 container special">
		<div class="row">
			<div class="4u 12u(narrower)">

				<section> <span class="icon featured fa-check"></span> <header>
				<h3>All the Things you need</h3>
				</header>
				<p>Sed tristique purus vitae volutpat ultrices. Aliquam eu elit
					eget arcu commodo suscipit dolor nec nibh. Proin a ullamcorper
					elit, et sagittis turpis. Integer ut fermentum.</p>
				</section>

			</div>
			<div class="4u 12u(narrower)">

				<section> <span class="icon featured fa-lock"></span> <header>
				<h3>Secure</h3>
				</header>
				<p>Sed tristique purus vitae volutpat ultrices. Aliquam eu elit
					eget arcu commodo suscipit dolor nec nibh. Proin a ullamcorper
					elit, et sagittis turpis. Integer ut fermentum.</p>
				</section>

			</div>
			<div class="4u 12u(narrower)">

				<section> <span class="icon featured fa-laptop"></span> <header>
				<h3>Very niice</h3>
				</header>
				<p>Sed tristique purus vitae volutpat ultrices. Aliquam eu elit
					eget arcu commodo suscipit dolor nec nibh. Proin a ullamcorper
					elit, et sagittis turpis. Integer ut fermentum.</p>
				</section>

			</div>
		</div>
		</section> <!-- Three --> <section class="wrapper style3 container special">

		<header class="major">
		<h2>Things to Rent</h2>
		</header>

		<div class="row">
			<div class="6u 12u(narrower)">

				<section> <a href="#" class="image featured"><img
					src="resources/pictures/pic01.jpg" alt="" /></a> <header>
				<h3>Tools</h3>
				</header>
				<p>Sed tristique purus vitae volutpat commodo suscipit amet sed
					nibh. Proin a ullamcorper sed blandit. Sed tristique purus vitae
					volutpat commodo suscipit ullamcorper sed blandit lorem ipsum
					dolore.</p>
				</section>

			</div>
			<div class="6u 12u(narrower)">

				<section> <a href="#" class="image featured"><img
					src="resources/pictures/pic02.jpg" alt="" /></a> <header>
				<h3>Sport</h3>
				</header>
				<p>Sed tristique purus vitae volutpat commodo suscipit amet sed
					nibh. Proin a ullamcorper sed blandit. Sed tristique purus vitae
					volutpat commodo suscipit ullamcorper sed blandit lorem ipsum
					dolore.</p>
				</section>

			</div>
		</div>
		<div class="row">
			<div class="6u 12u(narrower)">

				<section> <a href="#" class="image featured"><img
					src="resources/pictures/pic03.jpg" alt="" /></a> <header>
				<h3>Music</h3>
				</header>
				<p>Sed tristique purus vitae volutpat commodo suscipit amet sed
					nibh. Proin a ullamcorper sed blandit. Sed tristique purus vitae
					volutpat commodo suscipit ullamcorper sed blandit lorem ipsum
					dolore.</p>
				</section>

			</div>
			<div class="6u 12u(narrower)">

				<section> <a href="#" class="image featured"><img
					src="resources/pictures/pic04.jpg" alt="" /></a> <header>
				<h3>Garden</h3>
				</header>
				<p>Sed tristique purus vitae volutpat commodo suscipit amet sed
					nibh. Proin a ullamcorper sed blandit. Sed tristique purus vitae
					volutpat commodo suscipit ullamcorper sed blandit lorem ipsum
					dolore.</p>
				</section>

			</div>
		</div>

		<footer class="major">
		<ul class="buttons">
			<li><a href="#" class="button">See More</a></li>
		</ul>
		</footer> </section> </article>


		<!-- CTA -->
		<section id="cta"> <header>
		<h2>
			Ready to do <strong>explore uRent</strong>?
		</h2>
		<p>Proin a ullamcorper elit, et sagittis turpis integer ut
			fermentum.</p>
		</header> <footer>
		<ul class="buttons">
			<li><a href="#" class="button special">Browse</a></li>
		</ul>
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