<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="${empty book.id ? 'Thêm Sách Mới' : 'Cập Nhật Sách'}" scope="request"/>
<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>${pageTitle} — Thư Viện Sách</title><link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800&display=swap"><link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"><link rel="stylesheet" href="${pageContext.request.contextPath}/static/app.css"></head><body><div class="app">
<header class="header"><div class="nav-container"><a class="brand" href="${pageContext.request.contextPath}/books"><span class="brand-icon"><i class="bi bi-book-half"></i></span><span>Thư Viện<span class="brand-light"> Sách</span></span></a><button class="mobile-toggle" type="button" aria-label="Mở điều hướng" onclick="toggleMobileNav()"><i class="bi bi-list"></i></button><nav class="main-nav" id="mainNav"><a href="${pageContext.request.contextPath}/books" class="nav-link"><i class="bi bi-journals"></i>Sách</a><a href="${pageContext.request.contextPath}/documents" class="nav-link"><i class="bi bi-file-earmark-text"></i>Tài liệu số</a><c:if test="${sessionScope.currentUser != null}"><a href="${pageContext.request.contextPath}/borrow/active" class="nav-link"><i class="bi bi-bookmark-check"></i>Đang mượn</a><a href="${pageContext.request.contextPath}/borrow/history" class="nav-link"><i class="bi bi-clock-history"></i>Lịch sử</a><c:if test="${sessionScope.currentUser.canManage()}"><a href="${pageContext.request.contextPath}/admin" class="nav-link"><i class="bi bi-grid"></i>Trung tâm quản trị</a></c:if></c:if></nav><div class="account dropdown"><c:choose><c:when test="${sessionScope.currentUser != null}"><button type="button" class="account-button" onclick="toggleDropdown('accountDropdown', event)"><span class="avatar">${sessionScope.currentUser.fullName}</span><span class="account-info"><strong>${sessionScope.currentUser.fullName}</strong><small>${sessionScope.currentUser.role}</small></span><i class="bi bi-chevron-down"></i></button><div class="dropdown-menu right" id="accountDropdown"><a href="${pageContext.request.contextPath}/profile"><i class="bi bi-person"></i>Tài khoản</a><a href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right"></i>Đăng xuất</a></div></c:when><c:otherwise><a href="${pageContext.request.contextPath}/login" class="button light">Đăng nhập</a><a href="${pageContext.request.contextPath}/register" class="button primary">Đăng ký</a></c:otherwise></c:choose></div></div></header>

<main class="main-container">
  <div class="breadcrumb">
    <i class="bi bi-house-door"></i>
    <span>/</span>
    <a href="${pageContext.request.contextPath}/books">Sách</a>
    <span>/</span>
    <span>${empty book.id ? 'Thêm sách mới' : 'Cập nhật sách'}</span>
  </div>

  <div class="page-heading">
    <div>
      <div class="eyebrow">QUẢN LÝ KHO SÁCH</div>
      <h1>${empty book.id ? 'Thêm sách mới' : 'Cập nhật thông tin sách'}</h1>
      <p>Bổ sung và cập nhật những trang sách mới cho thư viện.</p>
    </div>
    <a href="${pageContext.request.contextPath}/books" class="button secondary">
      <i class="bi bi-arrow-left"></i>
      Quay lại kho sách
    </a>
  </div>

  <div style="display:grid;grid-template-columns:${not empty book.id ? '1.35fr 0.85fr' : 'minmax(0, 680px)'};gap:24px;align-items:start;">
    <section class="panel">
      <div class="modal-heading">
        <span class="eyebrow">THÔNG TIN SÁCH</span>
        <h2>${empty book.id ? 'Nhập thông tin sách mới' : book.title}</h2>
        <p>Điền đầy đủ các trường bắt buộc được đánh dấu (*).</p>
      </div>

      <c:set var="action"
             value="${empty book.id ? pageContext.request.contextPath.concat('/books/add') : pageContext.request.contextPath.concat('/books/edit/').concat(book.id)}"/>
      <form action="${action}" method="post" class="edit-form">
        <label>
          Tiêu đề <span>*</span>
          <input type="text" name="title" required value="<c:out value='${book.title}'/>" placeholder="Nhập tên sách"/>
        </label>

        <label>
          Tác giả <span>*</span>
          <input type="text" name="author" required value="<c:out value='${book.author}'/>" placeholder="Nhập tên tác giả"/>
        </label>

        <div class="form-row">
          <label>
            Thể loại / Danh mục
            <input type="text" name="category" value="<c:out value='${book.category}'/>" placeholder="Văn học, Kỹ năng sống, CNTT..."/>
          </label>
          <label>
            Số lượng bản <span>*</span>
            <input type="number" name="totalCopies" required min="1"
                   value="${empty book.totalCopies ? 1 : book.totalCopies}"/>
          </label>
        </div>

        <div class="form-row">
          <label>
            Nhà xuất bản
            <input type="text" name="publisher" value="<c:out value='${book.publisher}'/>" placeholder="NXB Trẻ, NXB Tri Thức..."/>
          </label>
          <label>
            Năm xuất bản
            <input type="number" name="publishYear" value="${book.publishYear}" placeholder="2026"/>
          </label>
        </div>

        <label>
          Mô tả
          <textarea name="description" rows="4" placeholder="Giới thiệu ngắn về cuốn sách..."><c:out value="${book.description}"/></textarea>
        </label>

        <div class="form-actions">
          <a href="${pageContext.request.contextPath}/books" class="button secondary">Hủy</a>
          <button type="submit" class="button primary">
            <i class="bi bi-check-lg"></i>
            Lưu sách
          </button>
        </div>
      </form>
    </section>

    <c:if test="${not empty book.id}">
      <section class="panel">
        <div class="modal-heading">
          <span class="eyebrow">HÌNH ẢNH MINH HỌA</span>
          <h2>Ảnh bìa sách</h2>
          <p>Tải lên ảnh bìa thực tế hoặc sử dụng bìa nghệ thuật mặc định của thư viện.</p>
        </div>

        <div style="margin-bottom:20px;border-radius:10px;overflow:hidden;border:1px solid var(--border);">
          <c:choose>
            <c:when test="${book.hasCover}">
              <img src="${pageContext.request.contextPath}/books/${book.id}/cover"
                   class="book-cover-img" style="height:260px;" alt="Ảnh bìa"/>
            </c:when>
            <c:otherwise>
              <div class="book-cover forest" style="height:240px;">
                <div class="cover-art"></div>
                <div class="cover-top"><c:out value="${book.author}"/></div>
                <div class="cover-title"><c:out value="${book.title}"/></div>
                <div class="cover-subtitle"><c:out value="${empty book.category ? 'THƯ VIỆN SÁCH' : book.category}"/></div>
                <div class="cover-publisher">TỦ SÁCH TRI THỨC</div>
              </div>
            </c:otherwise>
          </c:choose>
        </div>

        <form action="${pageContext.request.contextPath}/books/${book.id}/cover"
              method="post" enctype="multipart/form-data" class="edit-form">
          <label class="upload-field">
            <i class="bi bi-image"></i>
            <span>Chọn file ảnh bìa mới</span>
            <input type="file" name="file" accept="image/*" required/>
            <small>Định dạng JPG, PNG, WEBP</small>
          </label>
          <button type="submit" class="button primary" style="width:100%;">
            <i class="bi bi-cloud-arrow-up"></i>
            ${book.hasCover ? 'Đổi ảnh bìa' : 'Tải ảnh bìa lên'}
          </button>
        </form>
      </section>
    </c:if>
  </div>
</main>

<footer class="footer"><div><span><i class="bi bi-book-half"></i> Thư Viện Sách</span><p>Kết nối tri thức. Nuôi dưỡng tương lai.</p></div><p>Created by <strong>Ngô Đức Hải</strong><span class="footer-separator"> · </span>24211TT2856</p><span class="footer-year">© 2026 Thư Viện Sách</span></footer></div><script src="${pageContext.request.contextPath}/static/app.js"></script></body></html>
