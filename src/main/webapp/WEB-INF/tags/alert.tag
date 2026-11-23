<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="message" required="false" %>
<%@ attribute name="type" required="false" %>
<c:if test="${not empty message}">
 <div class="toast ${type eq 'error' ? 'error-toast' : ''}" role="status">
  <i class="bi ${type eq 'error' ? 'bi-exclamation-circle-fill' : 'bi-check-circle-fill'}"></i>
  <span><c:out value="${message}"/></span>
 </div>
</c:if>