<%@ tag description="Shared navigation" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="currentPath" value="${pageContext.request.servletPath}"/>
<header class="header">
  <div class="nav-container">
    <a class="brand" href="${pageContext.request.contextPath}/books">
      <span class="brand-icon">
        <i class="bi bi-book-half"></i>
      </span>
      <span>
        Thư Viện<span class="brand-light"> Sách</span>
      </span>
    </a>

    <button class="mobile-toggle" type="button" aria-label="Mở điều hướng" onclick="toggleMobileNav()">
      <i class="bi bi-list"></i>
    </button>

    <nav class="main-nav" id="mainNav">
      <a href="${pageContext.request.contextPath}/books"
         class="nav-link ${fn:contains(currentPath, '/books') ? 'active' : ''}">
        <i class="bi bi-journals"></i>
        Sách
      </a>
      <a href="${pageContext.request.contextPath}/documents"
         class="nav-link ${fn:contains(currentPath, '/documents') ? 'active' : ''}">
        <i class="bi bi-file-earmark-text"></i>
        Tài liệu số
      </a>

      <c:if test="${sessionScope.currentUser != null}">
        <a href="${pageContext.request.contextPath}/borrow/active"
           class="nav-link ${fn:contains(currentPath, '/borrow/active') ? 'active' : ''}">
          <i class="bi bi-bookmark-check"></i>
          Đang mượn
        </a>
        <a href="${pageContext.request.contextPath}/borrow/history"
           class="nav-link ${fn:contains(currentPath, '/borrow/history') ? 'active' : ''}">
          <i class="bi bi-clock-history"></i>
          Lịch sử
        </a>

        <c:if test="${sessionScope.currentUser.canManage()}">
          <div class="dropdown">
            <button type="button"
                    class="nav-link ${fn:contains(currentPath, '/admin') or fn:contains(currentPath, '/borrow/overdue') ? 'active' : ''}"
                    onclick="toggleDropdown('adminDropdown', event)">
              <i class="bi bi-grid"></i>
              Quản lý
              <i class="bi bi-chevron-down chevron"></i>
            </button>
            <div class="dropdown-menu" id="adminDropdown">
              <a href="${pageContext.request.contextPath}/admin/stats">
                <i class="bi bi-bar-chart"></i>
                Thống kê &amp; Báo cáo
              </a>
              <a href="${pageContext.request.contextPath}/borrow/overdue">
                <i class="bi bi-exclamation-triangle"></i>
                Mượn quá hạn
              </a>
              <a href="${pageContext.request.contextPath}/admin/users">
                <i class="bi bi-people"></i>
                Người dùng
              </a>
            </div>
          </div>
        </c:if>
      </c:if>
    </nav>

    <div class="account dropdown">
      <c:choose>
        <c:when test="${sessionScope.currentUser != null}">
          <button type="button" class="account-button" onclick="toggleDropdown('accountDropdown', event)">
            <span class="avatar">${fn:substring(sessionScope.currentUser.fullName, 0, 2)}</span>
            <span class="account-info">
              <strong>${sessionScope.currentUser.fullName}</strong>
              <small>
                <c:choose>
                  <c:when test="${sessionScope.currentUser.role eq 'ADMIN'}">Quản trị viên</c:when>
                  <c:when test="${sessionScope.currentUser.role eq 'LIBRARIAN'}">Thủ thư</c:when>
                  <c:otherwise>Thành viên</c:otherwise>
                </c:choose>
              </small>
            </span>
            <i class="bi bi-chevron-down"></i>
          </button>
          <div class="dropdown-menu right" id="accountDropdown">
            <a href="${pageContext.request.contextPath}/profile">
              <i class="bi bi-person"></i>
              Tài khoản của tôi
            </a>
            <a href="${pageContext.request.contextPath}/logout">
              <i class="bi bi-box-arrow-right"></i>
              Đăng xuất
            </a>
          </div>
        </c:when>
        <c:otherwise>
          <a href="${pageContext.request.contextPath}/login" class="button light">
            Đăng nhập
          </a>
          <a href="${pageContext.request.contextPath}/register" class="button primary">
            Đăng ký
          </a>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</header>

<c:if test="${not empty success}">
  <div class="toast" id="flashToast" role="status">
    <i class="bi bi-check-circle-fill"></i>
    <span>${success}</span>
    <button type="button" aria-label="Đóng thông báo" onclick="this.parentElement.remove()">
      <i class="bi bi-x-lg"></i>
    </button>
  </div>
</c:if>
<c:if test="${not empty error}">
  <div class="toast error-toast" id="flashToast" role="status">
    <i class="bi bi-exclamation-circle-fill"></i>
    <span>${error}</span>
    <button type="button" aria-label="Đóng thông báo" onclick="this.parentElement.remove()">
      <i class="bi bi-x-lg"></i>
    </button>
  </div>
</c:if>
