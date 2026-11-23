<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Lịch Sử Mượn — ${targetUser.fullName}" scope="request"/>
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
    <a href="${pageContext.request.contextPath}/admin/users">Người dùng</a>
    <span>/</span>
    <span>Lịch sử người dùng</span>
  </div>

  <div class="page-heading">
    <div>
      <div class="eyebrow">HÀNH TRÌNH TRI THỨC</div>
      <h1>Lịch sử mượn — <c:out value="${targetUser.fullName}"/></h1>
      <p>Danh sách các lượt mượn sách của tài khoản <strong><c:out value="${targetUser.username}"/></strong> (${fn:length(records)} bản ghi).</p>
    </div>
    <a href="${pageContext.request.contextPath}/admin/users" class="button secondary">
      <i class="bi bi-arrow-left"></i>
      Quay lại
    </a>
  </div>

  <c:if test="${not empty records}">
    <div class="table-panel">
      <table>
        <thead>
          <tr>
            <th>#</th>
            <th>Tên sách</th>
            <th>Ngày mượn</th>
            <th>Hạn trả</th>
            <th>Ngày trả</th>
            <th>Trạng thái</th>
            <th>Tiền phạt</th>
            <th class="align-right">Chi tiết</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="r" items="${records}" varStatus="s">
            <tr>
              <td>${s.index + 1}</td>
              <td class="table-title">
                <c:out value="${r.book.title}"/>
                <div class="muted" style="margin-top:3px;"><c:out value="${r.book.author}"/></div>
              </td>
              <td>${r.borrowDate}</td>
              <td>${r.dueDate}</td>
              <td>${empty r.returnDate ? '—' : r.returnDate}</td>
              <td>
                <c:choose>
                  <c:when test="${r.status eq 'ACTIVE' and r.overdue}">
                    <span class="pill red">Quá hạn</span>
                  </c:when>
                  <c:when test="${r.status eq 'ACTIVE'}">
                    <span class="pill blue">Đang mượn</span>
                  </c:when>
                  <c:when test="${r.status eq 'RETURNED'}">
                    <span class="pill green">Đã trả</span>
                  </c:when>
                  <c:when test="${r.status eq 'RETURNED_LATE'}">
                    <span class="pill amber">Trả trễ</span>
                  </c:when>
                </c:choose>
              </td>
              <td>
                <c:choose>
                  <c:when test="${r.fineAmount > 0}">
                    <span class="pill ${r.finePaid ? 'green' : 'red'}">
                      <fmt:formatNumber value="${r.fineAmount}" type="number" maxFractionDigits="0"/> ₫
                    </span>
                  </c:when>
                  <c:otherwise>—</c:otherwise>
                </c:choose>
              </td>
              <td class="align-right">
                <a href="${pageContext.request.contextPath}/borrow/detail/${r.id}" class="text-button">
                  <i class="bi bi-eye"></i> Xem
                </a>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </c:if>

  <c:if test="${empty records}">
    <div class="empty-state panel">
      <i class="bi bi-clock-history"></i>
      <h3>Người dùng này chưa có lịch sử mượn</h3>
      <p>Các lượt mượn sách của thành viên sẽ hiển thị tại đây.</p>
    </div>
  </c:if>
</main>

<footer class="footer"><div><span><i class="bi bi-book-half"></i> Thư Viện Sách</span><p>Kết nối tri thức. Nuôi dưỡng tương lai.</p></div><p>Created by <strong>Ngô Đức Hải</strong><span class="footer-separator"> · </span>24211TT2856</p><span class="footer-year">© 2026 Thư Viện Sách</span></footer></div><script src="${pageContext.request.contextPath}/static/app.js"></script></body></html>
