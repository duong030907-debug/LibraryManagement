<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<ui:header title="Sign in"/>
<section class="form-panel narrow"><p class="eyebrow">WELCOME BACK</p><h1>Sign in</h1>
<ui:alert message="${success}" type="success"/><ui:alert message="${error}" type="error"/>
<form method="post" action="${pageContext.request.contextPath}/login">
<label>Username<input name="username" required autocomplete="username" value="<c:out value='${username}'/>"></label>
<label>Password<input type="password" name="password" required autocomplete="current-password"></label>
<button type="submit" class="full-width">Sign in</button>
</form>
<p class="form-note">No account? <a href="${pageContext.request.contextPath}/register">Create one</a>.</p>
<p class="demo-hint">Demo admin: <code>admin</code> / <code>admin123</code></p></section>
<ui:footer/>
