<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<ui:header title="Books" account="${account}"/>
<section class="page-heading"><div><p class="eyebrow">LIBRARY CATALOG</p><h1>Find your next book</h1><p class="muted">Browse the collection and borrow a copy.</p></div>
<c:if test="${not empty account and account.canManage()}"><a class="button" href="${pageContext.request.contextPath}/books/new">Add a book</a></c:if></section>
<ui:alert message="${success}" type="success"/><ui:alert message="${error}" type="error"/>
<form class="search-bar" action="${pageContext.request.contextPath}/books" method="get">
<input type="search" name="keyword" value="<c:out value='${keyword}'/>" placeholder="Search title, author, category">
<button type="submit">Search</button><a class="button secondary" href="${pageContext.request.contextPath}/books">Clear</a>
</form>
<p class="result-count"><c:out value="${books.size()}"/> books found</p>
<section class="book-grid">
<c:forEach var="book" items="${books}"><ui:book-card book="${book}" account="${account}"/></c:forEach>
<c:if test="${empty books}"><div class="empty-state">No books match your search.</div></c:if>
</section>
<ui:footer/>
