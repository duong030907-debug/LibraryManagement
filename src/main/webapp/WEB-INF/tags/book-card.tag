<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="book" required="true" type="com.tdc.nhom6.doanjava1.model.Book" %>
<%@ attribute name="account" required="false" type="com.tdc.nhom6.doanjava1.model.Account" %>
<%@ attribute name="borrowed" required="false" type="java.lang.Boolean" %>
<article class="book-card">
 <c:choose>
  <c:when test="${book.hasCover}"><img class="book-cover-img" src="${pageContext.request.contextPath}/books/${book.id}/cover" alt="<c:out value='${book.title}'/>"/></c:when>
  <c:otherwise><div class="book-cover forest"><div class="cover-art"></div><div class="cover-top"><c:out value="${book.author}"/></div><div class="cover-title"><c:out value="${book.title}"/></div><div class="cover-subtitle"><c:out value="${book.category}"/></div><div class="cover-publisher"><c:out value="${book.publisher}"/></div></div></c:otherwise>
 </c:choose>
 <div class="book-info">
  <span class="genre-tag"><c:out value="${book.category}"/></span>
  <h2><c:out value="${book.title}"/></h2>
  <p class="author"><i class="bi bi-person"></i> <c:out value="${book.author}"/></p>
  <p class="book-description"><c:out value="${book.description}"/></p>
  <div class="book-footer">
   <span class="stock ${book.availableCopies le 0 ? 'out-of-stock' : ''}"><span class="status-dot"></span><c:choose><c:when test="${book.availableCopies gt 0}">Còn ${book.availableCopies}/${book.totalCopies} bản</c:when><c:otherwise>Hết bản</c:otherwise></c:choose></span>
   <c:choose>
    <c:when test="${borrowed}"><button class="borrow-button" disabled>Đang mượn</button></c:when>
    <c:when test="${book.availableCopies le 0}"><button class="borrow-button" disabled>Hết bản</button></c:when>
    <c:when test="${not empty account}"><form action="${pageContext.request.contextPath}/borrow/request" method="post"><input type="hidden" name="bookId" value="${book.id}"/><button class="borrow-button" type="submit">Mượn sách</button></form></c:when>
    <c:otherwise><a class="borrow-button" href="${pageContext.request.contextPath}/login">Mượn sách</a></c:otherwise>
   </c:choose>
  </div>
  <c:if test="${not empty account and account.canManage()}"><div class="book-admin-actions"><a class="text-button" href="${pageContext.request.contextPath}/books/edit/${book.id}">Sửa</a></div></c:if>
 </div>
</article>