<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="includes/bootstrapMeta.jsp" />
<title>New Rentable</title>
<jsp:include page="includes/bootstrapCss.jsp" />
</head>
<body>

	<div class="row">
		<div class="col-md-8 col-md-offset-2">
			<form class="form-horizontal" method="post" action="${formAction}">
				<fieldset>
					<legend>${legend}</legend>

					<! ----------------  category ---------------- -->
					<div class="form-group">
						<label for="inputCategory" class="col-md-2 control-label">Category</label>
						<div class="col-md-10">

							<form:select path="categories">
								<form:option value="NONE" label="--- Select ---" />
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
								name="title" value="<c:out value="${rentable.title}"/>">
						</div>
					</div>
					<! ----------------  description  ---------------- -->
					<div class="form-group">
						<label for="inputDescription" class="col-md-2 control-label">Description</label>
						<div class="col-md-10">
							<input class="form-control" id="inputDescription" type="text"
								name="description"
								value="<c:out value="${rentable.description}"/>">
						</div>
					</div>

					<! ----------------  price  ---------------- -->
					<div class="form-group">
						<label for="inputPrice" class="col-md-2 control-label">Price</label>
						<div class="col-md-10">
							<input class="form-control" id="inputPrice" type="text"
								name="price" value="<c:out value="${rentable.price}"/>">
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