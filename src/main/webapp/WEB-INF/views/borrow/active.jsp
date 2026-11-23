<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Sách Đang Mượn" scope="request"/>
<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>${pageTitle} — Thư Viện Sách</title><link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800&display=swap"><link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"><link rel="stylesheet" href="${pageContext.request.contextPath}/static/app.css"></head><body><div class="app">
<header class="header"><div class="nav-container"><a class="brand" href="${pageContext.request.contextPath}/books"><span class="brand-icon"><i class="bi bi-book-half"></i></span><span>Thư Viện<span class="brand-light"> Sách</span></span></a><button class="mobile-toggle" type="button" aria-label="Mở điều hướng" onclick="toggleMobileNav()"><i class="bi bi-list"></i></button><nav class="main-nav" id="mainNav"><a href="${pageContext.request.contextPath}/books" class="nav-link"><i class="bi bi-journals"></i>Sách</a><a href="${pageContext.request.contextPath}/documents" class="nav-link"><i class="bi bi-file-earmark-text"></i>Tài liệu số</a><c:if test="${sessionScope.currentUser != null}"><a href="${pageContext.request.contextPath}/borrow/active" class="nav-link"><i class="bi bi-bookmark-check"></i>Đang mượn</a><a href="${pageContext.request.contextPath}/borrow/history" class="nav-link"><i class="bi bi-clock-history"></i>Lịch sử</a><c:if test="${sessionScope.currentUser.canManage()}"><a href="${pageContext.request.contextPath}/admin" class="nav-link"><i class="bi bi-grid"></i>Trung tâm quản trị</a></c:if></c:if></nav><div class="account dropdown"><c:choose><c:when test="${sessionScope.currentUser != null}"><button type="button" class="account-button" onclick="toggleDropdown('accountDropdown', event)"><span class="avatar">${sessionScope.currentUser.fullName}</span><span class="account-info"><strong>${sessionScope.currentUser.fullName}</strong><small>${sessionScope.currentUser.role}</small></span><i class="bi bi-chevron-down"></i></button><div class="dropdown-menu right" id="accountDropdown"><a href="${pageContext.request.contextPath}/profile"><i class="bi bi-person"></i>Tài khoản</a><a href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right"></i>Đăng xuất</a></div></c:when><c:otherwise><a href="${pageContext.request.contextPath}/login" class="button light">Đăng nhập</a><a href="${pageContext.request.contextPath}/register" class="button primary">Đăng ký</a></c:otherwise></c:choose></div></div></header>

<main class="main-container">
  <div class="breadcrumb">
    <i class="bi bi-house-door"></i>
    <span>/</span>
    <span>Đang mượn</span>
  </div>

  <div class="page-heading">
    <div>
      <div class="eyebrow">GÓC ĐỌC CỦA BẠN</div>
      <h1>Sách đang mượn</h1>
      <p>Tiếp tục hành trình đọc và đừng quên trả sách đúng hạn.</p>
    </div>
    <a href="${pageContext.request.contextPath}/borrow/history" class="button secondary">
      <i class="bi bi-clock-history"></i>
      Xem lịch sử
    </a>
  </div>

  <div class="notice">
    <i class="bi bi-info-circle"></i>
    <span>
      Đang có <strong>${fn:length(records)} cuốn sách</strong> trong danh sách đang mượn.
      Thời gian mượn tiêu chuẩn là 14 ngày.
    </span>
  </div>

  <c:if test="${not empty records}">
    <div class="loan-grid">
      <c:forEach var="r" items="${records}">
        <c:set var="themeMod" value="${r.book.id % 6}"/>
        <c:choose>
          <c:when test="${themeMod == 0}"><c:set var="coverStyle" value="carnegie"/></c:when>
          <c:when test="${themeMod == 1}"><c:set var="coverStyle" value="alchemist"/></c:when>
          <c:when test="${themeMod == 2}"><c:set var="coverStyle" value="thinking"/></c:when>
          <c:when test="${themeMod == 3}"><c:set var="coverStyle" value="youth"/></c:when>
          <c:when test="${themeMod == 4}"><c:set var="coverStyle" value="forest"/></c:when>
          <c:otherwise><c:set var="coverStyle" value="sapiens"/></c:otherwise>
        </c:choose>

        <article class="loan-card">
          <c:choose>
            <c:when test="${r.book.hasCover}">
              <img src="${pageContext.request.contextPath}/books/${r.book.id}/cover"
                   class="small-cover-img" alt="<c:out value='${r.book.title}'/>"/>
            </c:when>
            <c:otherwise>
              <div class="book-cover ${coverStyle} small-cover">
                <div class="cover-art"></div>
                <div class="cover-top"><c:out value="${r.book.author}"/></div>
                <div class="cover-title"><c:out value="${r.book.title}"/></div>
                <div class="cover-subtitle"><c:out value="${empty r.book.category ? 'THƯ VIỆN SÁCH' : r.book.category}"/></div>
                <div class="cover-publisher">TỦ SÁCH TRI THỨC</div>
              </div>
            </c:otherwise>
          </c:choose>

          <div class="loan-content">
            <c:choose>
              <c:when test="${r.overdue}">
                <span class="pill red" style="width:fit-content;">QUÁ HẠN</span>
              </c:when>
              <c:otherwise>
                <span class="genre-tag">ĐANG MƯỢN</span>
              </c:otherwise>
            </c:choose>

            <h2><c:out value="${r.book.title}"/></h2>
            <p class="author">
              <i class="bi bi-person"></i>
              <c:out value="${r.book.author}"/>
            </p>

            <c:if test="${sessionScope.currentUser.canManage()}">
              <p>
                <i class="bi bi-person-badge"></i>
                Người mượn: <strong><c:out value="${r.account.fullName}"/></strong> (<c:out value="${r.account.username}"/>)
              </p>
            </c:if>

            <p>
              <i class="bi bi-calendar3"></i>
              Mượn: ${r.borrowDate}
            </p>
            <p>
              <i class="bi bi-calendar-check"></i>
              Hạn trả:
              <strong style="${r.overdue ? 'color:#dc7777;' : ''}">
                ${r.dueDate}
              </strong>
            </p>

            <div class="loan-actions">
              <a href="${pageContext.request.contextPath}/borrow/detail/${r.id}" class="button secondary">
                <i class="bi bi-eye"></i>
                Chi tiết
              </a>
              <c:if test="${sessionScope.currentUser.canManage()}">
                <form action="${pageContext.request.contextPath}/borrow/return/${r.id}" method="post"
                      style="margin:0;" onsubmit="return confirm('Xác nhận trả sách này?')">
                  <button type="submit" class="button primary">
                    <i class="bi bi-arrow-return-left"></i>
                    Trả sách
                  </button>
                </form>
              </c:if>
            </div>
          </div>
        </article>
      </c:forEach>
    </div>
  </c:if>

  <c:if test="${empty records}">
    <div class="empty-state panel">
      <i class="bi bi-book"></i>
      <h3>Chưa có cuốn sách nào đang được mượn</h3>
      <p>Khám phá kho sách và chọn một cuốn sách yêu thích.</p>
      <a href="${pageContext.request.contextPath}/books" class="button primary">
        Xem danh sách sách
      </a>
    </div>
  </c:if>
</main>

<footer class="footer"><div><span><i class="bi bi-book-half"></i> Thư Viện Sách</span><p>Kết nối tri thức. Nuôi dưỡng tương lai.</p></div><p>Created by <strong>Ngô Đức Hải</strong><span class="footer-separator"> · </span>24211TT2856</p><span class="footer-year">© 2026 Thư Viện Sách</span></footer></div><script src="${pageContext.request.contextPath}/static/app.js"></script></body></html>
