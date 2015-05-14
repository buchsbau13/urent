<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="includes/bootstrapMeta.jsp" />
<title>Sign in</title>
<jsp:include page="includes/bootstrapCss.jsp" />
</head>
<body>
	<div class="container" role="main">
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<c:url value="/login" var="loginUrl" />
				<form action="${loginUrl}" method="post">
					<h2 class="form-signin-heading">Please sign in</h2>
					<label for="inputUsername" class="sr-only">Username</label> <input
						type="text" id="username" class="form-control" placeholder="User"
						required autofocus name="username"> <label
						for="inputPassword" class="sr-only">Password</label> <input
						type="password" id="password" class="form-control"
						placeholder="Password" required name="password">
					<button class="btn btn-lg btn-primary btn-block" type="submit">Sign
						in</button>
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
				</form>
			</div>
		</div>
	</div>
	<!--  End of container -->

	<jsp:include page="includes/bootstrapJs.jsp" />
</body>
</html>