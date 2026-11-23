<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Lỗi ${errorStatus}" scope="request"/>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<ui:header title="${pageTitle}"/>
<ui:navbar/>

<main class="main-container">
  <div class="breadcrumb">
    <i class="bi bi-house-door"></i>
    <span>/</span>
    <span>Lỗi ${errorStatus}</span>
  </div>

  <div class="empty-state panel" style="max-width:620px;margin:20px auto;">
    <i class="bi bi-exclamation-triangle" style="color:#dc7777;"></i>
    <h3>Lỗi ${errorStatus}</h3>
    <c:if test="${not empty errorPath}">
      <p class="muted"><i class="bi bi-link-45deg"></i> <c:out value="${errorPath}"/></p>
    </c:if>
    <p style="max-width:480px;line-height:1.7;"><c:out value="${errorMessage}"/></p>
    <div style="display:flex;gap:12px;margin-top:8px;">
      <a href="${pageContext.request.contextPath}/books" class="button primary">
        <i class="bi bi-house-door"></i>
        Về trang chủ
      </a>
      <button type="button" onclick="history.back()" class="button secondary">
        <i class="bi bi-arrow-left"></i>
        Quay lại
      </button>
    </div>
  </div>
</main>

<ui:footer/>
