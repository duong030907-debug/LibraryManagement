<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="message" required="false" %>
<%@ attribute name="type" required="false" %>
<c:if test="${not empty message}"><div class="alert ${empty type ? 'info' : type}"><c:out value="${message}"/></div></c:if>
