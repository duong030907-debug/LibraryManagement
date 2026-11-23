<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<ui:header title="My loans" account="${account}"/>
<section class="page-heading"><div><p class="eyebrow">YOUR ACCOUNT</p><h1>My loans</h1><p class="muted">Books you have borrowed.</p></div></section>
<ui:alert message="${success}" type="success"/><ui:alert message="${error}" type="error"/>
<div class="table-wrap"><table><thead><tr><th>Book</th><th>Borrowed</th><th>Returned</th><th>Status</th><th></th></tr></thead><tbody>
<c:forEach var="record" items="${records}"><tr><td><c:out value="${record.bookTitle}"/></td><td><c:out value="${record.borrowedAt}"/></td><td><c:out value="${record.returnedAt}"/></td>
<td><c:choose><c:when test="${record.returned}"><span class="status available">Returned</span></c:when><c:otherwise><span class="status unavailable">Borrowed</span></c:otherwise></c:choose></td>
<td><c:if test="${not record.returned}"><form action="${pageContext.request.contextPath}/borrow/${record.id}/return" method="post"><button class="secondary" type="submit">Return</button></form></c:if></td></tr></c:forEach>
<c:if test="${empty records}"><tr><td colspan="5">You have not borrowed any books.</td></tr></c:if>
</tbody></table></div>
<ui:footer/>
