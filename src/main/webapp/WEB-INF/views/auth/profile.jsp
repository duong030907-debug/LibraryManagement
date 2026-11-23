<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Thông Tin Tài Khoản" scope="request"/>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<ui:header title="${pageTitle}"/>
<ui:navbar/>

<main class="main-container">
  <div class="breadcrumb">
    <i class="bi bi-house-door"></i>
    <span>/</span>
    <span>Tài khoản</span>
  </div>

  <div class="page-heading">
    <div>
      <div class="eyebrow">TÀI KHOẢN CỦA BẠN</div>
      <h1>Thông tin tài khoản</h1>
      <p>Thông tin cá nhân và quyền truy cập của bạn.</p>
    </div>
  </div>

  <section class="profile-panel panel">
    <span class="avatar large">${fn:substring(account.fullName, 0, 2)}</span>
    <h2><c:out value="${account.fullName}"/></h2>
    <c:choose>
      <c:when test="${account.role eq 'ADMIN'}">
        <span class="pill blue">ADMIN</span>
      </c:when>
      <c:when test="${account.role eq 'LIBRARIAN'}">
        <span class="pill amber">LIBRARIAN</span>
      </c:when>
      <c:otherwise>
        <span class="pill green">MEMBER</span>
      </c:otherwise>
    </c:choose>

    <dl>
      <div>
        <dt>ID</dt>
        <dd>#${account.id < 10 ? '00' : (account.id < 100 ? '0' : '')}${account.id}</dd>
      </div>
      <div>
        <dt>Username</dt>
        <dd><c:out value="${account.username}"/></dd>
      </div>
      <div>
        <dt>Email</dt>
        <dd><c:out value="${empty account.email ? 'Chưa cập nhật' : account.email}"/></dd>
      </div>
      <div>
        <dt>Vai trò</dt>
        <dd>
          <c:choose>
            <c:when test="${account.role eq 'ADMIN'}">Quản trị viên</c:when>
            <c:when test="${account.role eq 'LIBRARIAN'}">Thủ thư</c:when>
            <c:otherwise>Thành viên</c:otherwise>
          </c:choose>
        </dd>
      </div>
      <div>
        <dt>Ngày tham gia</dt>
        <dd>${account.createdAt}</dd>
      </div>
    </dl>

    <div style="display:flex;justify-content:center;gap:12px;flex-wrap:wrap;">
      <a href="${pageContext.request.contextPath}/borrow/history" class="button soft">
        <i class="bi bi-clock-history"></i>
        Lịch sử mượn của tôi
      </a>
      <a href="${pageContext.request.contextPath}/logout" class="button secondary">
        <i class="bi bi-box-arrow-right"></i>
        Đăng xuất
      </a>
    </div>
  </section>
</main>

<ui:footer/>
