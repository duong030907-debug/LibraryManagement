<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Quản Lý Người Dùng" scope="request"/>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<ui:header title="${pageTitle}"/>
<ui:navbar/>

<main class="main-container">
  <div class="breadcrumb">
    <i class="bi bi-house-door"></i>
    <span>/</span>
    <span>Người dùng</span>
  </div>

  <div class="page-heading">
    <div>
      <div class="eyebrow">QUẢN LÝ THƯ VIỆN</div>
      <h1>Quản lý người dùng</h1>
      <p>Quản lý thành viên và phân quyền truy cập thư viện (${fn:length(users)} tài khoản).</p>
    </div>
  </div>

  <div class="table-panel">
    <table>
      <thead>
        <tr>
          <th>Người dùng</th>
          <th>Username</th>
          <th>Email</th>
          <th>Vai trò</th>
          <th>Trạng thái</th>
          <th class="align-right">Hành động</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="u" items="${users}">
          <tr>
            <td>
              <div class="user-cell">
                <span class="avatar pale">
                  ${fn:substring(u.fullName, 0, 2)}
                </span>
                <strong><c:out value="${u.fullName}"/></strong>
                <c:if test="${sessionScope.currentUser.id eq u.id}">
                  <small class="muted">(bạn)</small>
                </c:if>
              </div>
            </td>
            <td><c:out value="${u.username}"/></td>
            <td><c:out value="${empty u.email ? '—' : u.email}"/></td>
            <td>
              <c:choose>
                <c:when test="${u.role eq 'ADMIN'}">
                  <span class="pill blue">ADMIN</span>
                </c:when>
                <c:when test="${u.role eq 'LIBRARIAN'}">
                  <span class="pill amber">LIBRARIAN</span>
                </c:when>
                <c:otherwise>
                  <span class="pill green">MEMBER</span>
                </c:otherwise>
              </c:choose>
            </td>
            <td>
              <c:choose>
                <c:when test="${u.active}">
                  <span class="pill green">Hoạt động</span>
                </c:when>
                <c:otherwise>
                  <span class="pill gray">Đã khóa</span>
                </c:otherwise>
              </c:choose>
            </td>
            <td class="align-right">
              <div style="display:inline-flex;align-items:center;gap:6px;flex-wrap:wrap;justify-content:flex-end;">
                <a href="${pageContext.request.contextPath}/admin/users/${u.id}/history" class="text-button">
                  <i class="bi bi-clock-history"></i> Lịch sử mượn
                </a>
                <c:if test="${sessionScope.currentUser.admin}">
                  <c:if test="${u.role eq 'STUDENT'}">
                    <form action="${pageContext.request.contextPath}/admin/users/${u.id}/promote" method="post" style="margin:0;display:inline;">
                      <button type="submit" class="icon-button" title="Thăng lên Thủ thư">
                        <i class="bi bi-arrow-up-circle"></i>
                      </button>
                    </form>
                  </c:if>
                  <c:if test="${u.role eq 'LIBRARIAN'}">
                    <form action="${pageContext.request.contextPath}/admin/users/${u.id}/demote" method="post" style="margin:0;display:inline;">
                      <button type="submit" class="icon-button" title="Hạ xuống Thành viên">
                        <i class="bi bi-arrow-down-circle"></i>
                      </button>
                    </form>
                  </c:if>
                  <c:if test="${u.role ne 'ADMIN' and u.active}">
                    <form action="${pageContext.request.contextPath}/admin/users/${u.id}/delete" method="post"
                          style="margin:0;display:inline;" onsubmit="return confirm('Vô hiệu hóa tài khoản này?')">
                      <button type="submit" class="icon-button danger" title="Vô hiệu hóa tài khoản">
                        <i class="bi bi-person-x"></i>
                      </button>
                    </form>
                  </c:if>
                </c:if>
              </div>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</main>

<ui:footer/>
