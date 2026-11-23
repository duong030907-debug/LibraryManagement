<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Upload Tài Liệu Số" scope="request"/>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<ui:header title="${pageTitle}"/>
<ui:navbar/>

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

<ui:footer/>
