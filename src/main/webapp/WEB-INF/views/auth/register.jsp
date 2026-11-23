<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<ui:header title="Register"/>
<section class="form-panel narrow"><p class="eyebrow">JOIN THE LIBRARY</p><h1>Create account</h1><ui:alert message="${error}" type="error"/>
<form method="post" action="${pageContext.request.contextPath}/register">
<label>Full name<input name="fullName" required value="<c:out value='${fullName}'/>"></label>
<label>Username<input name="username" required minlength="3" value="<c:out value='${username}'/>"></label>
<label>Password<input type="password" name="password" required minlength="6"></label>
<button type="submit" class="full-width">Create account</button></form>
<p class="form-note">Already registered? <a href="${pageContext.request.contextPath}/login">Sign in</a>.</p></section>
<ui:footer/>
