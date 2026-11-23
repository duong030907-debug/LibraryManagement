<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Tài Liệu Số" scope="request"/>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<ui:header title="${pageTitle}"/>
<ui:navbar/>

<main class="main-container">
  <div class="breadcrumb">
    <i class="bi bi-house-door"></i>
    <span>/</span>
    <span>Tài liệu số</span>
  </div>

  <div class="page-heading">
    <div>
      <div class="eyebrow">THƯ VIỆN TRỰC TUYẾN</div>
      <h1>Tài liệu số</h1>
      <p>Kho tài liệu học tập và nghiên cứu, luôn sẵn sàng để khám phá.</p>
    </div>
    <c:if test="${sessionScope.currentUser != null}">
      <a href="${pageContext.request.contextPath}/documents/upload" class="button primary">
        <i class="bi bi-cloud-arrow-up"></i>
        Upload tài liệu
      </a>
    </c:if>
  </div>

  <div class="filter-panel">
    <label class="search-field">
      <i class="bi bi-search"></i>
      <input type="text" id="docSearchInput" oninput="filterDocuments()"
             placeholder="Tìm kiếm tài liệu theo tiêu đề hoặc tác giả..." aria-label="Tìm tài liệu"/>
    </label>
    <div class="filter-divider"></div>
    <label class="select-field">
      <i class="bi bi-folder"></i>
      <select id="docTypeSelect" onchange="filterDocuments()" aria-label="Loại tài liệu">
        <option value="">Tất cả danh mục</option>
        <option value="TEXTBOOK">Giáo trình (TEXTBOOK)</option>
        <option value="THESIS">Luận văn / Báo cáo (THESIS)</option>
        <option value="OTHER">Tài liệu khác (OTHER)</option>
      </select>
    </label>
  </div>

  <div class="results-bar">
    <p>
      Tìm thấy <strong id="docCountLabel">${fn:length(documents)} tài liệu</strong>
    </p>
    <span class="muted">Tài nguyên số dành cho bạn</span>
  </div>

  <c:if test="${not empty documents}">
    <div class="documents-grid" id="documentsGrid">
      <c:forEach var="doc" items="${documents}">
        <c:set var="isPdf" value="${doc.contentType eq 'application/pdf' or fn:endsWith(fn:toLowerCase(doc.fileName), '.pdf')}"/>
        <article class="document-card"
                 data-title="<c:out value='${fn:toLowerCase(doc.title)}'/> <c:out value='${fn:toLowerCase(doc.author)}'/>"
                 data-type="<c:out value='${doc.documentType}'/>">
          <div class="document-top">
            <span class="file-icon ${isPdf ? 'pdf' : 'docx'}">
              <i class="bi ${isPdf ? 'bi-file-earmark-pdf' : 'bi-file-earmark-word'}"></i>
            </span>
            <c:if test="${sessionScope.currentUser != null and sessionScope.currentUser.canManage()}">
              <form action="${pageContext.request.contextPath}/documents/delete/${doc.id}" method="post"
                    style="margin:0;" onsubmit="return confirm('Xóa tài liệu này?')">
                <button type="submit" class="icon-button danger" title="Xóa tài liệu">
                  <i class="bi bi-trash3"></i>
                </button>
              </form>
            </c:if>
          </div>

          <span class="genre-tag">
            <c:choose>
              <c:when test="${doc.documentType eq 'TEXTBOOK'}">Giáo trình</c:when>
              <c:when test="${doc.documentType eq 'THESIS'}">Luận văn / Báo cáo</c:when>
              <c:otherwise>Tài liệu chung</c:otherwise>
            </c:choose>
          </span>

          <h2><c:out value="${doc.title}"/></h2>

          <p>
            <c:choose>
              <c:when test="${not empty doc.description}">
                <c:out value="${doc.description}"/>
              </c:when>
              <c:otherwise>
                Tài liệu chia sẻ trong hệ thống thư viện số.
              </c:otherwise>
            </c:choose>
          </p>

          <div class="file-meta">
            <c:if test="${not empty doc.author}">
              <span><i class="bi bi-person"></i> <c:out value="${doc.author}"/></span>
              <span>&middot;</span>
            </c:if>
            <span><c:out value="${doc.fileName}"/></span>
            <c:if test="${not empty doc.fileSize}">
              <span>&middot;</span>
              <span><fmt:formatNumber value="${doc.fileSize / 1024}" maxFractionDigits="1"/> KB</span>
            </c:if>
            <span>&middot;</span>
            <span><i class="bi bi-download"></i> ${doc.downloadCount} lượt tải</span>
          </div>

          <div class="document-actions">
            <a href="${pageContext.request.contextPath}/documents/download/${doc.id}" class="button soft">
              <i class="bi bi-download"></i>
              Tải xuống / Xem
            </a>
          </div>
        </article>
      </c:forEach>
    </div>
  </c:if>

  <c:if test="${empty documents}">
    <div class="empty-state panel">
      <i class="bi bi-file-earmark-text"></i>
      <h3>Chưa có tài liệu số nào</h3>
      <p>Hãy là người đầu tiên chia sẻ tài liệu hữu ích lên thư viện.</p>
      <c:if test="${sessionScope.currentUser != null}">
        <a href="${pageContext.request.contextPath}/documents/upload" class="button primary">
          <i class="bi bi-cloud-arrow-up"></i>
          Upload tài liệu
        </a>
      </c:if>
    </div>
  </c:if>
</main>

<script>
  function filterDocuments() {
    var q = (document.getElementById('docSearchInput').value || '').toLowerCase().trim();
    var t = document.getElementById('docTypeSelect').value || '';
    var cards = document.querySelectorAll('#documentsGrid .document-card');
    var visible = 0;
    cards.forEach(function(card) {
      var title = card.getAttribute('data-title') || '';
      var type = card.getAttribute('data-type') || '';
      var matchQ = !q || title.indexOf(q) !== -1;
      var matchT = !t || type === t;
      if (matchQ && matchT) {
        card.style.display = '';
        visible++;
      } else {
        card.style.display = 'none';
      }
    });
    var label = document.getElementById('docCountLabel');
    if (label) label.textContent = visible + ' tài liệu';
  }
</script>

<ui:footer/>
