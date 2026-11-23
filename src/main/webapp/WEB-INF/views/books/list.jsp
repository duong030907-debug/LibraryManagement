<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Khám Phá Kho Sách" scope="request"/>
<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>${pageTitle} — Thư Viện Sách</title><link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800&display=swap"><link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"><link rel="stylesheet" href="${pageContext.request.contextPath}/static/app.css"></head><body><div class="app">
<header class="header"><div class="nav-container"><a class="brand" href="${pageContext.request.contextPath}/books"><span class="brand-icon"><i class="bi bi-book-half"></i></span><span>Thư Viện<span class="brand-light"> Sách</span></span></a><button class="mobile-toggle" type="button" aria-label="Mở điều hướng" onclick="toggleMobileNav()"><i class="bi bi-list"></i></button><nav class="main-nav" id="mainNav"><a href="${pageContext.request.contextPath}/books" class="nav-link"><i class="bi bi-journals"></i>Sách</a><a href="${pageContext.request.contextPath}/documents" class="nav-link"><i class="bi bi-file-earmark-text"></i>Tài liệu số</a><c:if test="${sessionScope.currentUser != null}"><a href="${pageContext.request.contextPath}/borrow/active" class="nav-link"><i class="bi bi-bookmark-check"></i>Đang mượn</a><a href="${pageContext.request.contextPath}/borrow/history" class="nav-link"><i class="bi bi-clock-history"></i>Lịch sử</a><c:if test="${sessionScope.currentUser.canManage()}"><a href="${pageContext.request.contextPath}/admin" class="nav-link"><i class="bi bi-grid"></i>Trung tâm quản trị</a></c:if></c:if></nav><div class="account dropdown"><c:choose><c:when test="${sessionScope.currentUser != null}"><button type="button" class="account-button" onclick="toggleDropdown('accountDropdown', event)"><span class="avatar">${sessionScope.currentUser.fullName}</span><span class="account-info"><strong>${sessionScope.currentUser.fullName}</strong><small>${sessionScope.currentUser.role}</small></span><i class="bi bi-chevron-down"></i></button><div class="dropdown-menu right" id="accountDropdown"><a href="${pageContext.request.contextPath}/profile"><i class="bi bi-person"></i>Tài khoản</a><a href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right"></i>Đăng xuất</a></div></c:when><c:otherwise><a href="${pageContext.request.contextPath}/login" class="button light">Đăng nhập</a><a href="${pageContext.request.contextPath}/register" class="button primary">Đăng ký</a></c:otherwise></c:choose></div></div></header>

<c:set var="totalAvailableSum" value="${0}"/>
<c:set var="totalCopiesSum" value="${0}"/>
<c:forEach var="b" items="${books}">
  <c:set var="totalAvailableSum" value="${totalAvailableSum + b.availableCopies}"/>
  <c:set var="totalCopiesSum" value="${totalCopiesSum + b.totalCopies}"/>
</c:forEach>

<main class="main-container">
  <div class="breadcrumb">
    <i class="bi bi-house-door"></i>
    <span>/</span>
    <span>Sách</span>
  </div>

  <div class="page-heading">
    <div>
      <div class="eyebrow">MỖI TRANG SÁCH, MỘT THẾ GIỚI MỚI</div>
      <h1>Khám phá kho sách</h1>
      <p>Tìm cuốn sách tiếp theo, mở ra những chân trời tri thức mới.</p>
    </div>
    <c:if test="${sessionScope.currentUser != null and sessionScope.currentUser.canManage()}">
      <a href="${pageContext.request.contextPath}/books/add" class="button primary">
        <i class="bi bi-plus-lg"></i>
        Thêm sách
      </a>
    </c:if>
  </div>

  <div class="library-summary">
    <div class="summary-intro">
      <span class="summary-icon">
        <i class="bi bi-book"></i>
      </span>
      <div>
        <strong>Tri thức luôn ở quanh bạn</strong>
        <p>Một cuốn sách hay có thể thay đổi cả một hành trình.</p>
      </div>
    </div>
    <div class="summary-stat">
      <strong>${fn:length(books) < 10 ? '0' : ''}${fn:length(books)}</strong>
      <span>Đầu sách</span>
    </div>
    <div class="summary-stat">
      <strong>${totalCopiesSum < 10 ? '0' : ''}${totalCopiesSum}</strong>
      <span>Tổng số bản</span>
    </div>
    <div class="summary-stat">
      <strong>${totalAvailableSum < 10 ? '0' : ''}${totalAvailableSum}</strong>
      <span>Bản sẵn có</span>
    </div>
    <i class="bi bi-stars summary-stars"></i>
  </div>

  <!-- Bộ lọc & Tìm kiếm -->
  <div class="filter-panel">
    <form action="${pageContext.request.contextPath}/books" method="get" class="search-field">
      <i class="bi bi-search"></i>
      <input type="text" name="keyword" aria-label="Tìm sách"
             placeholder="Tìm theo tên sách hoặc tác giả..." value="<c:out value='${keyword}'/>"/>
      <c:if test="${not empty keyword}">
        <a href="${pageContext.request.contextPath}/books" aria-label="Xóa tìm kiếm" style="color:#8a96a8;display:inline-flex;">
          <i class="bi bi-x"></i>
        </a>
      </c:if>
    </form>

    <div class="filter-divider"></div>

    <form action="${pageContext.request.contextPath}/books" method="get" class="select-field">
      <i class="bi bi-funnel"></i>
      <input type="text" name="category" aria-label="Lọc theo danh mục"
             placeholder="Lọc theo thể loại (Enter)..." value="<c:out value='${selectedCat}'/>"/>
    </form>

    <div class="filter-divider"></div>

    <a href="${pageContext.request.contextPath}/books?availableOnly=${availableOnly ? 'false' : 'true'}"
       class="availability-toggle ${availableOnly ? 'selected' : ''}">
      <span class="toggle-track">
        <span></span>
      </span>
      Chỉ hiện sách còn bản
    </a>
  </div>

  <!-- Thanh kết quả & Chế độ hiển thị -->
  <div class="results-bar">
    <p>
      Tìm thấy <strong>${fn:length(books)} cuốn sách</strong>
      <c:if test="${not empty keyword or not empty selectedCat or availableOnly}">
        <a href="${pageContext.request.contextPath}/books" class="text-button">
          Xóa bộ lọc <i class="bi bi-x"></i>
        </a>
      </c:if>
    </p>
    <div class="view-control">
      <span>Hiển thị</span>
      <button type="button" id="gridViewBtn" aria-label="Dạng lưới" class="selected" onclick="setBookView('grid')">
        <i class="bi bi-grid"></i>
      </button>
      <button type="button" id="listViewBtn" aria-label="Dạng danh sách" onclick="setBookView('list')">
        <i class="bi bi-list-ul"></i>
      </button>
    </div>
  </div>

  <!-- Danh sách sách -->
  <c:if test="${not empty books}">
    <div class="books-grid" id="booksGrid">
      <c:forEach var="book" items="${books}" varStatus="st">
        <c:set var="themeMod" value="${book.id % 6}"/>
        <c:choose>
          <c:when test="${themeMod == 0}"><c:set var="coverStyle" value="carnegie"/></c:when>
          <c:when test="${themeMod == 1}"><c:set var="coverStyle" value="alchemist"/></c:when>
          <c:when test="${themeMod == 2}"><c:set var="coverStyle" value="thinking"/></c:when>
          <c:when test="${themeMod == 3}"><c:set var="coverStyle" value="youth"/></c:when>
          <c:when test="${themeMod == 4}"><c:set var="coverStyle" value="forest"/></c:when>
          <c:otherwise><c:set var="coverStyle" value="sapiens"/></c:otherwise>
        </c:choose>
        <c:set var="isBorrowed" value="${borrowedIds != null and borrowedIds.contains(book.id)}"/>

        <article class="book-card"
                 data-id="${book.id}"
                 data-title="<c:out value='${book.title}'/>"
                 data-author="<c:out value='${book.author}'/>"
                 data-category="<c:out value='${empty book.category ? \"Thư viện\" : book.category}'/>"
                 data-publisher="<c:out value='${empty book.publisher ? \"TỦ SÁCH TRI THỨC\" : book.publisher}'/>"
                 data-year="<c:out value='${book.publishYear}'/>"
                 data-description="<c:out value='${empty book.description ? \"Chưa có mô tả cho cuốn sách này.\" : book.description}'/>"
                 data-available="${book.availableCopies}"
                 data-total="${book.totalCopies}"
                 data-hascover="${book.hasCover}"
                 data-coverstyle="${coverStyle}"
                 data-borrowed="${isBorrowed}">

          <button type="button" class="cover-button" onclick="openBookDetail(this.closest('.book-card'))" aria-label="Xem <c:out value='${book.title}'/>">
            <c:choose>
              <c:when test="${book.hasCover}">
                <img src="${pageContext.request.contextPath}/books/${book.id}/cover"
                     class="book-cover-img" alt="<c:out value='${book.title}'/>"/>
              </c:when>
              <c:otherwise>
                <div class="book-cover ${coverStyle}">
                  <div class="cover-art"></div>
                  <div class="cover-top"><c:out value="${book.author}"/></div>
                  <div class="cover-title"><c:out value="${book.title}"/></div>
                  <div class="cover-subtitle"><c:out value="${empty book.category ? 'THƯ VIỆN SÁCH' : book.category}"/></div>
                  <div class="cover-publisher"><c:out value="${empty book.publisher ? 'TỦ SÁCH TRI THỨC' : book.publisher}"/></div>
                </div>
              </c:otherwise>
            </c:choose>
            <span class="cover-preview">
              <i class="bi bi-eye"></i> Xem chi tiết
            </span>
            <c:if test="${book.availableCopies <= 0}">
              <span class="cover-unavailable">Tạm hết bản</span>
            </c:if>
          </button>

          <div class="book-content">
            <div class="book-meta">
              <span class="genre-tag genre-${st.index % 4}">
                <c:out value="${empty book.category ? 'Sách chung' : book.category}"/>
              </span>
              <div style="display:flex;align-items:center;gap:2px;">
                <c:if test="${book.hasCover}">
                  <a href="${pageContext.request.contextPath}/books/${book.id}/cover?download=true"
                     class="icon-button" title="Tải ảnh bìa">
                    <i class="bi bi-image"></i>
                  </a>
                </c:if>
                <c:if test="${sessionScope.currentUser != null and sessionScope.currentUser.canManage()}">
                  <a href="${pageContext.request.contextPath}/books/edit/${book.id}"
                     class="icon-button" title="Chỉnh sửa sách">
                    <i class="bi bi-pencil"></i>
                  </a>
                  <form action="${pageContext.request.contextPath}/books/delete/${book.id}" method="post"
                        style="display:inline;" onsubmit="return confirm('Xác nhận xóa cuốn sách này?')">
                    <button type="submit" class="icon-button danger" title="Xóa sách">
                      <i class="bi bi-trash3"></i>
                    </button>
                  </form>
                </c:if>
              </div>
            </div>

            <button type="button" class="title-button" onclick="openBookDetail(this.closest('.book-card'))">
              <h2><c:out value="${book.title}"/></h2>
            </button>

            <p class="author">
              <i class="bi bi-person"></i>
              <c:out value="${book.author}"/>
              <c:if test="${not empty book.publishYear}">
                <span>&middot; ${book.publishYear}</span>
              </c:if>
            </p>

            <p class="book-description">
              <c:out value="${empty book.description ? 'Khám phá nội dung cuốn sách tại thư viện.' : book.description}"/>
            </p>

            <div class="book-footer">
              <span class="stock ${book.availableCopies <= 0 ? 'out-of-stock' : ''}">
                <span class="status-dot"></span>
                <c:choose>
                  <c:when test="${book.availableCopies > 0}">Còn ${book.availableCopies}/${book.totalCopies} bản</c:when>
                  <c:otherwise>Hết bản</c:otherwise>
                </c:choose>
              </span>

              <c:choose>
                <c:when test="${isBorrowed}">
                  <button type="button" class="borrow-button" disabled>
                    <i class="bi bi-bookmark-check"></i>
                    Đang mượn
                  </button>
                </c:when>
                <c:when test="${book.availableCopies <= 0}">
                  <button type="button" class="borrow-button" disabled>
                    <i class="bi bi-bookmark-plus"></i>
                    Hết bản
                  </button>
                </c:when>
                <c:when test="${sessionScope.currentUser != null}">
                  <form action="${pageContext.request.contextPath}/borrow/request" method="post" style="margin:0;">
                    <input type="hidden" name="bookId" value="${book.id}"/>
                    <button type="submit" class="borrow-button">
                      <i class="bi bi-bookmark-plus"></i>
                      Mượn sách
                    </button>
                  </form>
                </c:when>
                <c:otherwise>
                  <a href="${pageContext.request.contextPath}/login" class="borrow-button">
                    <i class="bi bi-bookmark-plus"></i>
                    Mượn sách
                  </a>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </article>
      </c:forEach>
    </div>

    <div class="catalog-end">
      <span></span>
      Bạn đã xem tất cả ${fn:length(books)} cuốn sách
      <span></span>
    </div>
  </c:if>

  <c:if test="${empty books}">
    <div class="empty-state panel">
      <i class="bi bi-search"></i>
      <h3>Không tìm thấy sách nào</h3>
      <p>Thử một từ khóa khác hoặc xóa bộ lọc.</p>
      <c:if test="${not empty keyword or not empty selectedCat or availableOnly}">
        <a href="${pageContext.request.contextPath}/books" class="button secondary">
          Xóa bộ lọc
        </a>
      </c:if>
    </div>
  </c:if>
</main>

<!-- Modal Xem Chi Tiết Sách -->
<div class="modal-backdrop" id="bookDetailModal" onclick="closeBookDetail()">
  <section class="modal detail-modal" role="dialog" aria-modal="true" aria-label="Thông tin chi tiết sách" onclick="event.stopPropagation()">
    <button type="button" class="modal-close icon-button" aria-label="Đóng" onclick="closeBookDetail()">
      <i class="bi bi-x-lg"></i>
    </button>
    <div id="modalCoverContainer"></div>
    <div class="detail-content">
      <span class="genre-tag" id="modalCategory"></span>
      <h1 id="modalTitle"></h1>
      <p class="author">
        <i class="bi bi-person"></i>
        <span id="modalAuthor"></span>
      </p>
      <p id="modalDescription"></p>
      <div class="notice">
        <i class="bi bi-info-circle"></i>
        <span>Thời gian mượn tiêu chuẩn: <strong>14 ngày</strong></span>
      </div>
      <span class="stock" id="modalStock"></span>
      <div id="modalActionContainer" style="margin-top:auto;display:flex;gap:10px;flex-wrap:wrap;"></div>
    </div>
  </section>
</div>

<script>
  var ctxPath = '${pageContext.request.contextPath}';
  var isLoggedIn = ${sessionScope.currentUser != null};
  var canManageBooks = ${sessionScope.currentUser != null and sessionScope.currentUser.canManage()};

  function setBookView(mode) {
    var grid = document.getElementById('booksGrid');
    var gridBtn = document.getElementById('gridViewBtn');
    var listBtn = document.getElementById('listViewBtn');
    if (!grid) return;
    if (mode === 'list') {
      grid.classList.add('list-view');
      listBtn.classList.add('selected');
      gridBtn.classList.remove('selected');
    } else {
      grid.classList.remove('list-view');
      gridBtn.classList.add('selected');
      listBtn.classList.remove('selected');
    }
  }

  function openBookDetail(card) {
    if (!card) return;
    var id = card.getAttribute('data-id');
    var title = card.getAttribute('data-title');
    var author = card.getAttribute('data-author');
    var category = card.getAttribute('data-category');
    var publisher = card.getAttribute('data-publisher');
    var year = card.getAttribute('data-year');
    var description = card.getAttribute('data-description');
    var available = parseInt(card.getAttribute('data-available') || '0', 10);
    var total = parseInt(card.getAttribute('data-total') || '0', 10);
    var hasCover = card.getAttribute('data-hascover') === 'true';
    var coverStyle = card.getAttribute('data-coverstyle') || 'forest';
    var borrowed = card.getAttribute('data-borrowed') === 'true';

    document.getElementById('modalCategory').textContent = category;
    document.getElementById('modalTitle').textContent = title;
    document.getElementById('modalAuthor').textContent = author + (year ? ' · ' + year : '') + (publisher ? ' · ' + publisher : '');
    document.getElementById('modalDescription').textContent = description;

    var stockEl = document.getElementById('modalStock');
    stockEl.className = 'stock' + (available <= 0 ? ' out-of-stock' : '');
    stockEl.innerHTML = '<span class="status-dot"></span>' + (available > 0 ? ('Còn ' + available + '/' + total + ' bản sẵn có') : 'Tạm hết bản');

    var coverContainer = document.getElementById('modalCoverContainer');
    coverContainer.innerHTML = '';
    if (hasCover) {
      var img = document.createElement('img');
      img.src = ctxPath + '/books/' + id + '/cover';
      img.className = 'book-cover-img';
      img.style.height = '100%';
      img.style.minHeight = '420px';
      img.alt = title;
      coverContainer.appendChild(img);
    } else {
      var cov = document.createElement('div');
      cov.className = 'book-cover ' + coverStyle;
      cov.style.height = '100%';
      cov.style.minHeight = '420px';
      var art = document.createElement('div');
      art.className = 'cover-art';
      var top = document.createElement('div');
      top.className = 'cover-top';
      top.textContent = author;
      var tit = document.createElement('div');
      tit.className = 'cover-title';
      tit.textContent = title;
      var sub = document.createElement('div');
      sub.className = 'cover-subtitle';
      sub.textContent = category;
      var pub = document.createElement('div');
      pub.className = 'cover-publisher';
      pub.textContent = publisher;
      cov.appendChild(art);
      cov.appendChild(top);
      cov.appendChild(tit);
      cov.appendChild(sub);
      cov.appendChild(pub);
      coverContainer.appendChild(cov);
    }

    var actionContainer = document.getElementById('modalActionContainer');
    actionContainer.innerHTML = '';
    if (borrowed) {
      actionContainer.innerHTML = '<button type="button" class="button primary" disabled style="flex:1;"><i class="bi bi-bookmark-check"></i> Bạn đang mượn cuốn sách này</button>';
    } else if (available <= 0) {
      actionContainer.innerHTML = '<button type="button" class="button primary" disabled style="flex:1;"><i class="bi bi-bookmark-plus"></i> Tạm hết bản</button>';
    } else if (isLoggedIn) {
      actionContainer.innerHTML = '<form action="' + ctxPath + '/borrow/request" method="post" style="flex:1;display:flex;margin:0;">' +
        '<input type="hidden" name="bookId" value="' + id + '"/>' +
        '<button type="submit" class="button primary" style="width:100%;"><i class="bi bi-bookmark-plus"></i> Mượn sách ngay</button>' +
        '</form>';
    } else {
      actionContainer.innerHTML = '<a href="' + ctxPath + '/login" class="button primary" style="flex:1;"><i class="bi bi-box-arrow-in-right"></i> Đăng nhập để mượn sách</a>';
    }

    if (canManageBooks) {
      var editLink = document.createElement('a');
      editLink.href = ctxPath + '/books/edit/' + id;
      editLink.className = 'button secondary';
      editLink.innerHTML = '<i class="bi bi-pencil"></i> Sửa';
      actionContainer.appendChild(editLink);
    }

    document.getElementById('bookDetailModal').classList.add('open');
  }

  function closeBookDetail() {
    var modal = document.getElementById('bookDetailModal');
    if (modal) modal.classList.remove('open');
  }

  document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') closeBookDetail();
  });
</script>

<footer class="footer"><div><span><i class="bi bi-book-half"></i> Thư Viện Sách</span><p>Kết nối tri thức. Nuôi dưỡng tương lai.</p></div><p>Created by <strong>Ngô Đức Hải</strong><span class="footer-separator"> · </span>24211TT2856</p><span class="footer-year">© 2026 Thư Viện Sách</span></footer></div><script src="${pageContext.request.contextPath}/static/app.js"></script></body></html>
