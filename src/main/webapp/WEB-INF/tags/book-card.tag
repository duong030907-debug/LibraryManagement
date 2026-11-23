<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="book" required="true" type="com.tdc.nhom6.doanjava1.model.Book" %>
<%@ attribute name="account" required="false" type="com.tdc.nhom6.doanjava1.model.Account" %>
<article class="book-card">
<div class="book-cover"><span>BOOK</span></div>
<div class="book-info">
<span class="category"><c:out value="${book.category}"/></span>
<h2><c:out value="${book.title}"/></h2>
<p class="muted">by <c:out value="${book.author}"/></p>
<p><c:out value="${book.description}"/></p>
<p class="availability">
<c:choose><c:when test="${book.available}"><span class="status available">Available</span></c:when><c:otherwise><span class="status unavailable">Currently borrowed</span></c:otherwise></c:choose>
<span><c:out value="${book.availableCopies}"/> / <c:out value="${book.totalCopies}"/> copies</span>
</p>
<div class="actions">
<c:if test="${not empty account and book.available}">
<form action="${pageContext.request.contextPath}/borrow/${book.id}" method="post"><button type="submit">Borrow</button></form>
</c:if>
<c:if test="${not empty account and account.canManage()}">
<a class="button secondary" href="${pageContext.request.contextPath}/books/${book.id}/edit">Edit</a>
<form action="${pageContext.request.contextPath}/books/${book.id}/delete" method="post" onsubmit="return confirm('Delete this book?')"><button class="danger" type="submit">Delete</button></form>
</c:if>
</div>
</div>
</article>
