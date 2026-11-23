<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="title" required="false" %>
<%@ attribute name="account" required="false" type="com.tdc.nhom6.doanjava1.model.Account" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title><c:out value="${title}" default="Library"/></title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/app.css">
</head>
<body>
<header class="site-header">
<a class="brand" href="${pageContext.request.contextPath}/books">BookShelf</a>
<nav>
<a href="${pageContext.request.contextPath}/books">Books</a>
<c:if test="${not empty account}">
<a href="${pageContext.request.contextPath}/borrow/history">My loans</a>
<c:if test="${account.canManage()}"><a href="${pageContext.request.contextPath}/books/new">Add book</a></c:if>
<span class="user-label"><c:out value="${account.fullName}"/></span>
<form class="inline-form" action="${pageContext.request.contextPath}/logout" method="post"><button class="link-button" type="submit">Sign out</button></form>
</c:if>
<c:if test="${empty account}"><a href="${pageContext.request.contextPath}/login">Sign in</a><a href="${pageContext.request.contextPath}/register">Register</a></c:if>
</nav>
</header>
<main class="container">
