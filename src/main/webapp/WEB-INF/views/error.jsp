<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Lỗi ${errorStatus}" scope="request"/>
<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>${pageTitle} — Thư Viện Sách</title><link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800&display=swap"><link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"><link rel="stylesheet" href="${pageContext.request.contextPath}/static/app.css"></head><body><div class="app">
<header class="header"><div class="nav-container"><a class="brand" href="${pageContext.request.contextPath}/books">Thư Viện Sách</a><nav class="main-nav"><a class="nav-link" href="${pageContext.request.contextPath}/books">Sách</a><a class="nav-link" href="${pageContext.request.contextPath}/documents">Tài liệu số</a></nav></div></header>

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

<footer class="footer"><span>Thư Viện Sách · © 2026</span></footer></div><script src="${pageContext.request.contextPath}/static/app.js"></script></body></html>
