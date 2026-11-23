<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<ui:header title="${formTitle}" account="${account}"/>
<section class="form-panel"><p class="eyebrow">CATALOG MANAGEMENT</p><h1><c:out value="${formTitle}"/></h1>
<ui:alert message="${error}" type="error"/>
<form method="post" action="${pageContext.request.contextPath}/books">
<input type="hidden" name="id" value="<c:out value='${book.id}'/>">
<label>Title<input name="title" required maxlength="160" value="<c:out value='${book.title}'/>"></label>
<label>Author<input name="author" required maxlength="120" value="<c:out value='${book.author}'/>"></label>
<label>Category<input name="category" value="<c:out value='${book.category}'/>"></label>
<label>Description<textarea name="description" rows="4"><c:out value="${book.description}"/></textarea></label>
<label>Total copies<input type="number" name="totalCopies" min="1" required value="${book.totalCopies == 0 ? 1 : book.totalCopies}"></label>
<div class="actions"><button type="submit">Save book</button><a class="button secondary" href="${pageContext.request.contextPath}/books">Cancel</a></div>
</form></section>
<ui:footer/>
