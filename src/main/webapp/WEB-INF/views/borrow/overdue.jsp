<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Danh Sách Mượn Quá Hạn" scope="request"/>
<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>${pageTitle} — Thư Viện Sách</title><link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800&display=swap"><link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"><link rel="stylesheet" href="${pageContext.request.contextPath}/static/app.css"></head><body><div class="app">
<header class="header"><div class="nav-container"><a class="brand" href="${pageContext.request.contextPath}/books"><span class="brand-icon"><i class="bi bi-book-half"></i></span><span>Thư Viện<span class="brand-light"> Sách</span></span></a><button class="mobile-toggle" type="button" aria-label="Mở điều hướng" onclick="toggleMobileNav()"><i class="bi bi-list"></i></button><nav class="main-nav" id="mainNav"><a href="${pageContext.request.contextPath}/books" class="nav-link"><i class="bi bi-journals"></i>Sách</a><a href="${pageContext.request.contextPath}/documents" class="nav-link"><i class="bi bi-file-earmark-text"></i>Tài liệu số</a><c:if test="${sessionScope.currentUser != null}"><a href="${pageContext.request.contextPath}/borrow/active" class="nav-link"><i class="bi bi-bookmark-check"></i>Đang mượn</a><a href="${pageContext.request.contextPath}/borrow/history" class="nav-link"><i class="bi bi-clock-history"></i>Lịch sử</a><c:if test="${sessionScope.currentUser.canManage()}"><a href="${pageContext.request.contextPath}/admin" class="nav-link"><i class="bi bi-grid"></i>Trung tâm quản trị</a></c:if></c:if></nav><div class="account dropdown"><c:choose><c:when test="${sessionScope.currentUser != null}"><button type="button" class="account-button" onclick="toggleDropdown('accountDropdown', event)"><span class="avatar">${sessionScope.currentUser.fullName}</span><span class="account-info"><strong>${sessionScope.currentUser.fullName}</strong><small>${sessionScope.currentUser.role}</small></span><i class="bi bi-chevron-down"></i></button><div class="dropdown-menu right" id="accountDropdown"><a href="${pageContext.request.contextPath}/profile"><i class="bi bi-person"></i>Tài khoản</a><a href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right"></i>Đăng xuất</a></div></c:when><c:otherwise><a href="${pageContext.request.contextPath}/login" class="button light">Đăng nhập</a><a href="${pageContext.request.contextPath}/register" class="button primary">Đăng ký</a></c:otherwise></c:choose></div></div></header>

<main class="main-container">
  <div class="breadcrumb">
    <i class="bi bi-house-door"></i>
    <span>/</span>
    <span>Mượn quá hạn</span>
  </div>

  <div class="page-heading">
    <div>
      <div class="eyebrow">QUẢN LÝ MƯỢN TRẢ</div>
      <h1>Danh sách mượn quá hạn</h1>
      <p>Theo dõi những cuốn sách đã quá hạn cần được hoàn trả.</p>
    </div>
    <a href="${pageContext.request.contextPath}/admin/stats" class="button secondary">
      <i class="bi bi-arrow-left"></i>
      Quay lại thống kê
    </a>
  </div>

  <c:if test="${empty records}">
    <div class="empty-state panel">
      <i class="bi bi-check-circle"></i>
      <h3>Không có sách nào đang quá hạn!</h3>
      <p>Tất cả các lượt mượn đều đang trong thời hạn tiêu chuẩn.</p>
    </div>
  </c:if>

  <c:if test="${not empty records}">
    <div class="table-panel">
      <table>
        <thead>
          <tr>
            <th>#</th>
            <th>Tên sách</th>
            <th>Người mượn</th>
            <th>Ngày mượn</th>
            <th>Hạn trả</th>
            <th>Trạng thái</th>
            <th>Tiền phạt dự kiến</th>
            <th class="align-right">Thao tác</th>
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
              <td>
                <strong><c:out value="${r.account.fullName}"/></strong>
                <div class="muted" style="margin-top:3px;"><c:out value="${r.account.username}"/></div>
              </td>
              <td>${r.borrowDate}</td>
              <td style="color:#dc7777;font-weight:600;">${r.dueDate}</td>
              <td><span class="pill red">Quá hạn</span></td>
              <td class="muted">2.000 ₫ / ngày trễ</td>
              <td class="align-right">
                <div style="display:inline-flex;gap:8px;align-items:center;">
                  <a href="${pageContext.request.contextPath}/borrow/detail/${r.id}" class="text-button">
                    <i class="bi bi-eye"></i> Chi tiết
                  </a>
                  <form action="${pageContext.request.contextPath}/borrow/return/${r.id}" method="post"
                        style="margin:0;display:inline;" onsubmit="return confirm('Xác nhận trả sách và tính phí phạt quá hạn?')">
                    <button type="submit" class="button primary" style="min-height:32px;padding:6px 12px;">
                      <i class="bi bi-arrow-return-left"></i> Trả + tính phạt
                    </button>
                  </form>
                </div>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </c:if>
</main>

<footer class="footer"><div><span><i class="bi bi-book-half"></i> Thư Viện Sách</span><p>Kết nối tri thức. Nuôi dưỡng tương lai.</p></div><p>Created by <strong>Ngô Đức Hải</strong><span class="footer-separator"> · </span>24211TT2856</p><span class="footer-year">© 2026 Thư Viện Sách</span></footer></div><script src="${pageContext.request.contextPath}/static/app.js"></script></body></html>
