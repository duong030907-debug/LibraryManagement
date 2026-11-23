<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="${empty book.id ? 'Thêm Sách Mới' : 'Cập Nhật Sách'}" scope="request"/>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<ui:header title="${pageTitle}"/>
<ui:navbar/>

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

<ui:footer/>
