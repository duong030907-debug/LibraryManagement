<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Đăng Ký Tài Khoản" scope="request"/>
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

    <h1>Bắt đầu hành trình tri thức</h1>
    <p>Tạo tài khoản mới và khám phá thư viện.</p>

    <form action="${pageContext.request.contextPath}/register" method="post">
      <label>
        Họ và tên
        <input type="text" name="fullName" required placeholder="Nguyễn Văn A" autocomplete="name"/>
      </label>

      <label>
        Tên đăng nhập
        <input type="text" name="username" required minlength="3" maxlength="50" placeholder="Nhập tên đăng nhập (tối thiểu 3 ký tự)" autocomplete="username"/>
      </label>

      <label>
        Email
        <input type="email" name="email" placeholder="you@example.com" autocomplete="email"/>
      </label>

      <label>
        Mật khẩu
        <input type="password" name="password" required minlength="6" placeholder="Nhập mật khẩu (tối thiểu 6 ký tự)" autocomplete="new-password"/>
      </label>

      <button class="button primary" type="submit">
        Đăng ký
        <i class="bi bi-arrow-right"></i>
      </button>
    </form>

    <div class="auth-switch">
      Đã có tài khoản?
      <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
    </div>

    <div class="mockup-note">
      <i class="bi bi-shield-check"></i>
      Thư Viện Sách &middot; Kết nối tri thức
    </div>
  </section>
</main>

<ui:footer/>
