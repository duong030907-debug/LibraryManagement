<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Chi Tiết Phiếu Mượn" scope="request"/>
<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>${pageTitle} — Thư Viện Sách</title><link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800&display=swap"><link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"><link rel="stylesheet" href="${pageContext.request.contextPath}/static/app.css"></head><body><div class="app">
<header class="header"><div class="nav-container"><a class="brand" href="${pageContext.request.contextPath}/books"><span class="brand-icon"><i class="bi bi-book-half"></i></span><span>Thư Viện<span class="brand-light"> Sách</span></span></a><button class="mobile-toggle" type="button" aria-label="Mở điều hướng" onclick="toggleMobileNav()"><i class="bi bi-list"></i></button><nav class="main-nav" id="mainNav"><a href="${pageContext.request.contextPath}/books" class="nav-link"><i class="bi bi-journals"></i>Sách</a><a href="${pageContext.request.contextPath}/documents" class="nav-link"><i class="bi bi-file-earmark-text"></i>Tài liệu số</a><c:if test="${sessionScope.currentUser != null}"><a href="${pageContext.request.contextPath}/borrow/active" class="nav-link"><i class="bi bi-bookmark-check"></i>Đang mượn</a><a href="${pageContext.request.contextPath}/borrow/history" class="nav-link"><i class="bi bi-clock-history"></i>Lịch sử</a><c:if test="${sessionScope.currentUser.canManage()}"><a href="${pageContext.request.contextPath}/admin" class="nav-link"><i class="bi bi-grid"></i>Trung tâm quản trị</a></c:if></c:if></nav><div class="account dropdown"><c:choose><c:when test="${sessionScope.currentUser != null}"><button type="button" class="account-button" onclick="toggleDropdown('accountDropdown', event)"><span class="avatar">${sessionScope.currentUser.fullName}</span><span class="account-info"><strong>${sessionScope.currentUser.fullName}</strong><small>${sessionScope.currentUser.role}</small></span><i class="bi bi-chevron-down"></i></button><div class="dropdown-menu right" id="accountDropdown"><a href="${pageContext.request.contextPath}/profile"><i class="bi bi-person"></i>Tài khoản</a><a href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right"></i>Đăng xuất</a></div></c:when><c:otherwise><a href="${pageContext.request.contextPath}/login" class="button light">Đăng nhập</a><a href="${pageContext.request.contextPath}/register" class="button primary">Đăng ký</a></c:otherwise></c:choose></div></div></header>

<main class="main-container">
  <div class="breadcrumb">
    <i class="bi bi-house-door"></i>
    <span>/</span>
    <a href="${pageContext.request.contextPath}/borrow/history">Lịch sử</a>
    <span>/</span>
    <span>Phiếu mượn #${record.id}</span>
  </div>

  <div class="page-heading">
    <div>
      <div class="eyebrow">THÔNG TIN MƯỢN TRẢ</div>
      <h1>Chi tiết phiếu mượn #${record.id}</h1>
      <p>Thông tin chi tiết về lượt mượn sách và trạng thái hoàn trả.</p>
    </div>
    <a href="${pageContext.request.contextPath}/borrow/history" class="button secondary">
      <i class="bi bi-arrow-left"></i>
      Quay lại lịch sử
    </a>
  </div>

  <section class="profile-panel panel">
    <h2><c:out value="${record.book.title}"/></h2>
    <p class="muted" style="margin-bottom:14px;"><c:out value="${record.book.author}"/></p>

    <c:choose>
      <c:when test="${record.status eq 'ACTIVE' and record.overdue}">
        <span class="pill red">QUÁ HẠN</span>
      </c:when>
      <c:when test="${record.status eq 'ACTIVE'}">
        <span class="pill blue">ĐANG MƯỢN</span>
      </c:when>
      <c:when test="${record.status eq 'RETURNED'}">
        <span class="pill green">ĐÃ TRẢ</span>
      </c:when>
      <c:when test="${record.status eq 'RETURNED_LATE'}">
        <span class="pill amber">TRẢ TRỄ</span>
      </c:when>
    </c:choose>

    <dl>
      <div>
        <dt>Mã phiếu mượn</dt>
        <dd>#${record.id}</dd>
      </div>
      <div>
        <dt>Người mượn</dt>
        <dd><c:out value="${record.account.fullName}"/> (<c:out value="${record.account.username}"/>)</dd>
      </div>
      <div>
        <dt>Ngày mượn</dt>
        <dd>${record.borrowDate}</dd>
      </div>
      <div>
        <dt>Hạn trả</dt>
        <dd style="${record.overdue ? 'color:#dc7777;font-weight:600;' : ''}">${record.dueDate}</dd>
      </div>
      <div>
        <dt>Ngày trả thực tế</dt>
        <dd>${empty record.returnDate ? '—' : record.returnDate}</dd>
      </div>
      <div>
        <dt>Tiền phạt</dt>
        <dd>
          <c:choose>
            <c:when test="${record.fineAmount > 0}">
              <span class="pill ${record.finePaid ? 'green' : 'red'}">
                <fmt:formatNumber value="${record.fineAmount}" type="number" maxFractionDigits="0"/> ₫
                &middot; ${record.finePaid ? 'Đã thanh toán' : 'Chưa thanh toán'}
              </span>
            </c:when>
            <c:otherwise>
              <span class="green-text">Không có phạt</span>
            </c:otherwise>
          </c:choose>
        </dd>
      </div>
      <c:if test="${not empty record.notes}">
        <div>
          <dt>Ghi chú</dt>
          <dd><c:out value="${record.notes}"/></dd>
        </div>
      </c:if>
    </dl>

    <div style="display:flex;justify-content:center;gap:12px;flex-wrap:wrap;">
      <a href="${pageContext.request.contextPath}/borrow/history" class="button secondary">
        <i class="bi bi-arrow-left"></i>
        Quay lại
      </a>
      <c:if test="${record.fineAmount > 0 and not record.finePaid}">
        <form action="${pageContext.request.contextPath}/borrow/pay-fine/${record.id}" method="post"
              style="margin:0;" onsubmit="return confirm('Xác nhận thanh toán tiền phạt?')">
          <button type="submit" class="button soft">
            <i class="bi bi-cash-coin"></i>
            Thanh toán phạt
          </button>
        </form>
      </c:if>
      <c:if test="${sessionScope.currentUser.canManage() and record.status eq 'ACTIVE'}">
        <form action="${pageContext.request.contextPath}/borrow/return/${record.id}" method="post"
              style="margin:0;" onsubmit="return confirm('Xác nhận trả sách?')">
          <button type="submit" class="button primary">
            <i class="bi bi-check-lg"></i>
            Xác nhận trả sách
          </button>
        </form>
      </c:if>
    </div>
  </section>
</main>

<footer class="footer"><div><span><i class="bi bi-book-half"></i> Thư Viện Sách</span><p>Kết nối tri thức. Nuôi dưỡng tương lai.</p></div><p>Created by <strong>Ngô Đức Hải</strong><span class="footer-separator"> · </span>24211TT2856</p><span class="footer-year">© 2026 Thư Viện Sách</span></footer></div><script src="${pageContext.request.contextPath}/static/app.js"></script></body></html>
