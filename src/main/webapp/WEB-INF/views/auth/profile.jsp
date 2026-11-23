<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Thông Tin Tài Khoản" scope="request"/>
<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>${pageTitle} — Thư Viện Sách</title><link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800&display=swap"><link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"><link rel="stylesheet" href="${pageContext.request.contextPath}/static/app.css"></head><body><div class="app">
<header class="header"><div class="nav-container"><a class="brand" href="${pageContext.request.contextPath}/books"><span class="brand-icon"><i class="bi bi-book-half"></i></span><span>Thư Viện<span class="brand-light"> Sách</span></span></a><button class="mobile-toggle" type="button" aria-label="Mở điều hướng" onclick="toggleMobileNav()"><i class="bi bi-list"></i></button><nav class="main-nav" id="mainNav"><a href="${pageContext.request.contextPath}/books" class="nav-link"><i class="bi bi-journals"></i>Sách</a><a href="${pageContext.request.contextPath}/documents" class="nav-link"><i class="bi bi-file-earmark-text"></i>Tài liệu số</a><c:if test="${sessionScope.currentUser != null}"><a href="${pageContext.request.contextPath}/borrow/active" class="nav-link"><i class="bi bi-bookmark-check"></i>Đang mượn</a><a href="${pageContext.request.contextPath}/borrow/history" class="nav-link"><i class="bi bi-clock-history"></i>Lịch sử</a><c:if test="${sessionScope.currentUser.canManage()}"><a href="${pageContext.request.contextPath}/admin" class="nav-link"><i class="bi bi-grid"></i>Trung tâm quản trị</a></c:if></c:if></nav><div class="account dropdown"><c:choose><c:when test="${sessionScope.currentUser != null}"><button type="button" class="account-button" onclick="toggleDropdown('accountDropdown', event)"><span class="avatar">${sessionScope.currentUser.fullName}</span><span class="account-info"><strong>${sessionScope.currentUser.fullName}</strong><small>${sessionScope.currentUser.role}</small></span><i class="bi bi-chevron-down"></i></button><div class="dropdown-menu right" id="accountDropdown"><a href="${pageContext.request.contextPath}/profile"><i class="bi bi-person"></i>Tài khoản</a><a href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right"></i>Đăng xuất</a></div></c:when><c:otherwise><a href="${pageContext.request.contextPath}/login" class="button light">Đăng nhập</a><a href="${pageContext.request.contextPath}/register" class="button primary">Đăng ký</a></c:otherwise></c:choose></div></div></header>

<main class="main-container">
  <div class="breadcrumb">
    <i class="bi bi-house-door"></i>
    <span>/</span>
    <span>Tài khoản</span>
  </div>

  <div class="page-heading">
    <div>
      <div class="eyebrow">TÀI KHOẢN CỦA BẠN</div>
      <h1>Thông tin tài khoản</h1>
      <p>Thông tin cá nhân và quyền truy cập của bạn.</p>
    </div>
  </div>

  <section class="profile-panel panel">
    <span class="avatar large">${fn:substring(account.fullName, 0, 2)}</span>
    <h2><c:out value="${account.fullName}"/></h2>
    <c:choose>
      <c:when test="${account.role eq 'ADMIN'}">
        <span class="pill blue">ADMIN</span>
      </c:when>
      <c:when test="${account.role eq 'LIBRARIAN'}">
        <span class="pill amber">LIBRARIAN</span>
      </c:when>
      <c:otherwise>
        <span class="pill green">MEMBER</span>
      </c:otherwise>
    </c:choose>

    <dl>
      <div>
        <dt>ID</dt>
        <dd>#${account.id < 10 ? '00' : (account.id < 100 ? '0' : '')}${account.id}</dd>
      </div>
      <div>
        <dt>Username</dt>
        <dd><c:out value="${account.username}"/></dd>
      </div>
      <div>
        <dt>Email</dt>
        <dd><c:out value="${empty account.email ? 'Chưa cập nhật' : account.email}"/></dd>
      </div>
      <div>
        <dt>Vai trò</dt>
        <dd>
          <c:choose>
            <c:when test="${account.role eq 'ADMIN'}">Quản trị viên</c:when>
            <c:when test="${account.role eq 'LIBRARIAN'}">Thủ thư</c:when>
            <c:otherwise>Thành viên</c:otherwise>
          </c:choose>
        </dd>
      </div>
      <div>
        <dt>Ngày tham gia</dt>
        <dd>${account.createdAt}</dd>
      </div>
    </dl>

    <div style="display:flex;justify-content:center;gap:12px;flex-wrap:wrap;">
      <a href="${pageContext.request.contextPath}/borrow/history" class="button soft">
        <i class="bi bi-clock-history"></i>
        Lịch sử mượn của tôi
      </a>
      <a href="${pageContext.request.contextPath}/logout" class="button secondary">
        <i class="bi bi-box-arrow-right"></i>
        Đăng xuất
      </a>
    </div>
  </section>
</main>

<footer class="footer"><div><span><i class="bi bi-book-half"></i> Thư Viện Sách</span><p>Kết nối tri thức. Nuôi dưỡng tương lai.</p></div><p>Created by <strong>Ngô Đức Hải</strong><span class="footer-separator"> · </span>24211TT2856</p><span class="footer-year">© 2026 Thư Viện Sách</span></footer></div><script src="${pageContext.request.contextPath}/static/app.js"></script></body></html>
