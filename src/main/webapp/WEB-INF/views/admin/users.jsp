<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Quản Lý Người Dùng" scope="request"/>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>${pageTitle} — Thư Viện Sách</title>
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800&display=swap">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/app.css">
</head><body><div class="app">
<header class="header"><div class="nav-container"><a class="brand" href="${pageContext.request.contextPath}/books"><span class="brand-icon"><i class="bi bi-book-half"></i></span><span>Thư Viện<span class="brand-light"> Sách</span></span></a><button class="mobile-toggle" type="button" aria-label="Mở điều hướng" onclick="toggleMobileNav()"><i class="bi bi-list"></i></button><nav class="main-nav" id="mainNav"><a href="${pageContext.request.contextPath}/books" class="nav-link"><i class="bi bi-journals"></i>Sách</a><a href="${pageContext.request.contextPath}/documents" class="nav-link"><i class="bi bi-file-earmark-text"></i>Tài liệu số</a><c:if test="${sessionScope.currentUser != null}"><a href="${pageContext.request.contextPath}/borrow/active" class="nav-link"><i class="bi bi-bookmark-check"></i>Đang mượn</a><a href="${pageContext.request.contextPath}/borrow/history" class="nav-link"><i class="bi bi-clock-history"></i>Lịch sử</a><c:if test="${sessionScope.currentUser.canManage()}"><a href="${pageContext.request.contextPath}/admin" class="nav-link"><i class="bi bi-grid"></i>Trung tâm quản trị</a></c:if></c:if></nav><div class="account dropdown"><c:choose><c:when test="${sessionScope.currentUser != null}"><button type="button" class="account-button" onclick="toggleDropdown('accountDropdown', event)"><span class="avatar">${fn:substring(sessionScope.currentUser.fullName,0,2)}</span><span class="account-info"><strong>${sessionScope.currentUser.fullName}</strong><small>${sessionScope.currentUser.role}</small></span><i class="bi bi-chevron-down"></i></button><div class="dropdown-menu right" id="accountDropdown"><a href="${pageContext.request.contextPath}/profile"><i class="bi bi-person"></i>Tài khoản</a><a href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right"></i>Đăng xuất</a></div></c:when><c:otherwise><a href="${pageContext.request.contextPath}/login" class="button light">Đăng nhập</a><a href="${pageContext.request.contextPath}/register" class="button primary">Đăng ký</a></c:otherwise></c:choose></div></div></header>

<main class="main-container">
  <div class="breadcrumb">
    <i class="bi bi-house-door"></i>
    <span>/</span>
    <span>Người dùng</span>
  </div>

  <div class="page-heading">
    <div>
      <div class="eyebrow">QUẢN LÝ THƯ VIỆN</div>
      <h1>Quản lý người dùng</h1>
      <p>Quản lý thành viên và phân quyền truy cập thư viện (${fn:length(users)} tài khoản).</p>
    </div>
  </div>

  <div class="table-panel">
    <table>
      <thead>
        <tr>
          <th>Người dùng</th>
          <th>Username</th>
          <th>Email</th>
          <th>Vai trò</th>
          <th>Trạng thái</th>
          <th class="align-right">Hành động</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="u" items="${users}">
          <tr>
            <td>
              <div class="user-cell">
                <span class="avatar pale">
                  ${fn:substring(u.fullName, 0, 2)}
                </span>
                <strong><c:out value="${u.fullName}"/></strong>
                <c:if test="${sessionScope.currentUser.id eq u.id}">
                  <small class="muted">(bạn)</small>
                </c:if>
              </div>
            </td>
            <td><c:out value="${u.username}"/></td>
            <td><c:out value="${empty u.email ? '—' : u.email}"/></td>
            <td>
              <c:choose>
                <c:when test="${u.role eq 'ADMIN'}">
                  <span class="pill blue">ADMIN</span>
                </c:when>
                <c:when test="${u.role eq 'LIBRARIAN'}">
                  <span class="pill amber">LIBRARIAN</span>
                </c:when>
                <c:otherwise>
                  <span class="pill green">MEMBER</span>
                </c:otherwise>
              </c:choose>
            </td>
            <td>
              <c:choose>
                <c:when test="${u.active}">
                  <span class="pill green">Hoạt động</span>
                </c:when>
                <c:otherwise>
                  <span class="pill gray">Đã khóa</span>
                </c:otherwise>
              </c:choose>
            </td>
            <td class="align-right">
              <div style="display:inline-flex;align-items:center;gap:6px;flex-wrap:wrap;justify-content:flex-end;">
                <a href="${pageContext.request.contextPath}/admin/users/${u.id}/history" class="text-button">
                  <i class="bi bi-clock-history"></i> Lịch sử mượn
                </a>
                <c:if test="${sessionScope.currentUser.admin}">
                  <c:if test="${u.role eq 'STUDENT'}">
                    <form action="${pageContext.request.contextPath}/admin/users/${u.id}/promote" method="post" style="margin:0;display:inline;">
                      <button type="submit" class="icon-button" title="Thăng lên Thủ thư">
                        <i class="bi bi-arrow-up-circle"></i>
                      </button>
                    </form>
                  </c:if>
                  <c:if test="${u.role eq 'LIBRARIAN'}">
                    <form action="${pageContext.request.contextPath}/admin/users/${u.id}/demote" method="post" style="margin:0;display:inline;">
                      <button type="submit" class="icon-button" title="Hạ xuống Thành viên">
                        <i class="bi bi-arrow-down-circle"></i>
                      </button>
                    </form>
                  </c:if>
                  <c:if test="${u.role ne 'ADMIN' and u.active}">
                    <form action="${pageContext.request.contextPath}/admin/users/${u.id}/delete" method="post"
                          style="margin:0;display:inline;" onsubmit="return confirm('Vô hiệu hóa tài khoản này?')">
                      <button type="submit" class="icon-button danger" title="Vô hiệu hóa tài khoản">
                        <i class="bi bi-person-x"></i>
                      </button>
                    </form>
                  </c:if>
                </c:if>
              </div>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</main>

<footer class="footer"><div><span><i class="bi bi-book-half"></i> Thư Viện Sách</span><p>Kết nối tri thức. Nuôi dưỡng tương lai.</p></div><p>Created by <strong>Ngô Đức Hải</strong><span class="footer-separator"> · </span>24211TT2856</p><span class="footer-year">© 2026 Thư Viện Sách</span></footer></div><script src="${pageContext.request.contextPath}/static/app.js"></script></body></html>
