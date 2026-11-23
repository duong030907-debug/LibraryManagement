<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Upload Tài Liệu Số" scope="request"/>
<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>${pageTitle} — Thư Viện Sách</title><link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800&display=swap"><link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"><link rel="stylesheet" href="${pageContext.request.contextPath}/static/app.css"></head><body><div class="app">
<header class="header"><div class="nav-container"><a class="brand" href="${pageContext.request.contextPath}/books"><span class="brand-icon"><i class="bi bi-book-half"></i></span><span>Thư Viện<span class="brand-light"> Sách</span></span></a><button class="mobile-toggle" type="button" aria-label="Mở điều hướng" onclick="toggleMobileNav()"><i class="bi bi-list"></i></button><nav class="main-nav" id="mainNav"><a href="${pageContext.request.contextPath}/books" class="nav-link"><i class="bi bi-journals"></i>Sách</a><a href="${pageContext.request.contextPath}/documents" class="nav-link"><i class="bi bi-file-earmark-text"></i>Tài liệu số</a><c:if test="${sessionScope.currentUser != null}"><a href="${pageContext.request.contextPath}/borrow/active" class="nav-link"><i class="bi bi-bookmark-check"></i>Đang mượn</a><a href="${pageContext.request.contextPath}/borrow/history" class="nav-link"><i class="bi bi-clock-history"></i>Lịch sử</a><c:if test="${sessionScope.currentUser.canManage()}"><a href="${pageContext.request.contextPath}/admin" class="nav-link"><i class="bi bi-grid"></i>Trung tâm quản trị</a></c:if></c:if></nav><div class="account dropdown"><c:choose><c:when test="${sessionScope.currentUser != null}"><button type="button" class="account-button" onclick="toggleDropdown('accountDropdown', event)"><span class="avatar">${sessionScope.currentUser.fullName}</span><span class="account-info"><strong>${sessionScope.currentUser.fullName}</strong><small>${sessionScope.currentUser.role}</small></span><i class="bi bi-chevron-down"></i></button><div class="dropdown-menu right" id="accountDropdown"><a href="${pageContext.request.contextPath}/profile"><i class="bi bi-person"></i>Tài khoản</a><a href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right"></i>Đăng xuất</a></div></c:when><c:otherwise><a href="${pageContext.request.contextPath}/login" class="button light">Đăng nhập</a><a href="${pageContext.request.contextPath}/register" class="button primary">Đăng ký</a></c:otherwise></c:choose></div></div></header>

<main class="main-container">
  <div class="breadcrumb">
    <i class="bi bi-house-door"></i>
    <span>/</span>
    <a href="${pageContext.request.contextPath}/documents">Tài liệu số</a>
    <span>/</span>
    <span>Upload tài liệu</span>
  </div>

  <div class="page-heading">
    <div>
      <div class="eyebrow">THƯ VIỆN TRỰC TUYẾN</div>
      <h1>Upload tài liệu số</h1>
      <p>Chia sẻ tài nguyên học tập và nghiên cứu với cộng đồng.</p>
    </div>
    <a href="${pageContext.request.contextPath}/documents" class="button secondary">
      <i class="bi bi-arrow-left"></i>
      Quay lại danh sách
    </a>
  </div>

  <section class="panel" style="max-width:620px;margin:0 auto;">
    <div class="modal-heading">
      <span class="eyebrow">THÔNG TIN TÀI LIỆU</span>
      <h2>Tải tệp tài liệu mới lên hệ thống</h2>
      <p>Hỗ trợ các định dạng văn bản phổ biến (PDF, DOC, DOCX) dung lượng tối đa 50MB.</p>
    </div>

    <form action="${pageContext.request.contextPath}/documents/upload"
          method="post" enctype="multipart/form-data" class="edit-form">
      <label class="upload-field">
        <i class="bi bi-cloud-arrow-up"></i>
        <span>Chọn file tài liệu <span>*</span></span>
        <input type="file" name="file" required accept=".pdf,.doc,.docx"/>
        <small>Chấp nhận: PDF, DOC, DOCX &middot; Tối đa 50MB</small>
      </label>

      <label>
        Tiêu đề tài liệu <span>*</span>
        <input type="text" name="title" required placeholder="Nhập tiêu đề tài liệu"/>
      </label>

      <div class="form-row">
        <label>
          Tác giả
          <input type="text" name="author" placeholder="Tên tác giả / người biên soạn"/>
        </label>
        <label>
          Danh mục / Loại tài liệu
          <select name="documentType">
            <option value="TEXTBOOK">Giáo trình</option>
            <option value="THESIS">Luận văn / Báo cáo</option>
            <option value="OTHER">Khác</option>
          </select>
        </label>
      </div>

      <label>
        Mô tả
        <textarea name="description" rows="3" placeholder="Mô tả ngắn về nội dung tài liệu..."></textarea>
      </label>

      <div class="form-actions">
        <a href="${pageContext.request.contextPath}/documents" class="button secondary">Hủy</a>
        <button type="submit" class="button primary">
          <i class="bi bi-cloud-arrow-up"></i>
          Lưu tài liệu
        </button>
      </div>
    </form>
  </section>
</main>

<footer class="footer"><div><span><i class="bi bi-book-half"></i> Thư Viện Sách</span><p>Kết nối tri thức. Nuôi dưỡng tương lai.</p></div><p>Created by <strong>Ngô Đức Hải</strong><span class="footer-separator"> · </span>24211TT2856</p><span class="footer-year">© 2026 Thư Viện Sách</span></footer></div><script src="${pageContext.request.contextPath}/static/app.js"></script></body></html>
