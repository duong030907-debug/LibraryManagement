<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Đăng Nhập" scope="request"/>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<ui:header title="${pageTitle}"/>

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

<main class="auth-main">
  <a class="auth-back" href="${pageContext.request.contextPath}/books">
    <i class="bi bi-arrow-left"></i>
    Quay về trang chủ
  </a>

  <section class="auth-card">
    <a href="${pageContext.request.contextPath}/books" class="auth-brand">
      <span class="brand-icon">
        <i class="bi bi-book-half"></i>
      </span>
      Thư Viện Sách
    </a>

    <h1>Chào mừng trở lại</h1>
    <p>Đăng nhập để tiếp tục khám phá thế giới sách.</p>

    <form action="${pageContext.request.contextPath}/login" method="post">
      <label>
        Tên đăng nhập
        <input type="text" name="username" required autofocus placeholder="Nhập tên đăng nhập" autocomplete="username"/>
      </label>

      <label>
        Mật khẩu
        <input type="password" name="password" required placeholder="Nhập mật khẩu" autocomplete="current-password"/>
      </label>

      <button class="button primary" type="submit">
        Đăng nhập
        <i class="bi bi-arrow-right"></i>
      </button>
    </form>

    <div class="auth-switch">
      Chưa có tài khoản?
      <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a>
    </div>

    <div class="mockup-note">
      <i class="bi bi-shield-check"></i>
      Tài khoản mặc định: admin / admin123
    </div>
  </section>
</main>

<ui:footer/>
