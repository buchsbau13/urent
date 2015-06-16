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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search</title>
</head>
<body>
<h1>It worked so far :)</h1>
<h2>${searchString}</h2>
<h3>I dont know what i'm doing wrong</h3>
<br>
<h3>Count: ${count} </h3>
<h3>${rentables}</h3>
<br>

<h1>Rentables</h1>
		<table cellpadding="5" cellspacing="5" border="1">
			<thead>
				<tr>
					<th>Title</th>
					<th>Description</th>
					<th>Price</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${rentables}" var="rentable">
					<tr>
						<td class="col-md-1">${rentable.title}</td>
						<td class="col-md-1">${rentable.description}</td>
						<td class="col-md-1">${rentable.price}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
</body>
</html>